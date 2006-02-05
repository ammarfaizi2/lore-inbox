Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751199AbWBESmT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751199AbWBESmT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Feb 2006 13:42:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751219AbWBESmR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Feb 2006 13:42:17 -0500
Received: from rwcrmhc11.comcast.net ([216.148.227.151]:13774 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S1751199AbWBESmP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Feb 2006 13:42:15 -0500
Message-ID: <43E64702.9020205@namesys.com>
Date: Sun, 05 Feb 2006 10:42:10 -0800
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041217
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: hugh@veritas.com, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org, lee.schermerhorn@hp.com,
       Reiserfs-Dev@namesys.com, vs <vs@thebsh.namesys.com>
Subject: Re: Fw: Re: [PATCH] 2.6.16-rc-mm4 reiser4 calls try_to_unmap() with
 1 arg -- now takes 2
References: <20060205003039.3067e43c.akpm@osdl.org>	<43E5BB2E.5000203@namesys.com> <20060205011152.7f9b7aa9.akpm@osdl.org>
In-Reply-To: <20060205011152.7f9b7aa9.akpm@osdl.org>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

>Hans Reiser <reiser@namesys.com> wrote:
>  
>
>>Umm, no, copy on capture needs to get enabled again as soon as we get
>> past issues outsiders care about, and start dealing again with improving
>> the code in the ways we think matter.  There are real problems that are
>> addressed by copy on capture.  That it has not been worked on since
>> 2.6.5 just sadly indicates how successful folks have been in distracting
>> us for so long.
>>    
>>
>
>Dinking with rmap internals from within a filesystem is a real problem. 
>Whatever needs to be done there should be done within core MM if it's done
>anywhere so it actually gets maintained by the people who are likely to
>break it.
>
>Something like
>http://kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.13-rc4/2.6.13-rc4-mm1/broken-out/add-page-becoming-writable-notification.patch
>might be what you're after.
>
>
>
>  
>
I don't actually care (at least I desire that I not have to care ;-) )
about the implementation of copy-on-capture so long as it works.  I am
sure vs will be happy to do it within core mm when we get to where he
can pay attention to it again.
