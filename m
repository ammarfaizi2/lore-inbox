Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932260AbWCJVNq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932260AbWCJVNq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Mar 2006 16:13:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932267AbWCJVNq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Mar 2006 16:13:46 -0500
Received: from smtp-out.google.com ([216.239.45.12]:14259 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP id S932260AbWCJVNp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Mar 2006 16:13:45 -0500
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:message-id:date:from:user-agent:
	x-accept-language:mime-version:to:cc:subject:references:in-reply-to:
	content-type:content-transfer-encoding;
	b=CG1yamW/S981hZk6Xoaj6ilO9mWTV/dNGtJlFrBPRFLm3fl3UwATP8TXZ+I4JP29h
	LqdtkcICqT/6cHemgpt6w==
Message-ID: <4411EBF3.2010007@google.com>
Date: Fri, 10 Mar 2006 13:13:23 -0800
From: Daniel Phillips <phillips@google.com>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051011)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Zach Brown <zach.brown@oracle.com>
CC: Mark Fasheh <mark.fasheh@oracle.com>, ocfs2-devel@oss.oracle.com,
       linux-kernel@vger.kernel.org
Subject: Re: [Ocfs2-devel] Ocfs2 performance
References: <4408C2E8.4010600@google.com>	<20060303233617.51718c8e.akpm@osdl.org>	<440B9035.1070404@google.com>	<20060306025800.GA27280@ca-server1.us.oracle.com>	<440BC1C6.1000606@google.com>	<20060306195135.GB27280@ca-server1.us.oracle.com>	<p733bhvgc7f.fsf@verdi.suse.de>	<20060307045835.GF27280@ca-server1.us.oracle.com>	<440FCA81.7090608@google.com>	<20060310002121.GJ27280@ca-server1.us.oracle.com> <44116057.5060705@google.com> <4411C42F.9080908@oracle.com>
In-Reply-To: <4411C42F.9080908@oracle.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zach Brown wrote:
>>Pretty close race - vmalloc is slightly faster if anything.
> 
> I don't think that test tells us anything interesting about the relative
> load on the TLB.  What would be interesting is seeing the effect
> vmalloc()ed hashes have on a concurrently running load that puts heavy
> pressure on the TLB.

Bzip2 isn't that kind of load?

Regards,

Daniel
