Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265301AbUHJNmb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265301AbUHJNmb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 09:42:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266345AbUHJNkj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 09:40:39 -0400
Received: from mailhub.fokus.fraunhofer.de ([193.174.154.14]:53137 "EHLO
	mailhub.fokus.fraunhofer.de") by vger.kernel.org with ESMTP
	id S266220AbUHJNWY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 09:22:24 -0400
Date: Tue, 10 Aug 2004 15:21:36 +0200 (CEST)
From: Joerg Schilling <schilling@fokus.fraunhofer.de>
Message-Id: <200408101321.i7ADLalX014098@burner.fokus.fraunhofer.de>
To: mrmacman_g4@mac.com, schilling@fokus.fraunhofer.de
Cc: linux-kernel@vger.kernel.org
Subject: Re: PATCH: cdrecord: avoiding scsi device numbering for ide devices
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From: Kyle Moffett <mrmacman_g4@mac.com>

>On Aug 10, 2004, at 08:46, Joerg Schilling wrote:
>> Your statements are correct for programs that include locale support.

>Programs that do not support locales _must_ restrict themselves to
>7-bit ASCII, or they are likely to break any number of things by 
>outputting
>invalid characters to the terminal.  You could quite easily replace the 
>(C)
>symbol with the string "Copyright", or you could pick a more complicated
>solution by actually implementing locales, but you should change the
>behavior of cdrecord, as that is broken/buggy.

Guess what happens when you call

	find . -type f -exec grep © {} +

on the cdrtools root dir?

Inform yourself before posting.



Jörg

-- 
 EMail:joerg@schily.isdn.cs.tu-berlin.de (home) Jörg Schilling D-13353 Berlin
       js@cs.tu-berlin.de		(uni)  If you don't have iso-8859-1
       schilling@fokus.fraunhofer.de	(work) chars I am J"org Schilling
 URL:  http://www.fokus.fraunhofer.de/usr/schilling ftp://ftp.berlios.de/pub/schily
