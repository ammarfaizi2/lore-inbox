Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262472AbSLTQdK>; Fri, 20 Dec 2002 11:33:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262492AbSLTQdK>; Fri, 20 Dec 2002 11:33:10 -0500
Received: from imap.gmx.net ([213.165.65.60]:32863 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S262472AbSLTQdJ>;
	Fri, 20 Dec 2002 11:33:09 -0500
From: Felix Seeger <felix.seeger@gmx.de>
To: Dave Jones <davej@codemonkey.org.uk>
Subject: Re: Next round of AGPGART fixes.
Date: Fri, 20 Dec 2002 17:41:05 +0100
User-Agent: KMail/1.5.9
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
References: <20021220124137.GA28068@suse.de> <200212201542.48221.felix.seeger@gmx.de>
In-Reply-To: <200212201542.48221.felix.seeger@gmx.de>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200212201741.05692.felix.seeger@gmx.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Freitag 20 Dezember 2002 15:42 schrieb Felix Seeger:
> Am Freitag 20 Dezember 2002 13:41 schrieb Dave Jones:
> > Linus,
> >  Please pull from bk://linux-dj.bkbits.net/agpgart to get at the
> > following fixes..
> >
> > - AGP 3.0 now compiles as a module too.
> > - beginnings of VIA KT400 AGP 3.0 support.
> >   (Not functional yet, more work needed).
> > - corrected handling of AGP capability bit in PCI headers for chipset
> > drivers. This should fix the problems on I815 and similar chipsets.
>
> [...]
>
> > 		Dave
>
> I am running 2.5.52bk5 with you GNU patch. Doesn't help.
> I do a modprobe i810 and I get:
>
> FATAL: Error inserting i810
> (/lib/modules/2.5.52bk5/kernel/drivers/char/drm/i810.ko): Cannot allocate
> memory
>
Mhm, I compiled all in the kernel and it works now, maybe I've done something 
wrong.

thanks
have fun
Felix
