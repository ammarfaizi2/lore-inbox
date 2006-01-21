Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750783AbWAUJpJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750783AbWAUJpJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Jan 2006 04:45:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750772AbWAUJpJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Jan 2006 04:45:09 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:53478 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1750783AbWAUJpI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Jan 2006 04:45:08 -0500
Date: Sat, 21 Jan 2006 10:45:06 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Alex Davis <alex14641@yahoo.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [BUG] DVD assigned wrong SCSI level when using SCSI emulation
In-Reply-To: <20060120223819.29415.qmail@web50210.mail.yahoo.com>
Message-ID: <Pine.LNX.4.61.0601211044390.21704@yvahk01.tjqt.qr>
References: <20060120223819.29415.qmail@web50210.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>I've noticed that since I upgraded to 2.6.15, my IDE DVD ROM
>is assigned a bogus SCSI level. Here is output from /proc/scsi/scsi:

You are not using ide-scsi, are you?


>Host: scsi0 Channel: 00 Id: 00 Lun: 00
>  Vendor: HL-DT-ST Model: DVD-ROM GDR8082N Rev: 0106
>  Type:   CD-ROM                           ANSI SCSI revision: 0xffffffff
>
>Here's what I get with 2.6.8.1:
>
>Host: scsi0 Channel: 00 Id: 00 Lun: 00
>  Vendor: HL-DT-ST Model: DVD-ROM GDR8082N Rev: 0106
>  Type:   CD-ROM                           ANSI SCSI revision: 02


Jan Engelhardt
-- 
