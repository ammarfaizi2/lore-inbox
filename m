Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266477AbUJAUcB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266477AbUJAUcB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Oct 2004 16:32:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266511AbUJAUbX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Oct 2004 16:31:23 -0400
Received: from rosesmtp01.adp.com ([170.146.91.25]:57096 "EHLO
	rosesmtp01.adp.com") by vger.kernel.org with ESMTP id S266477AbUJAU1m
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Oct 2004 16:27:42 -0400
X-Server-Uuid: C1AF40A8-8026-4479-A29E-3A5B974B0AC3
Message-ID: <2D1DF9BA9166D61188F30002B3A6E15318E4D803@ROSEEXCHMA>
From: Daniel_Weigert@adp.com
Reply-to: dlw@taco.com
To: linux-kernel@vger.kernel.org
Subject: Compaq RA4X00 raid array
Date: Fri, 1 Oct 2004 16:27:17 -0400
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2657.72)
X-WSS-ID: 6D43623F1L812599517-01-01
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 01 Oct 2004 20:31:15.0721 (UTC) FILETIME=[997DEF90:01C4A7F5]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Apparently, the only way to attach the Compaq RA4000, or RA4100 array to a
linux box is through their
"66Mhz 64bit Fibre Channel card".  I have several of these boxes, and would
love to make use of them with a modern Fibre Channel card family such as the
Emulex LightPulse.  There is an alpha quality LightPulse 
driver hosted on SourceForge for the 2.6  kernel that I'm quite happy with.
:-)  I can even see the 
controller of the RA4000 with it.  I can't, however, see LUN's that array
has.  The array shows up as a type 12 SCSI device.  There is another driver,
for the above mentioned "66Mhz 64bit Fibre Channel card" that works quite
well for >>ONLY<< that card, and if I use the Compaq card and driver, the
LUN magically becomes visible as a SCSI device.  In my round about fashion,
I'm wondering if it is possible to get the bits of the diver for the Compaq
card broken out into a separate driver, which would make it possible to 
talk to the RAID controller with my Emulex card.  I'd rather have everything
on one SAN.

Dan Weigert
dlw@taco.com


