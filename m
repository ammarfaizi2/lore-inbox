Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261410AbTCTLzt>; Thu, 20 Mar 2003 06:55:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261412AbTCTLzt>; Thu, 20 Mar 2003 06:55:49 -0500
Received: from sarge.hbedv.com ([217.11.63.11]:65180 "EHLO sarge.hbedv.com")
	by vger.kernel.org with ESMTP id <S261410AbTCTLzs>;
	Thu, 20 Mar 2003 06:55:48 -0500
Date: Thu, 20 Mar 2003 13:06:46 +0100
From: Wolfram Schlich <wolfram@schlich.org>
To: Linux-Kernel mailinglist <linux-kernel@vger.kernel.org>
Subject: Re: Hardlocks with 2.4.21-pre5, pdc202xx_new (PDC20269) and shared IRQs
Message-ID: <20030320120646.ALLYOURBASEAREBELONGTOUS.E4264@bla.fasel.org>
Mail-Followup-To: Linux-Kernel mailinglist <linux-kernel@vger.kernel.org>
References: <20030320072259.ALLYOURBASEAREBELONGTOUS.E6336@bla.fasel.org> <OAEPKDBINGEGKPCJJAJDKEBDJIAA.chris.newland@emorphia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OAEPKDBINGEGKPCJJAJDKEBDJIAA.chris.newland@emorphia.com>
User-Agent: Mutt/1.4i
Organization: Axis of Weasel(s)
X-Complaints-To: bla@fasel.org
X-IRC: wschlich at irc.freenode.net
X-Messenger: ICQ: 35713642, MSN: bla@fasel.org, YIM: wolfram_schlich, AIM: wolframschlich
X-Registered-Linux-User: 187858 (http://counter.li.org)
X-Warning: E-Mail may contain unsmilyfied humor and/or satire.
X-What-Happen: Somebody set up us the bomb.
X-Accept-Language: de, en, fr
X-GPG-Key: 0xCD4DF205 (http://wolfram.schlich.org/wschlich.asc, x-hkp://wwwkeys.de.pgp.net)
X-GPG-Fingerprint: 39EC 98CA 4130 E59A 1041  AD06 D3A1 C51D CD4D F205
X-Editor: VIM - Vi IMproved 6.1 (2002 Mar 24, compiled Mar 24 2002 15:02:51)
X-Face: |P()Q^fx-{=,K-3g?5@Id4o|o{Xf_5v:z3WIhR3fOW-$,*=[#[Qq<,@P!OsXbR|i6n=]B<3mzGC++F@K#wvoLEnIZuTR6wPCMQfxq!';9w[TiP3Bhz"r&$7eGFq7us@Z5Qd$3W[3W3:U7biTNZgf"<]LqwS
X-Operating-System: Linux prometheus 2.4.21-pre5-grsec-1.9.9c #3 SMP Thu Mar 20 00:10:58 CET 2003 i686 unknown
X-Uptime: 1:05pm up 4:27, 2 users, load average: 0.11, 0.05, 0.01
X-AntiVirus: checked by AntiVir MailGate (version: 2.0.1.9; AVE: 6.18.0.3; VDF: 6.18.0.18; host: mx.bla.fasel.org)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Chris Newland <chris.newland@emorphia.com> [2003-03-20 11:25]:
> Hi Wolfram,

Hi!

> I had the same hardlock problem with dual athlons, MSI K7D Master, Promise
> TX2000 (PDC20271) with 2 HDDs on RAID0 on the Promise card and only a CDROM
> on the onboard IDE channel.
> 
> It used to lock hard (2.4.18 vanilla kernel) on 'tar' when using a USB mouse
> but I haven't had a single lockup since plugging in a PS2 mouse :)
> 
> PS. Whilst 2.4 kernels run fine for me, I can't get any 2.5 kernel to run
> yet.
> 
> I get a VFS kernel panic on bootup (can't mount root device).
> 
> I've installed Rusty's 2.5 modutils and tried compiling the 20271 driver
> both into the kernel and as a module.
> 
> I read in Dave Jones' post-halloween notes that the Promise drivers are
> broken:
> 
> <quote>
> - The hptraid/promise RAID drivers are currently non functional, and
>   will probably be converted to use device-mapper.
> </quote>
> 
> Is this still true?

I have no idea... I'm not using:
a) A Promise RAID controller (just the dumb ones)
b) Kernel 2.5
:-)
-- 
Mit freundlichen Gruessen / Yours sincerely
Wolfram Schlich; Friedhofstr. 8, D-88069 Tettnang; +49-(0)178-SCHLICH
