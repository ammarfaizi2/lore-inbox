Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262840AbTDAU02>; Tue, 1 Apr 2003 15:26:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262852AbTDAU01>; Tue, 1 Apr 2003 15:26:27 -0500
Received: from [195.39.17.254] ([195.39.17.254]:9476 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S262840AbTDAU01>;
	Tue, 1 Apr 2003 15:26:27 -0500
Date: Tue, 1 Apr 2003 22:25:44 +0200
From: Pavel Machek <pavel@suse.cz>
To: John Levon <levon@movementarian.org>
Cc: "Martin J. Bligh" <mbligh@aracnet.com>, torvalds@transmeta.com,
       Andrew Morton <akpm@zip.com.au>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Convert APIC to driver model: now it works with SMP
Message-ID: <20030401202544.GD122@elf.ucw.cz>
References: <20030330193026.GA29499@elf.ucw.cz> <14730000.1049180682@[10.10.2.4]> <20030401153852.GA24356@compsoc.man.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030401153852.GA24356@compsoc.man.ac.uk>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > arch/i386/oprofile/nmi_int.c:102: warning: initialization from incompatible pointer type
> > arch/i386/oprofile/nmi_int.c: In function `init_nmi_driverfs':
> > arch/i386/oprofile/nmi_int.c:129: warning: control reaches end of non-void function
> 
> Can you try Mikael's (preferable) patch ?

Well, that patch broke as soon as you enabled oprofile (last time I
checked).
								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
