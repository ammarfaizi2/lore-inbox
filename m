Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312171AbSCUANz>; Wed, 20 Mar 2002 19:13:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312308AbSCUANp>; Wed, 20 Mar 2002 19:13:45 -0500
Received: from [208.48.139.185] ([208.48.139.185]:4270 "HELO
	forty.greenhydrant.com") by vger.kernel.org with SMTP
	id <S312306AbSCUANk>; Wed, 20 Mar 2002 19:13:40 -0500
Date: Wed, 20 Mar 2002 16:13:34 -0800
From: David Rees <dbr@greenhydrant.com>
To: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.19-pre4
Message-ID: <20020320161334.A28267@greenhydrant.com>
Mail-Followup-To: David Rees <dbr@greenhydrant.com>,
	lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.21.0203201757560.9129-100000@freak.distro.conectiva> <Pine.LNX.4.30.0203210000440.4385-100000@mustard.heime.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 21, 2002 at 12:01:31AM +0100, Roy Sigurd Karlsbakk wrote:
> 
> it's good with a nice and detailed changelog - but ... I'd be grateful to
> see a nice little summary at the top.
> 
> On Wed, 20 Mar 2002, Marcelo Tosatti wrote:
> 
<snip>
>
> > Summary of changes from v2.4.19-pre2 to v2.4.19-pre3
> > ============================================
> >
> > <marcelo@plucky.distro.conectiva> (02/03/13 1.162)
> > 	- -ac merge (including new IDE)                         (Alan Cox)
> > 	- S390 merge                                            (IBM)
> > 	- More cciss fixes                                      (Stephen Cameron)
> > 	- Eicon SMP race fix                                    (Armin Schindler)
> > 	- w9966 driver update                                   (Jakob Kemi)
> > 	- Unify crc32 routine (removes lots of duplicated
> > 	  code from drivers)                                    (Matt Domsch)
> > 	- Lanstreamer bugfixes                                  (Kent Yoder)
> > 	- Update scsi_debug                                     (Douglas Gilbert)
> > 	- MCE Configure.help update                             (Paul Gortmaker)
> > 	- Fix SMB NLS oops                                      (Urban Widmark)
> > 	- AGP Config.in update                                  (Daniele Venzano)
> > 	- Fix small thinko in UFS set_blocksize return handling (me)
> > 	- Avoid unecessary cache flushes on PPC                 (Paul Mackerras)
> > 	- PPP deadlock fixes                                    (Paul Mackerras)
> > 	- Signal changes for thread groups                      (Dave McCracken)
> > 	- Make max_threads be based on normal zone size         (Dave McCracken)
> > 	- ray_cs wireless extension fix                         (Jean Tourrilhes)
> > 	- irda bugfixes and enhancements                        (Jean Tourrilhes)
> > 	- USB update                                            (Greg KH)
> > 	- Fix through-8259A mode for IRQ0 routing on APIC       (Maciej W. Rozycki/Joe Korty)
> > 	- Add Dell Inspiron 2500 to broken APM blacklist        (Arjan van de Ven)
> > 	- Fix off-by-one error in bluesmoke                     (Dave Jones)
> > 	- Reiserfs update                                       (Oleg Drokin)
> > 	- Fix PCI compile without /proc support                 (Eric Sandeen)
> > 	- Fix problem with bad inode handling                   (Alexander Viro)
> > 	- aic7xxx update                                        (Justin T. Gibbs)
> > 	- Do not consider SCSI recovered errors as fatal errors (Justin T. Gibbs)
> > 	- Add Memory-Write-Invalidate support to PCI            (Jeff Garzik)
> > 	- Starfire update                                       (Ion Badulescu)
> > 	- tulip update                                          (Jeff Garzik)
> >
> >
> > Summary of changes from v2.4.19-pre1 to v2.4.19-pre2
> > ============================================
> >
> > <marcelo@plucky.distro.conectiva> (02/03/13 1.161)
> > 	- -ac merge                                             (Alan Cox)
> > 	- Huge MIPS/MIPS64 merge                                (Ralf Baechle)
> > 	- IA64 update                                           (David Mosberger)
> > 	- PPC update                                            (Tom Rini)
> > 	- Shrink struct page                                    (Rik van Riel)
> > 	- QNX4 update (now its able to mount QNX 6.1 fses)      (Anders Larsen)
> > 	- Make max_map_count sysctl configurable                (Christoph Hellwig)
> > 	- matroxfb update                                       (Petr Vandrovec)
> > 	- ymfpci update                                         (Pete Zaitcev)
> > 	- LVM update                                            (Heinz J . Mauelshagen)
> > 	- btaudio driver update                                 (Gerd Knorr)
> > 	- bttv update                                           (Gerd Knorr)
> > 	- Out of line code cleanup                              (Keith Owens)
> > 	- Add watchdog API documentation                        (Christer Weinigel)
> > 	- Rivafb update                                         (Ani Joshi)
> > 	- Enable PCI buses above quad0 on NUMA-Q                (Martin J. Bligh)
> > 	- Fix PIIX IDE slave PCI timings                        (Dave Bogdanoff)
> > 	- Make PLIP work again                                  (Tim Waugh)
> > 	- Remove unecessary printk from lp.c                    (Tim Waugh)
> > 	- Make parport_daisy_select work for ECP/EPP modes      (Max Vorobiev)
> > 	- Support O_NONBLOCK on lp/ppdev correctly              (Tim Waugh)
> > 	- Add PCI card hooks to parport                         (Tim Waugh)
> > 	- Compaq cciss driver fixes                             (Stephen Cameron)
> > 	- VFS cleanups and fixes                                (Alexander Viro)
> > 	- USB update (including USB 2.0 support)                (Greg KH)
> > 	- More jiffies compare cleanups                         (Tim Schmielau)
> > 	- PCI hotplug update                                    (Greg KH)
> > 	- bluesmoke fixes                                       (Dave Jones)
> > 	- Fix off-by-one in ide-scsi                            (John Fremlin)
> > 	- Fix warnings in make xconfig                          (René Scharfe)
> > 	- Make x86 MCE a configure option                       (Paul Gortmaker)
> > 	- Small ramdisk fixes                                   (Christoph Hellwig)
> > 	- Add missing atime update to pipe code                 (Christoph Hellwig)
> > 	- Serialize microcode access                            (Tigran Aivazian)
> > 	- AMD Elan handling on serial.c                         (Robert Schwebel)

The summary was there, just at the bottom of the email.

-Dave
