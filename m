Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261364AbTI3MAJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Sep 2003 08:00:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261368AbTI3MAJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Sep 2003 08:00:09 -0400
Received: from mailhub.fokus.fraunhofer.de ([193.174.154.14]:28856 "EHLO
	mailhub.fokus.fraunhofer.de") by vger.kernel.org with ESMTP
	id S261364AbTI3MAC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Sep 2003 08:00:02 -0400
Date: Tue, 30 Sep 2003 13:57:24 +0200 (CEST)
From: Joerg Schilling <schilling@fokus.fraunhofer.de>
Message-Id: <200309301157.h8UBvOcd004345@burner.fokus.fraunhofer.de>
To: axboe@suse.de, schilling@fokus.fraunhofer.de
Cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel includefile bug not fixed after a year :-(
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>From axboe@suse.de  Tue Sep 30 13:54:12 2003

>> >> Is there no interest in user applications for kernel features or is there just
>> >> no kernel maintainer left over who makes the needed work?
>> 
>> >/usr/include/scsi/scsi.h looks fine on my system, probably also on
>> >yours. You should not include kernel headers in your user space program.
>> 
>> Looks like you did not understand the background :-(

>I think I do.

Sorry, but you just verified that you don't :-(

>> In order to use kernel interfaces you _need_ to include kernel include
>> files.

>False. You need to include the glibc kernel headers.


False: as glibc kernel headers are not part of the kernel distribution.

>> This is in particular true as long as we are talking about
>> beta/testing kernels.
>> 
>> 
>> Background: on homogeneous platforms like e.g. Solaris or FreeBSD
>> which are maintained and distributed as whole, an _enduser_ should
>> include files from /usr/include only. 
>> 
>> 	This is not even true for people who do Solaris or FreeBSD
>> 	kernel development and like to test new features with user level
>> 	programs.  It is definitely not true for compilations against
>> 	Linux kernel interfaces.
>> 
>> Linux is not a homogeneous system. There is a separately developed
>> kernel and a separate base user level system. People often install a
>> newer kernel and need to recompile software because the kernel/user
>> interfaces are not stable between different Linux releases.

>That's a pretty bold claim, when did the kernel/user interface break? A
>lot of care is usually taken to ensure that this does not happen.

>This subject has been debated to death lots of times before, I'm sure
>the archives are more detailed and enlightening that I am.

If these debates have not been done in a serious way, or people without
the needed kernel development background knowledge did decide, these
debates are just void.

Jörg

-- 
 EMail:joerg@schily.isdn.cs.tu-berlin.de (home) Jörg Schilling D-13353 Berlin
       js@cs.tu-berlin.de		(uni)  If you don't have iso-8859-1
       schilling@fokus.fraunhofer.de	(work) chars I am J"org Schilling
 URL:  http://www.fokus.fraunhofer.de/usr/schilling ftp://ftp.berlios.de/pub/schily
