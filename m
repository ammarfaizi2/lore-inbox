Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314602AbSFEEiQ>; Wed, 5 Jun 2002 00:38:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317542AbSFEEiP>; Wed, 5 Jun 2002 00:38:15 -0400
Received: from c207-202-243-179.sea1.cablespeed.com ([207.202.243.179]:27189
	"EHLO darklands.zimres.net") by vger.kernel.org with ESMTP
	id <S314602AbSFEEiN>; Wed, 5 Jun 2002 00:38:13 -0400
Date: Tue, 4 Jun 2002 21:31:34 -0700
From: Thomas Zimmerman <thomas@zimres.net>
To: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.19-pre10
Message-ID: <20020605043133.GB676@zimres.net>
Reply-To: Thomas <thomas@zimres.net>
Mail-Followup-To: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0206032152510.4716-100000@freak.distro.conectiva>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vOmOzSkFvhd7u8Ms"
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Operating-System: Linux lightlands 2.4.19-pre8-ac5
X-Operating-Status: 20:33:56 up  2:09,  1 user,  load average: 0.31, 0.31, 0.26
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--vOmOzSkFvhd7u8Ms
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

I just *like* the lk-changlog.pl output so much I can't keep it to my
self...
$./lk-changelog.pl --mode=terse --width=68 2.4.19-pre10.log; #other
versions edited out;
-------------------------------------------------------------------
So here goes, now hopefully the last pre :)



Summary of changes from v2.4.19-pre9 to v2.4.19-pre10
============================================

  o doc typos                                             (Alan Cox)
  o Handle old Dec boxes with misconfigured scsi          (Alan Cox)
  o Fix SIGURG strict standards compliance                (Alan Cox)
  o Fix a misuse of copy_from_user                        (Alan Cox)
  o copy_user fix for S/390                               (Alan Cox)
  o second copy_user fix for S/390                        (Alan Cox)
  o copy_user fixes for s390x                             (Alan Cox)
  o clean up copy_user in paride, and unused var          (Alan Cox)
  o fix copy_user in swim3                                (Alan Cox)
  o fix copy_user in macIIfx floppies                     (Alan Cox)
  o fixup illegal C in umem                               (Alan Cox)
  o ; serial copy_user fixes                              (Alan Cox)
  o machz watchdog copy_user fixes                        (Alan Cox)
  o mxser copy_user fixes                                 (Alan Cox)
  o fix sigio on tty drivers outgoing                     (Alan Cox)
  o enable the tty sigio fix on pty                       (Alan Cox)
  o resync pcwd with 2.5 fixes                            (Alan Cox)
  o fix stallion and sx copy_user                         (Alan Cox)
  o hotplug requires pci                                  (Alan Cox)
  o fix tpqic02 copy_user                                 (Alan Cox)
  o fix backward copies in joydev                         (Alan Cox)
  o acenic new card                                       (Alan Cox)
  o iph5526 fix from maintainer                           (Alan Cox)
  o delete all the usercrap that accidentally got in      (Alan Cox)
  o sdla_fr nipquad fixes                                 (Alan Cox)
  o web page moved                                        (Alan Cox)
  o maintainer updated for aha152x                        (Alan Cox)
  o qlogic panic fix                                      (Alan Cox)
  o scsi copy_user fixes                                  (Alan Cox)
  o ; blacklist update                                    (Alan Cox)
  o fix possible leak of kernel data                      (Alan Cox)
  o sgi serial fix for copy_user                          (Alan Cox)
  o add $CONFIG_PCI and fix sound texts                   (Alan Cox)
  o more ac97 updates                                     (Alan Cox)
  o fix isapnp ad1848                                     (Alan Cox)
  o more copy_user                                        (Alan Cox)
  o add intel ICH4                                        (Alan Cox)
  o and more copy_user (blame acme and rusty)             (Alan Cox)
  o mpu401 clean and leak fix                             (Alan Cox)
  o fix region leak                                       (Alan Cox)
  o yet another SB                                        (Alan Cox)
  o fix ali crash on 6 channel capable chip with cheap codec
                                                          (Alan Cox)
  o more copy_user                                        (Alan Cox)
  o make this defined C                                   (Alan Cox)
  o intermezzo copy_user                                  (Alan Cox)
  o mapping fix                                           (Alan Cox)
  o take signal lock before looking at signals in proc    (Alan Cox)
  o better fix for fs/ufs - add printk levels             (Alan Cox)
  o sisfb updates - been in -ac for ages                  (Alan Cox)
  o mkspec improvements                                   (Alan Cox)
  o tcp_input.c: Really make sure rto = 3*rtt, found by Pasi
    Sarolahti                                     (Alexey Kuznetsov)
  o tcp_recvmsg: Fix application bug induced races with MSG_PEEK
    and copied_seq                                (Alexey Kuznetsov)
  o net/sched fixes                               (Alexey Kuznetsov)
  o ipv6 raw fixes                                (Alexey Kuznetsov)
  o Renames struct bus_type to struct de4x5_bus_type in de4x5 net
    driver,                                      (Anders Gustafsson)
  o Janitor: add __devinit markers to two net drivers, epic100 and
    sundance                                          (Andrey Panin)
  o PPC: Add support for 750FX CPU          (Benjamin Herrenschmidt)
  o PPC: Fix /proc/irq duplicate entries    (Benjamin Herrenschmidt)
  o PPC: Pmac support update                (Benjamin Herrenschmidt)
  o PPC: Fix warning                        (Benjamin Herrenschmidt)
  o PPC: Fix dmasound with KDE              (Benjamin Herrenschmidt)
  o /proc/slab fix                                (Benjamin LaHaise)
  o net/core/sock.c: Fix typo in sysctl_{w,m}mem_default init
                                                      (Chris Caputo)
  o IPv4 Syncookies: Remove pointless CONFIG_SYN_COOKIES ifdef
                                                 (Christoph Hellwig)
  o Thread group exit problem reappeared            (Dave McCracken)
  o Add full duplex support to 3c509 net driver     (David Ruggiero)
  o net/core/neighbour.c: Delete ancient ASSERT_WL debugging
                                                   (David S. Miller)
  o tcp_ipv4.c: Do not increment TcpAttemptFails twice
                                                   (David S. Miller)
  o Ingress packet scheduler: Fix compiler error when
    CONFIG_NET_CLS_POLICE is disabled              (David S. Miller)
  o IPv4: Make pkt_too_big debug msg more informative
                                                   (David S. Miller)
  o Tigon3: Fix typo in netgear ga320t support changes
                                                   (David S. Miller)
  o Update Sparc{,64} ide_fix_driveid              (David S. Miller)
  o dl2k gige net driver update                        (Edward Peng)
  o Fix pcnet32 net driver workaround for xSeries250  (Go Taniguchi)
  o Tigon3 fix                                      (Grant Grundler)
  o sstfb update : P0-Revert                    (gtoumi@laposte.net)
  o sstfb update : P1-Alpha                     (gtoumi@laposte.net)
  o sstfb update : P2-pci                       (gtoumi@laposte.net)
  o sstfb update : P3-indent                    (gtoumi@laposte.net)
  o sstfb update : P4-fbinfo                    (gtoumi@laposte.net)
  o sstfb update : P5-Multihead                 (gtoumi@laposte.net)
  o sstfb update : P6-VidMod                    (gtoumi@laposte.net)
  o sstfb update : P7-misc                      (gtoumi@laposte.net)
  o sstfb update : P8-checks                    (gtoumi@laposte.net)
  o Netfilter ipt_ULOG fix                            (Harald Welte)
  o Minor fixes to the via-rhine net driver
                                     (ivangurdiev@linuxfreemail.com)
  o ips 4.90.18 build fix                              (Jack Hammer)
  o Tigon3: Handle Netgear GA302T correctly           (James Morris)
  o 2.4.19-pre9  Coda update                            (Jan Harkes)
  o Add new "comet" pci id to tulip net driver         (Jeff Garzik)
  o Update mii generic phy driver to properly report link status
                                                       (Jeff Garzik)
  o Fix phy id masking in 8139too net driver           (Jeff Garzik)
  o Merge 2.5.x additions to linux/ethtool.h           (Jeff Garzik)
  o revert 3c59x                                       (Jeff Garzik)
  o tulip net driver 2114x phy init fix              (Juan Quintela)
  o kernel-api.* compilation fix                     (Juan Quintela)
  o Fix oops-able situation in 3c509 net driver      (Kasper Dupont)
  o 2.4.19-pre9 USB Makefile                           (Keith Owens)
  o request_region janitor cleanup for pcnet32 net driver,
                                                (maalanen@ra.abo.fi)
  o Remove change which could break userlevel apps (Marcelo Tosatti)
  o Changed EXTRAVERSION to pre10                  (Marcelo Tosatti)
  o cs89x0 net driver minor fixes, SH4 support, and cmd line media
    support                                         (Oskar Schirmer)
  o eepro100 net driver trivial cleanup               (Pavel Machek)
  o IPV4: Add statistics for route cache GC monitoring
                                                     (Robert Olsson)
  o Cosmetic cleanups, remove unused struct members from via-rhine
    net driver                                        (Roger Luethi)
  o Trivial 2.4.19-pre9: asm/io.h in mm/bootmem.c    (Rusty Russell)
  o Trivial 2.4.19-pre9: ipchains compat kmalloc flags
                                                     (Rusty Russell)
  o Trivial 2.4.19-pre9: typo in fs/dcache.c         (Rusty Russell)
  o Trivial 2.4.19-pre9: SUSv2 semctl compliance     (Rusty Russell)
  o Trivial 2.4.19-pre9: drivers/net/pcnet32.c       (Rusty Russell)
  o Trivial 2.4.19-pre9: binfmt_misc setbit bug      (Rusty Russell)
  o Trivial 2.4.19-pre9: CREDITS ordering            (Rusty Russell)
  o Trivial 2.4.19-pre9: DMA documentation fix       (Rusty Russell)
  o Trivial 2.4.19-pre9: header comment fix          (Rusty Russell)
  o Trivial 2.4.19-pre9: check_region from           (Rusty Russell)
  o Trivial 2.4.19-pre9: check_region in drivers/atm/horizon.c
                                                     (Rusty Russell)
  o Trivial 2.4.19-pre9: check_region in paride      (Rusty Russell)
  o Trivial 2.4.19-pre9: normalize slab names        (Rusty Russell)
  o Trivial but vitally important patch              (Rusty Russell)
  o Tigon3: Add Netgear GA320T support                (Simon Burley)
  o Add to list of supported 8139 net boards
                                          (skyrelighten@yahoo.co.kr)
  o request_region janitor cleanup for rtc char driver
                                                   (William Stinson)

--vOmOzSkFvhd7u8Ms
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE8/ZQlUHPW3p9PurIRAlcMAJ92u6DcN3Lx1EOKvYqNUynQEJWI6QCeNlRO
oQ+nZpYnY7RXk1ZF4YKiEs8=
=ZO/A
-----END PGP SIGNATURE-----

--vOmOzSkFvhd7u8Ms--
