Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130017AbRCFJNO>; Tue, 6 Mar 2001 04:13:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130032AbRCFJNE>; Tue, 6 Mar 2001 04:13:04 -0500
Received: from office.mandrakesoft.com ([195.68.114.34]:45821 "EHLO
	office.mandrakesoft.com") by vger.kernel.org with ESMTP
	id <S130017AbRCFJM5>; Tue, 6 Mar 2001 04:12:57 -0500
Message-Id: <200103060912.KAA09397@office.mandrakesoft.com>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Linux 2.4.2ac12
To: linux-kernel@vger.kernel.org
Date: Mon Mar  5 22:01:08 2001 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


        ftp://ftp.kernel.org/pub/linux/kernel/people/alan/2.4/

2.4.2-ac12
o       Move the pci_enable_device for cardbus          (David Hinds)
o       Add Sony MSC-U01N to the unusual devices        (Marcel
Holtmann)
o       Final smc-mca fixups - should now work          (James
Bottomley)
o       Document kernel string/mem* functions           (Tim Waugh)
        | and I added a memcpy warning
o       Update VIA IDE driver to 3.21                   (Vojtech
Pavlik)
        |No UDMA66 on 82c686, fix /proc and udma on
        |686b, fix dma disables
o       Allow sleeping in ctrl-alt-del callbacks        (Andrew
Morton)
        |Fix i2o, dac960, watchdog, gdth hangs on exit
o       Fix binfmt_misc (and make the proc handling     (Al Viro)
        |a filesystem -
        |mount -t binfmt_misc none /proc/sys/fs/binfmt_misc
o       Update the ACI support for sound/radio stuff    (Robert
Siemer)
o       Add RDS support to miroRadio                    (Robert
Siemer)
o       Remove serverworks handling. The BIOS is our    (me)
        best (and right now only) hope for that chip
o       Tune the vm behavioru a bit more                (Mike
Galbraith)
o       Update PAS16 documentation                      (Thomas
Molina)
o       Reiserfs tools recommended are now 0d not 0b    (Steven Cole)
o       Wan driver small fixes                          (Jeff Garzik)
o       Net driver fixes for 3c503, 3c509, 3c515,       (Jeff Garzik)
        8139too, de4x5, defxx, dgrs, dmfe, eth16i, 
        ewrk3, natsemi, ni5010, pci-skeleton, rcpci45,
        sis900, sk_g16, smc-ultra, sundance, tlan,
        via-rhine, winbond-840, yellowfin, wavelan_cs
        tms380tr
o       Trim 3K off the aha1542 driver size     (Andrzej
Krzysztofowicz)
o       Trim 1K off qlogicfas                   (Andrzej
Krzysztofowicz)
o       Fix openfirmware/mm boot on ppc                 (Cort Dougan)
o       Fix topdir handling in Makefile                 (Keith Owens)
o       Minor fusion driver updates                     (Steve
Ralston)
o       Merge Etrax cris updates                        (Bjorn Wesen)
o       Clgen fb copyright update                       (Jeff Garzik)
o       AGP linkage fix                                 (Jeff Garzik)
o       Update visor driver to work with minijam        (Arnim
Laeuger)
o       Fix a usb devio return code                     (Dan
Streetman)
o       Resync a few other net device changes with the
        submits Jeff sent to Linus                      (Jeff Garzik)
o       Add missing md export symbol                    (Mohammad
Haque)

2.4.2-ac11
o       Fix NLS Config.in                               (David
Weinehall)
o       Sort out one escaped revert from the megaraid   (me)
        update
o       Resync with Linux 2.4.3pre1
        | Except tulip the network driver changes have
        | been used to replace the existing ones
o       Fix parport case where a reader could get stuck (Tim Waugh)
o       Add ALi15x3 to the list of isa dma hangs        (Angelo Di
Filippo)
o       Fix nasty bug in IPX routing of netbios frames  (Arnaldo
Carvalho
                                                         de Melo)
o       Misc code cleanups                              (Keith Owens)
o       Updated 3c527 driver                            (Richard
Proctor)
o       Further tulip updates                           (Jeff Garzik)
o       i810_rng fixes (FIPS test, regions)             (Jeff Garzik)
To: kernel@mandrakesoft.com
Subject: [PPC] ALSA support
X-URL: <http://www.linux-mandrake.com/
Organization: MandrakeSoft
Message-ID: <m1pufvqmt2.fsf@vador.mandrakesoft.com>
Lines: 3
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
--text follows this line--

since 0.9beta2, ALSA suppport imac, ibook and a third one (i don't
remember its name).

