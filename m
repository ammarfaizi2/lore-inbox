Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262994AbTDBM5Z>; Wed, 2 Apr 2003 07:57:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262995AbTDBM5Z>; Wed, 2 Apr 2003 07:57:25 -0500
Received: from meryl.it.uu.se ([130.238.12.42]:46209 "EHLO meryl.it.uu.se")
	by vger.kernel.org with ESMTP id <S262994AbTDBM5Y>;
	Wed, 2 Apr 2003 07:57:24 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16010.57535.281723.305868@gargle.gargle.HOWL>
Date: Wed, 2 Apr 2003 15:08:15 +0200
From: mikpe@csd.uu.se
To: Pavel Machek <pavel@suse.cz>
Cc: John Levon <levon@movementarian.org>,
       "Martin J. Bligh" <mbligh@aracnet.com>, torvalds@transmeta.com,
       Andrew Morton <akpm@zip.com.au>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Convert APIC to driver model: now it works with SMP
In-Reply-To: <20030401202544.GD122@elf.ucw.cz>
References: <20030330193026.GA29499@elf.ucw.cz>
	<14730000.1049180682@[10.10.2.4]>
	<20030401153852.GA24356@compsoc.man.ac.uk>
	<20030401202544.GD122@elf.ucw.cz>
X-Mailer: VM 6.90 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek writes:
 > Hi!
 > 
 > > > arch/i386/oprofile/nmi_int.c:102: warning: initialization from incompatible pointer type
 > > > arch/i386/oprofile/nmi_int.c: In function `init_nmi_driverfs':
 > > > arch/i386/oprofile/nmi_int.c:129: warning: control reaches end of non-void function
 > > 
 > > Can you try Mikael's (preferable) patch ?
 > 
 > Well, that patch broke as soon as you enabled oprofile (last time I
 > checked).

John wrote that the latest works for him, with oprofile enabled.
Maybe he fixed some detail, I haven't compared it with mine yet.
