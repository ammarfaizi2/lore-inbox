Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279783AbRKMWqA>; Tue, 13 Nov 2001 17:46:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279790AbRKMWpu>; Tue, 13 Nov 2001 17:45:50 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:26381 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S279783AbRKMWpl>; Tue, 13 Nov 2001 17:45:41 -0500
Subject: Re: PATCH: scsi_scan.c: emulate windows behavior
To: mdharm-kernel@one-eyed-alien.net (Matthew Dharm)
Date: Tue, 13 Nov 2001 22:52:43 +0000 (GMT)
Cc: torvalds@transmeta.com (Linus Torvalds),
        alan@lxorguk.ukuu.org.uk (Alan Cox),
        linux-kernel@vger.kernel.org (Kernel Developer List)
In-Reply-To: <20011113102106.A23110@one-eyed-alien.net> from "Matthew Dharm" at Nov 13, 2001 10:21:06 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E163mQ7-0002b8-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Attached is a one-liner patch to scsi_scan.c, which changes the length of
> the INQUIRY data request from 255 bytes to 36 bytes.  This subtle change
> makes Linux act more like Win/MacOS and other popular OSes, and reduces
> incompatibility with a broad range of out-of-spec devices that will simply
> die if asked for more than the required minimum of 36 bytes.

It breaks sane, it breaks some cd burning tools. We really need all of it
I think
