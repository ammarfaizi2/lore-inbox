Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287317AbSAXLKo>; Thu, 24 Jan 2002 06:10:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287333AbSAXLKe>; Thu, 24 Jan 2002 06:10:34 -0500
Received: from AMontpellier-201-1-1-52.abo.wanadoo.fr ([193.252.31.52]:33018
	"EHLO microsoft.com") by vger.kernel.org with ESMTP
	id <S287332AbSAXLKX>; Thu, 24 Jan 2002 06:10:23 -0500
Subject: Re: umounting
From: Xavier Bestel <xavier.bestel@free.fr>
To: Samuel Maftoul <maftoul@esrf.fr>
Cc: Oliver.Neukum@lrz.uni-muenchen.de, lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20020124005223.A23933@pcmaftoul.esrf.fr>
In-Reply-To: <20020122150703.B13509@pcmaftoul.esrf.fr>
	<16T6BH-1ZiPWiC@fwd07.sul.t-online.com>
	<20020123090614.A18262@pcmaftoul.esrf.fr>
	<16TVAs-0xKiHYC@fwd10.sul.t-online.com> 
	<20020124005223.A23933@pcmaftoul.esrf.fr>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.1 
Date: 24 Jan 2002 10:22:27 +0100
Message-Id: <1011864149.17679.11.camel@nomade>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There was a suggestion some time ago (yeah I know, that was RMS) to have
a special mode for "surprise-removal" filesystems: when starting a write
operation on the device, always complete it such as if unmounted by
surprise, the fs is still valid.
This is not quite like a journaled fs I think, because it ought to work
with any fs (e.g. vfat because most if not all removable
disks/floppies/CF/flash-card-du-jour are formatted like this).

Well, I think this should be looked at.


