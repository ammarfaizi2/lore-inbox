Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264614AbSJ3He0>; Wed, 30 Oct 2002 02:34:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264615AbSJ3He0>; Wed, 30 Oct 2002 02:34:26 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:55053 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S264614AbSJ3HeZ>;
	Wed, 30 Oct 2002 02:34:25 -0500
Message-ID: <3DBF8CD5.1030306@pobox.com>
Date: Wed, 30 Oct 2002 02:40:05 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: dcinege@psychosis.com
CC: landley@trommello.org, linux-kernel@vger.kernel.org, reiser@namesys.com,
       alan@lxorguk.ukuu.org.uk, davem@redhat.com, boissiere@adiglobal.com
Subject: Re: Abbott and Costello meet Crunch Time -- Penultimate 2.5 merge
 candidate list.
References: <200210272017.56147.landley@trommello.org> <200210300229.44865.dcinege@psychosis.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Cinege wrote:

>On Sunday 27 October 2002 21:17, Rob Landley wrote:
>  
>
>>This is the next to last posting of this list.  (When abbott and costello
>>meet the monster, its time is almost up.)  There will be at most one more,
>>tomorrow, and it may just be a repost of this cc'd to Linus.  (Those
>>of you waiting for the last minute, this would be it.)
>>    
>>
>
>Knock off initramfs off...I'll be posting something that
>supercedes it (IMO) within the next 72 hours.
>
>Aside from providing full untar suppprt, it DRAMATICALLY
>cleans up do_mounts.c and moves all the initrd code that was
>there to initrd.c. Infact I pretty much entirly rewrote initrd,
>so it makes sense. (purging prehistoric junk, etc.)
>  
>

lol

untar - cpio is better.
initrd - 99% moved out of the kernel
do_mounts - moved out of the kernel completely
initramfs - should be ready for Linus in the next day or so.

None of that junk -- and a whole lot more -- needs to be in the kernel 
at all.

    Jeff




