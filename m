Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932181AbWEAR6A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932181AbWEAR6A (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 May 2006 13:58:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932187AbWEAR6A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 May 2006 13:58:00 -0400
Received: from smtp-out.google.com ([216.239.45.12]:16849 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP id S932181AbWEAR57
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 May 2006 13:57:59 -0400
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:message-id:date:from:user-agent:
	x-accept-language:mime-version:to:cc:subject:references:in-reply-to:
	content-type:content-transfer-encoding;
	b=vz4cpSH70+pSGChrUwVZUMk0H3O3ZuK3Uxltpg8MlYvZE87mjji2RfGoPgl3yX8LJ
	Wpp12sAwsKVX0nVA6kmzQ==
Message-ID: <44564BEC.1040803@google.com>
Date: Mon, 01 May 2006 10:57:00 -0700
From: Martin Bligh <mbligh@google.com>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051011)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Badari Pulavarty <pbadari@us.ibm.com>
CC: Andrew Morton <akpm@osdl.org>, apw@shadowen.org, linuxppc64-dev@ozlabs.org,
       lkml <linux-kernel@vger.kernel.org>, ak@suse.de
Subject: Re: 2.6.17-rc2-mm1
References: <4450F5AD.9030200@google.com>	 <20060428012022.7b73c77b.akpm@osdl.org> <44561A1E.7000103@google.com>	 <20060501100731.051f4eff.akpm@osdl.org>	 <1146503960.317.1.camel@dyn9047017100.beaverton.ibm.com>	 <445644B7.7060807@google.com> <1146506105.317.4.camel@dyn9047017100.beaverton.ibm.com>
In-Reply-To: <1146506105.317.4.camel@dyn9047017100.beaverton.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Badari Pulavarty wrote:
> On Mon, 2006-05-01 at 10:26 -0700, Martin Bligh wrote:
> 
>>>I ran mtest01 multiple times with various options on my 4-way AMD64 box.
>>>So far couldn't reproduce the problem (2.6.17-rc3-mm1).
>>>
>>>Are there any special config or test options you are testing with ?
>>
>>Config is here:
>>
>>http://ftp.kernel.org/pub/linux/kernel/people/mbligh/config/abat/amd64
>>
>>It's just doing "runalltests", I think.
> 
> 
> FWIW, I tried your config file on my 4-way AMD64 (melody) box 
> and ran latest "mtest01" fine.
> 
> I am now trying runalltests. I guess, its time to bi-sect :(

There was a panic on PPC64 during LTP too, but it seems to have gone
away with rc3-mm1. Not sure if it was really fixed, or just intermittent.

http://test.kernel.org/abat/29675/debug/console.log

M.
