Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261480AbTCTOYj>; Thu, 20 Mar 2003 09:24:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261482AbTCTOYj>; Thu, 20 Mar 2003 09:24:39 -0500
Received: from sarge.hbedv.com ([217.11.63.11]:44446 "EHLO sarge.hbedv.com")
	by vger.kernel.org with ESMTP id <S261480AbTCTOYh>;
	Thu, 20 Mar 2003 09:24:37 -0500
Date: Thu, 20 Mar 2003 15:35:37 +0100
From: Wolfram Schlich <lists@schlich.org>
To: Linux-Kernel mailinglist <linux-kernel@vger.kernel.org>
Subject: Re: Hardlocks with 2.4.21-pre5, pdc202xx_new (PDC20269) and shared IRQs
Message-ID: <20030320143537.ALLYOURBASEAREBELONGTOUS.L4264@bla.fasel.org>
Mail-Followup-To: Linux-Kernel mailinglist <linux-kernel@vger.kernel.org>
References: <20030319221608.ALLYOURBASEAREBELONGTOUS.A29767@bla.fasel.org> <1048124539.647.18.camel@irongate.swansea.linux.org.uk> <20030320072259.ALLYOURBASEAREBELONGTOUS.E6336@bla.fasel.org> <1048172263.2408.21.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1048172263.2408.21.camel@irongate.swansea.linux.org.uk>
User-Agent: Mutt/1.4i
Organization: Axis of Weasel(s)
X-Accept-Language: de, en, fr
X-GPG-Key: 0xCD4DF205 (http://wolfram.schlich.org/wschlich.asc, x-hkp://wwwkeys.de.pgp.net)
X-GPG-Fingerprint: 39EC 98CA 4130 E59A 1041  AD06 D3A1 C51D CD4D F205
X-Editor: VIM - Vi IMproved 6.1 (2002 Mar 24, compiled Mar 24 2002 15:02:51)
X-Face: |P()Q^fx-{=,K-3g?5@Id4o|o{Xf_5v:z3WIhR3fOW-$,*=[#[Qq<,@P!OsXbR|i6n=]B<3mzGC++F@K#wvoLEnIZuTR6wPCMQfxq!';9w[TiP3Bhz"r&$7eGFq7us@Z5Qd$3W[3W3:U7biTNZgf"<]LqwS
X-Operating-System: Linux prometheus 2.4.21-pre5-grsec-1.9.9c #3 SMP Thu Mar 20 00:10:58 CET 2003 i686 unknown
X-Uptime: 3:31pm up 6:54, 9 users, load average: 0.08, 0.10, 0.03
X-AntiVirus: checked by AntiVir MailGate (version: 2.0.1.9; AVE: 6.18.0.3; VDF: 6.18.0.18; host: mx.bla.fasel.org)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Alan Cox <alan@lxorguk.ukuu.org.uk> [2003-03-20 14:51]:
> On Thu, 2003-03-20 at 07:22, Wolfram Schlich wrote:
> > Well, now I have trashed my array :-)
> > -> http://marc.theaimsgroup.com/?l=linux-raid&m=104811878405765&w=2
> > 
> > Btw., it spits out *lots* of messages when IRQ sharing is *disabled*
> > in the kernel config and just dies quietly when it's *enabled*
> > (having it dying before didn't mess up my array... ;)).
> 
> I'll take a look. I have no promise docs however so there is little that
> can be done for promise specific bugs if it looks that way.

Should I contact some guy at Promise regarding that issue?

> > ?! I'm using the onboard IDE for two CDROM drives and one smaller
> > hard disk which I use rarely... and I didn't use any of these devices
> > in the cases in which I had the described problems... Anyway, why should I
> > connect a PS/2 mouse to the machine? Is it gonna solve all my
> > problems at once? ;-)
> 
> Probably not, but it will avoid a lockup with IDE DMA in a specific case

This only affects onboard IDE usage?
Argh, I start to hate this AMD-MP stuff.

Btw., I get these messages from time to time (not often):
--8<--
APIC error on CPU1: 00(02)
APIC error on CPU0: 00(02)
--8<--
Should I boot with "noapic" or "disableapic"? But I guess this is
another issue...
-- 
Wolfram Schlich; Friedhofstr. 8, D-88069 Tettnang; +49-(0)178-SCHLICH
