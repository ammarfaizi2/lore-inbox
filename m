Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751882AbWCJSX6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751882AbWCJSX6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Mar 2006 13:23:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751934AbWCJSX6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Mar 2006 13:23:58 -0500
Received: from rgminet01.oracle.com ([148.87.113.118]:37558 "EHLO
	rgminet01.oracle.com") by vger.kernel.org with ESMTP
	id S1751882AbWCJSX5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Mar 2006 13:23:57 -0500
Message-ID: <4411C42F.9080908@oracle.com>
Date: Fri, 10 Mar 2006 10:23:43 -0800
From: Zach Brown <zach.brown@oracle.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Daniel Phillips <phillips@google.com>
CC: Mark Fasheh <mark.fasheh@oracle.com>, ocfs2-devel@oss.oracle.com,
       linux-kernel@vger.kernel.org
Subject: Re: [Ocfs2-devel] Ocfs2 performance
References: <4408C2E8.4010600@google.com>	<20060303233617.51718c8e.akpm@osdl.org>	<440B9035.1070404@google.com>	<20060306025800.GA27280@ca-server1.us.oracle.com>	<440BC1C6.1000606@google.com>	<20060306195135.GB27280@ca-server1.us.oracle.com>	<p733bhvgc7f.fsf@verdi.suse.de>	<20060307045835.GF27280@ca-server1.us.oracle.com>	<440FCA81.7090608@google.com>	<20060310002121.GJ27280@ca-server1.us.oracle.com> <44116057.5060705@google.com>
In-Reply-To: <44116057.5060705@google.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Pretty close race - vmalloc is slightly faster if anything.

I don't think that test tells us anything interesting about the relative
load on the TLB.  What would be interesting is seeing the effect
vmalloc()ed hashes have on a concurrently running load that puts heavy
pressure on the TLB.

- z

