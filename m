Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266570AbUHINhN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266570AbUHINhN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 09:37:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266569AbUHINhN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 09:37:13 -0400
Received: from mailhub.fokus.fraunhofer.de ([193.174.154.14]:41634 "EHLO
	mailhub.fokus.fraunhofer.de") by vger.kernel.org with ESMTP
	id S266561AbUHINgw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 09:36:52 -0400
Date: Mon, 9 Aug 2004 15:36:13 +0200 (CEST)
From: Joerg Schilling <schilling@fokus.fraunhofer.de>
Message-Id: <200408091336.i79DaDBo010343@burner.fokus.fraunhofer.de>
To: axboe@suse.de, schilling@fokus.fraunhofer.de
Cc: James.Bottomley@steeleye.com, linux-kernel@vger.kernel.org
Subject: Re: PATCH: cdrecord: avoiding scsi device numbering for ide devices
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>From: Jens Axboe <axboe@suse.de>

>On Mon, Aug 09 2004, Joerg Schilling wrote:
>> >From axboe@suse.de  Fri Aug  6 17:10:35 2004
>> 
>> >> Let me give you a short answer: If DMA creates so many problem on Linux,
>> >> how about imlementing a generic DMA abstraction layer like Solaris does?
>> 
>> >We do have that. But suddenly changing the alignment and length
>> >restrictions on issuing dma to a device in the _end_ of a stable series
>> >does not exactly fill me with joyful expectations. It's simply that,
>> >not lack of infrastructure.
>> 
>> If you _really_ _had_ a DMA abstraction layer, then ide-scsi would use
>> DMA for all sector sizes a CD may have. The fact that ide-scsi does
>> not use DMA easily proves that you are wrong.

>For someone who apparently doesn't even bother to look at the source,
>it's hard to discuss these things. "DMA abstraction layer" continues
>your fine history of being deliberatly vague in that it can mean
>basically anything or nothing.

In case you don't know what DMA abstraction is:

DMA abstraction includes everything that is going to be done to set up
DMA after the buffer address and the size is known.

If you were true and Linux would include _and_ use DMA abstraction, then
we would have DMA with ide-scsi for all CD sector sizes.


>> AGAIN: if you believe you did invent a better method, _describe_ it.
>> As you did not describe a _working_ method different from the one I
>> request, you need to agree that you are wrong - as long as your
>> description is missing.

>I did not invent a better method, but one exists - in Linux this is the
>device special file.

Interesting: tell us more about how Linux handles kernel user interfaces by 
using a device special file instead of including the same include file 
in the kernel code as well as in the applicatin code?

>> I am able to distinct between something that only looks like a kernel
>> problem and something that really is a kernel problem. As long as you

>You've already shown that statement to be false many times in this
>thread.

YOu have only shown that you in many caes try to ignoore the truth ;-(


>Listen, you silly little man: if you want things fixed in the kernel,
>you provide a patch. Understand that concept?

Listen arrogant little man: I have enough to to with writing free software.
I report bugs and if you are the author, you fix your bugs or I need to tell
the users of your software that you are unwilling to maintain your software.

Jörg

-- 
 EMail:joerg@schily.isdn.cs.tu-berlin.de (home) Jörg Schilling D-13353 Berlin
       js@cs.tu-berlin.de		(uni)  If you don't have iso-8859-1
       schilling@fokus.fraunhofer.de	(work) chars I am J"org Schilling
 URL:  http://www.fokus.fraunhofer.de/usr/schilling ftp://ftp.berlios.de/pub/schily
