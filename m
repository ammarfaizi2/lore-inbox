Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270489AbTGSE0x (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Jul 2003 00:26:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270491AbTGSE0x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Jul 2003 00:26:53 -0400
Received: from [202.94.238.145] ([202.94.238.145]:59873 "EHLO
	mail.shaolinmicro.com") by vger.kernel.org with ESMTP
	id S270489AbTGSE0u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Jul 2003 00:26:50 -0400
Message-ID: <3F18CBF9.1040400@shaolinmicro.com>
Date: Sat, 19 Jul 2003 12:41:29 +0800
From: David Chow <davidchow@shaolinmicro.com>
Organization: Shaolin Microsystems Ltd.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.2) Gecko/20030208 Netscape/7.02
X-Accept-Language: zh_TW, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: David Howells <dhowells@redhat.com>,
       Trond Myklebust <trond.myklebust@fys.uio.no>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-fsdevel@vger.kernel.org, Andrew Morton <akpm@digeo.com>
Subject: Re: [PATCH] General filesystem cache
References: <Pine.LNX.4.44.0307182000300.6370-100000@home.osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Is it a file system or a patch to the VFS? I love to see this patch. It 
is quite useful for me. Is it available for 2.4?

David Chow

Linus Torvalds wrote:

>On Fri, 18 Jul 2003, David Howells wrote:
>  
>
>>Here's a patch to add a quasi-filesystem ("CacheFS") that turns a block device
>>into a general cache for any other filesystem that cares to make use of its
>>facilities.
>>
>>This is primarily intended for use with my AFS filesystem, but I've designed
>>it such that it needs to know nothing about the filesystem it's backing, and
>>so it may also be useful for NFS, SMB and ISO9660 for example.
>>    
>>
>
>Ok. Sounds good. In fact, it's something I've wanted for a while, since 
>it's also potentially the solution to performance-critical things like 
>virtual filesystems based on revision control logic etc (traditionally 
>done with fake NFS servers).
>
>I did a very very quick scan, and didn't see anything that raised my 
>hackles. But it's late in the 2.6.x game, and as a result I'm not going to 
>apply it until I get a lot of feedback from actual users too.
>  
>


