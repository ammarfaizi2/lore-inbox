Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263555AbUHMLqR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263555AbUHMLqR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Aug 2004 07:46:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263761AbUHMLqR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Aug 2004 07:46:17 -0400
Received: from mailhub.fokus.fraunhofer.de ([193.174.154.14]:10907 "EHLO
	mailhub.fokus.fraunhofer.de") by vger.kernel.org with ESMTP
	id S263555AbUHMLqP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Aug 2004 07:46:15 -0400
Date: Fri, 13 Aug 2004 13:45:16 +0200 (CEST)
From: Joerg Schilling <schilling@fokus.fraunhofer.de>
Message-Id: <200408131145.i7DBjGkS023641@burner.fokus.fraunhofer.de>
To: davidsen@tmr.com, timw@splhi.com
Cc: James.Bottomley@steeleye.com, axboe@suse.de, linux-kernel@vger.kernel.org,
       mj@ucw.cz, schilling@fokus.fraunhofer.de
Subject: Re: PATCH: cdrecord: avoiding scsi device numbering for ide devices
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From davidsen@tmr.com  Thu Aug 12 23:08:49 2004

>But they *don't* map to consistent device names. All hot pluggable 
>devices seem to map to the next available name. Looking at one of my 
>utility systems, it has IDE drives mapped by Redhat with ide-scsi, real 
>SCSI drives, a couple of flash card slots mapped to SCSI, and a USB 
>device, all in the /dev/sdX namespace. And in the order in which they 
>were detected (connected, in other words).

Install Solaris and try to replug a USB writer - you will see the same
address as before.

>Joerg hasn't made it any better, but it isn't great anyway. I recommend 
>a script to do discovery and make symlinks somewhere to names which 
>always match the same device.

Being forced to base on a weak grounding does not make the layers above
bad if they only don't work because of the bad grounding.


Jörg

-- 
 EMail:joerg@schily.isdn.cs.tu-berlin.de (home) Jörg Schilling D-13353 Berlin
       js@cs.tu-berlin.de		(uni)  If you don't have iso-8859-1
       schilling@fokus.fraunhofer.de	(work) chars I am J"org Schilling
 URL:  http://www.fokus.fraunhofer.de/usr/schilling ftp://ftp.berlios.de/pub/schily
