Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261184AbVFULZK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261184AbVFULZK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 07:25:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261179AbVFULYs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 07:24:48 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:27557 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S261159AbVFULAP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 07:00:15 -0400
From: Denis Vlasenko <vda@ilport.com.ua>
To: Jesper Juhl <juhl-lkml@dif.dk>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] cleanup patches for strings
Date: Tue, 21 Jun 2005 13:59:25 +0300
User-Agent: KMail/1.5.4
Cc: Andrew Morton <akpm@osdl.org>, Jeff Garzik <jgarzik@pobox.com>,
       Domen Puncer <domen@coderock.org>
References: <Pine.LNX.4.62.0506200052320.2415@dragon.hyggekrogen.localhost>
In-Reply-To: <Pine.LNX.4.62.0506200052320.2415@dragon.hyggekrogen.localhost>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200506211359.25632.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 21 June 2005 01:46, Jesper Juhl wrote:
> Hi,
> 
> I have a bunch (few hundred) of oneliners like the ones below lying around 
> on my HD and I'm wondering what the best way to submit them is.

I have 361813 bytes in 292 patches for:

-       printk(KERN_ERR "%s: start receive command failed \n", dev->name);
+       printk(KERN_ERR "%s: start receive command failed\n", dev->name);

type patches. Are these needed?

In case you wonder whether YOUR driver has such things, the list:

total 1264
-rwxr-xr-x  1 root root 15234 Jun 17 00:47 3c359.c.patch
-rwxr-xr-x  1 root root   507 Jun 17 00:47 3c505.c.patch
-rwxr-xr-x  1 root root  1052 Jun 17 00:47 53c7xx.c.patch
-rwxr-xr-x  1 root root   795 Jun 17 00:47 BusLogic.c.patch
-rwxr-xr-x  1 root root   409 Jun 17 00:47 CodingStyle.patch
-rwxr-xr-x  1 root root   695 Jun 17 00:47 NCR5380.c.patch
-rwxr-xr-x  1 root root  1010 Jun 17 00:47 NCR53C9x.c.patch
-rwxr-xr-x  1 root root   447 Jun 17 00:47 acpi_memhotplug.c.patch
-rwxr-xr-x  1 root root  4785 Jun 17 00:47 addRamDisk.c.patch
-rwxr-xr-x  1 root root   716 Jun 17 00:47 af_wanpipe.c.patch
-rwxr-xr-x  1 root root  1383 Jun 17 00:47 aha1542.c.patch
-rwxr-xr-x  1 root root   505 Jun 17 00:47 aha1740.c.patch
-rwxr-xr-x  1 root root   430 Jun 17 00:47 airo.c.patch
-rwxr-xr-x  1 root root  5728 Jun 17 00:47 ali-ircc.c.patch
-rwxr-xr-x  1 root root   468 Jun 17 00:47 ali5451.c.patch
-rwxr-xr-x  1 root root   762 Jun 17 00:47 ali5455.c.patch
-rwxr-xr-x  1 root root   537 Jun 17 00:47 amd64-agp.c.patch
-rwxr-xr-x  1 root root   644 Jun 17 00:47 apm.c.patch
-rwxr-xr-x  1 root root   908 Jun 17 00:47 appldata_mem.c.patch
-rwxr-xr-x  1 root root 11292 Jun 17 00:47 arlan-main.c.patch
-rwxr-xr-x  1 root root  4911 Jun 17 00:47 arlan-proc.c.patch
-rwxr-xr-x  1 root root   899 Jun 17 00:47 ash.c.patch
-rwxr-xr-x  1 root root   549 Jun 17 00:47 atari_NCR5380.c.patch
-rwxr-xr-x  1 root root   815 Jun 17 00:47 ati_remote.c.patch
-rwxr-xr-x  1 root root   442 Jun 17 00:47 atmel_read_eeprom.c.patch
-rwxr-xr-x  1 root root   860 Jun 17 00:47 atp870u.c.patch
-rwxr-xr-x  1 root root  1204 Jun 17 00:47 atyfb_base.c.patch
-rwxr-xr-x  1 root root   463 Jun 17 00:47 au88x0_eq.c.patch
-rwxr-xr-x  1 root root   444 Jun 17 00:47 auth_gss.c.patch
-rwxr-xr-x  1 root root  6581 Jun 17 00:47 av7110_av.c.patch
-rwxr-xr-x  1 root root   414 Jun 17 00:47 aztcd.c.patch
-rwxr-xr-x  1 root root   359 Jun 17 00:47 b44.c.patch
-rwxr-xr-x  1 root root   565 Jun 17 00:47 baycom_ser_fdx.c.patch
-rwxr-xr-x  1 root root   529 Jun 17 00:47 blacklist.c.patch
-rwxr-xr-x  1 root root   947 Jun 17 00:47 bond_main.c.patch
-rwxr-xr-x  1 root root   600 Jun 17 00:47 bt878.c.patch
-rwxr-xr-x  1 root root   503 Jun 17 00:47 bttv-cards.c.patch
-rwxr-xr-x  1 root root   883 Jun 17 00:47 bubinga.c.patch
-rwxr-xr-x  1 root root   769 Jun 17 00:47 cache.c.patch
-rwxr-xr-x  1 root root  1633 Jun 17 00:47 cciss.c.patch
-rwxr-xr-x  1 root root   773 Jun 17 00:47 cciss_scsi.c.patch
-rwxr-xr-x  1 root root   889 Jun 17 00:47 cifssmb.c.patch
-rwxr-xr-x  1 root root 24339 Jun 17 00:47 claw.c.patch
-rwxr-xr-x  1 root root   642 Jun 17 00:47 cls_u32.c.patch
-rwxr-xr-x  1 root root  1529 Jun 17 00:47 config.c.patch
-rwxr-xr-x  1 root root   614 Jun 17 00:47 conmakehash.c.patch
-rwxr-xr-x  1 root root   852 Jun 17 00:47 connect.c.patch
-rwxr-xr-x  1 root root   505 Jun 17 00:47 cpia.c.patch
-rwxr-xr-x  1 root root   480 Jun 17 00:47 cpia.h.patch
-rwxr-xr-x  1 root root   979 Jun 17 00:47 cpqarray.c.patch
-rwxr-xr-x  1 root root  1391 Jun 17 00:47 cpqfcTSinit.c.patch
-rwxr-xr-x  1 root root   523 Jun 17 00:47 cpqfcTSworker.c.patch
-rwxr-xr-x  1 root root   564 Jun 17 00:47 cpqphp.h.patch
-rwxr-xr-x  1 root root  1132 Jun 17 00:47 cpqphp_core.c.patch
-rwxr-xr-x  1 root root  1656 Jun 17 00:47 cpqphp_pci.c.patch
-rwxr-xr-x  1 root root   508 Jun 17 00:47 cpu.c.patch
-rwxr-xr-x  1 root root  4871 Jun 17 00:47 cs4281m.c.patch
-rwxr-xr-x  1 root root  6835 Jun 17 00:47 cs46xx.c.patch
-rwxr-xr-x  1 root root   477 Jun 17 00:47 ctcmain.c.patch
-rwxr-xr-x  1 root root   506 Jun 17 00:47 ctctty.c.patch
-rwxr-xr-x  1 root root   445 Jun 17 00:47 dac3550a.c.patch
-rwxr-xr-x  1 root root   455 Jun 17 00:47 daca.c.patch
-rwxr-xr-x  1 root root   660 Jun 17 00:47 dasd_proc.c.patch
-rwxr-xr-x  1 root root   556 Jun 17 00:47 dbdma.c.patch
-rwxr-xr-x  1 root root  1001 Jun 17 00:47 de4x5.c.patch
-rwxr-xr-x  1 root root   396 Jun 17 00:47 debug.c.patch
-rwxr-xr-x  1 root root   500 Jun 17 00:47 device_status.c.patch
-rwxr-xr-x  1 root root   564 Jun 17 00:47 divamnt.c.patch
-rwxr-xr-x  1 root root   519 Jun 17 00:47 divert_init.c.patch
-rwxr-xr-x  1 root root  1523 Jun 17 00:47 dpt_i2o.c.patch
-rwxr-xr-x  1 root root  2477 Jun 17 00:47 dst.c.patch
-rwxr-xr-x  1 root root   751 Jun 17 00:47 dst_ca.c.patch
-rwxr-xr-x  1 root root   833 Jun 17 00:47 e1000_hw.c.patch
-rwxr-xr-x  1 root root   755 Jun 17 00:47 eata_pio.c.patch
-rwxr-xr-x  1 root root   876 Jun 17 00:47 eepro.c.patch
-rwxr-xr-x  1 root root   553 Jun 17 00:47 eeprom.c.patch
-rwxr-xr-x  1 root root   471 Jun 17 00:47 efi.c.patch
-rwxr-xr-x  1 root root   427 Jun 17 00:47 eisa_enumerator.c.patch
-rwxr-xr-x  1 root root   442 Jun 17 00:47 erase.c.patch
-rwxr-xr-x  1 root root   602 Jun 17 00:47 es7000plat.c.patch
-rwxr-xr-x  1 root root  1177 Jun 17 00:47 exdump.c.patch
-rwxr-xr-x  1 root root   577 Jun 17 00:47 exnames.c.patch
-rwxr-xr-x  1 root root   483 Jun 17 00:47 exresop.c.patch
-rwxr-xr-x  1 root root   506 Jun 17 00:47 fault.c.patch
-rwxr-xr-x  1 root root  1060 Jun 17 00:47 fd1772.c.patch
-rwxr-xr-x  1 root root  1264 Jun 17 00:47 firestream.c.patch
-rwxr-xr-x  1 root root   396 Jun 17 00:47 fixup-rbtx4927.c.patch
-rwxr-xr-x  1 root root   462 Jun 17 00:47 flexcop-sram.c.patch
-rwxr-xr-x  1 root root   550 Jun 17 00:47 flexcop-usb.c.patch
-rwxr-xr-x  1 root root   835 Jun 17 00:47 forte.c.patch
-rwxr-xr-x  1 root root   730 Jun 17 00:47 fpga.c.patch
-rwxr-xr-x  1 root root   532 Jun 17 00:47 fplustm.c.patch
-rwxr-xr-x  1 root root   713 Jun 17 00:47 gdbinit.patch
-rwxr-xr-x  1 root root   502 Jun 17 00:47 gdth.c.patch
-rwxr-xr-x  1 root root   809 Jun 17 00:47 genex.S.patch
-rwxr-xr-x  1 root root   531 Jun 17 00:47 gss_krb5_seal.c.patch
-rwxr-xr-x  1 root root   452 Jun 17 00:47 gss_spkm3_token.c.patch
-rwxr-xr-x  1 root root   865 Jun 17 00:47 gus_mem.c.patch
-rwxr-xr-x  1 root root   410 Jun 17 00:47 hdpu.c.patch
-rwxr-xr-x  1 root root  1066 Jun 17 00:47 hfc_usb.c.patch
-rwxr-xr-x  1 root root   503 Jun 17 00:47 hgafb.c.patch
-rwxr-xr-x  1 root root   553 Jun 17 00:47 hil_mlc.c.patch
-rwxr-xr-x  1 root root   886 Jun 17 00:47 hysdn_init.c.patch
-rwxr-xr-x  1 root root   490 Jun 17 00:47 hysdn_sched.c.patch
-rwxr-xr-x  1 root root  1371 Jun 17 00:47 i2c-algo-ite.c.patch
-rwxr-xr-x  1 root root   935 Jun 17 00:47 i2c-i801.c.patch
-rwxr-xr-x  1 root root   577 Jun 17 00:47 i2c-piix4.c.patch
-rwxr-xr-x  1 root root   697 Jun 17 00:47 i2c-sis5595.c.patch
-rwxr-xr-x  1 root root  1558 Jun 17 00:47 i2o_proc.c.patch
-rwxr-xr-x  1 root root  2741 Jun 17 00:47 i82092.c.patch
-rwxr-xr-x  1 root root   610 Jun 17 00:47 iSeries_proc.c.patch
-rwxr-xr-x  1 root root   631 Jun 17 00:47 iSeries_setup.c.patch
-rwxr-xr-x  1 root root  1880 Jun 17 00:47 ibm_emac_debug.c.patch
-rwxr-xr-x  1 root root  1954 Jun 17 00:47 ibmphp_hpc.c.patch
-rwxr-xr-x  1 root root   507 Jun 17 00:47 ide-cd.c.patch
-rwxr-xr-x  1 root root   543 Jun 17 00:47 idt77252.c.patch
-rwxr-xr-x  1 root root   551 Jun 17 00:47 initio.c.patch
-rwxr-xr-x  1 root root   747 Jun 17 00:47 inode.c.patch
-rwxr-xr-x  1 root root   483 Jun 17 00:47 ip2main.c.patch
-rwxr-xr-x  1 root root  1214 Jun 17 00:47 ip6t_dst.c.patch
-rwxr-xr-x  1 root root  1214 Jun 17 00:47 ip6t_hbh.c.patch
-rwxr-xr-x  1 root root   488 Jun 17 00:47 ip_conntrack_standalone.c.patch
-rwxr-xr-x  1 root root  6600 Jun 17 00:47 iphase.c.patch
-rwxr-xr-x  1 root root   492 Jun 17 00:47 ipmi_bt_sm.c.patch
-rwxr-xr-x  1 root root   701 Jun 17 00:47 ips.c.patch
-rwxr-xr-x  1 root root   446 Jun 17 00:47 ircomm_param.c.patch
-rwxr-xr-x  1 root root   969 Jun 17 00:47 irda-usb.c.patch
-rwxr-xr-x  1 root root   392 Jun 17 00:47 irq.c-10337.patch
-rwxr-xr-x  1 root root   488 Jun 17 00:47 irq.c-9659.patch
-rwxr-xr-x  1 root root   498 Jun 17 00:47 irq.c.patch
-rwxr-xr-x  1 root root  1309 Jun 17 00:47 isdn_concap.c.patch
-rwxr-xr-x  1 root root   542 Jun 17 00:47 isdn_tty.c.patch
-rwxr-xr-x  1 root root   553 Jun 17 00:47 isdn_ttyfax.c.patch
-rwxr-xr-x  1 root root  2888 Jun 17 00:47 isdn_x25iface.c.patch
-rwxr-xr-x  1 root root  2718 Jun 17 00:47 islpci_dev.c.patch
-rwxr-xr-x  1 root root  1404 Jun 17 00:47 islpci_eth.c.patch
-rwxr-xr-x  1 root root  1612 Jun 17 00:47 islpci_mgt.c.patch
-rwxr-xr-x  1 root root   442 Jun 17 00:47 ixj.c.patch
-rwxr-xr-x  1 root root   623 Jun 17 00:47 jedec_probe.c.patch
-rwxr-xr-x  1 root root   499 Jun 17 00:47 jsm_tty.c.patch
-rwxr-xr-x  1 root root   292 Jun 17 00:47 kernel-doc.patch
-rwxr-xr-x  1 root root  9921 Jun 17 00:47 lanstreamer.c.patch
-rwxr-xr-x  1 root root   570 Jun 17 00:47 libata-core.c.patch
-rwxr-xr-x  1 root root   666 Jun 17 00:47 longhaul.c.patch
-rwxr-xr-x  1 root root  2280 Jun 17 00:47 lparcfg.c.patch
-rwxr-xr-x  1 root root   542 Jun 17 00:47 lpfc_scsi.c.patch
-rwxr-xr-x  1 root root   422 Jun 17 00:47 lpfc_sli.c.patch
-rwxr-xr-x  1 root root   576 Jun 17 00:47 m1535plus.c.patch
-rwxr-xr-x  1 root root   756 Jun 17 00:47 m32r_cfc.c.patch
-rwxr-xr-x  1 root root   477 Jun 17 00:47 mac_esp.c.patch
-rwxr-xr-x  1 root root   528 Jun 17 00:47 maple_pci.c.patch
-rwxr-xr-x  1 root root   661 Jun 17 00:47 math.c.patch
-rwxr-xr-x  1 root root   666 Jun 17 00:47 mcdx.c.patch
-rwxr-xr-x  1 root root  1578 Jun 17 00:47 mconsole_kern.c.patch
-rwxr-xr-x  1 root root   434 Jun 17 00:47 md.c.patch
-rwxr-xr-x  1 root root   449 Jun 17 00:47 mdc800.c.patch
-rwxr-xr-x  1 root root   949 Jun 17 00:47 microcode.c.patch
-rwxr-xr-x  1 root root   399 Jun 17 00:47 mkprep.c.patch
-rwxr-xr-x  1 root root   698 Jun 17 00:47 mpic.c.patch
-rwxr-xr-x  1 root root   607 Jun 17 00:47 mpparse.c.patch
-rwxr-xr-x  1 root root  3380 Jun 17 00:47 mptbase.c.patch
-rwxr-xr-x  1 root root  3183 Jun 17 00:47 mptctl.c.patch
-rwxr-xr-x  1 root root  3303 Jun 17 00:47 mptscsih.c.patch
-rwxr-xr-x  1 root root   490 Jun 17 00:47 mtpav.c.patch
-rwxr-xr-x  1 root root  1481 Jun 17 00:47 mv643xx_eth.c.patch
-rwxr-xr-x  1 root root   642 Jun 17 00:47 nand_base.c.patch
-rwxr-xr-x  1 root root   488 Jun 17 00:47 nfs4renewd.c.patch
-rwxr-xr-x  1 root root   453 Jun 17 00:47 nfsproc.c.patch
-rwxr-xr-x  1 root root  5954 Jun 17 00:47 nicstar.c.patch
-rwxr-xr-x  1 root root   896 Jun 17 00:47 nodelist.c.patch
-rwxr-xr-x  1 root root   407 Jun 17 00:47 nsaccess.c.patch
-rwxr-xr-x  1 root root   481 Jun 17 00:47 nsnames.c.patch
-rwxr-xr-x  1 root root 13767 Jun 17 00:47 olympic.c.patch
-rwxr-xr-x  1 root root   478 Jun 17 00:47 omap_udc.c.patch
-rwxr-xr-x  1 root root   419 Jun 17 00:47 parport_amiga.c.patch
-rwxr-xr-x  1 root root   433 Jun 17 00:47 parport_mfc3.c.patch
-rwxr-xr-x  1 root root   417 Jun 17 00:47 pci_link.c.patch
-rwxr-xr-x  1 root root  2319 Jun 17 00:47 pciehp_hpc.c.patch
-rwxr-xr-x  1 root root   511 Jun 17 00:47 pciehp_pci.c.patch
-rwxr-xr-x  1 root root   642 Jun 17 00:47 pcmplc.c.patch
-rwxr-xr-x  1 root root   883 Jun 17 00:47 perfmon.c.patch
-rwxr-xr-x  1 root root   382 Jun 17 00:47 piggyback.c.patch
-rwxr-xr-x  1 root root   586 Jun 17 00:47 pktgen.c.patch
-rwxr-xr-x  1 root root  3349 Jun 17 00:47 pm.c.patch
-rwxr-xr-x  1 root root   348 Jun 17 00:47 ppc4xx_kgdb.c.patch
-rwxr-xr-x  1 root root   443 Jun 17 00:47 ppc4xx_sgdma.c.patch
-rwxr-xr-x  1 root root   485 Jun 17 00:47 proxy.c.patch
-rwxr-xr-x  1 root root   441 Jun 17 00:47 pt.c.patch
-rwxr-xr-x  1 root root   507 Jun 17 00:47 pxa27x.c.patch
-rwxr-xr-x  1 root root   507 Jun 17 00:47 q40ints.c.patch
-rwxr-xr-x  1 root root   808 Jun 17 00:47 q931.c.patch
-rwxr-xr-x  1 root root  1894 Jun 17 00:47 qeth_main.c.patch
-rwxr-xr-x  1 root root  3912 Jun 17 00:47 qla1280.c.patch
-rwxr-xr-x  1 root root  1079 Jun 17 00:47 qla_dbg.c.patch
-rwxr-xr-x  1 root root   489 Jun 17 00:47 qla_init.c.patch
-rwxr-xr-x  1 root root  1800 Jun 17 00:47 qlogicfc.c.patch
-rwxr-xr-x  1 root root  1094 Jun 17 00:47 qlogicisp.c.patch
-rwxr-xr-x  1 root root   508 Jun 17 00:47 raid1.c.patch
-rwxr-xr-x  1 root root   512 Jun 17 00:47 raid10.c.patch
-rwxr-xr-x  1 root root   789 Jun 17 00:47 raw1394.c.patch
-rwxr-xr-x  1 root root  2275 Jun 17 00:47 ray_cs.c.patch
-rwxr-xr-x  1 root root   427 Jun 17 00:47 rioboot.c.patch
-rwxr-xr-x  1 root root   530 Jun 17 00:47 rioinit.c.patch
-rwxr-xr-x  1 root root   400 Jun 17 00:47 riointr.c.patch
-rwxr-xr-x  1 root root  2022 Jun 17 00:47 riotty.c.patch
-rwxr-xr-x  1 root root   429 Jun 17 00:47 rndis.c.patch
-rwxr-xr-x  1 root root  1007 Jun 17 00:47 rocket.c.patch
-rwxr-xr-x  1 root root   471 Jun 17 00:47 route.c.patch
-rwxr-xr-x  1 root root   560 Jun 17 00:47 rpaphp_pci.c.patch
-rwxr-xr-x  1 root root   479 Jun 17 00:47 rpc_pipe.c.patch
-rwxr-xr-x  1 root root   616 Jun 17 00:47 rtas.c.patch
-rwxr-xr-x  1 root root   752 Jun 17 00:47 s2io.c.patch
-rwxr-xr-x  1 root root   465 Jun 17 00:47 sc1200.c.patch
-rwxr-xr-x  1 root root   455 Jun 17 00:47 sch_ingress.c.patch
-rwxr-xr-x  1 root root  1148 Jun 17 00:47 script_asm.pl.patch
-rwxr-xr-x  1 root root   477 Jun 17 00:47 scsi.c.patch
-rwxr-xr-x  1 root root   459 Jun 17 00:47 scsicam.c.patch
-rwxr-xr-x  1 root root  1513 Jun 17 00:47 sd.c.patch
-rwxr-xr-x  1 root root   507 Jun 17 00:47 sdla.c.patch
-rwxr-xr-x  1 root root   573 Jun 17 00:47 sdla_chdlc.c.patch
-rwxr-xr-x  1 root root  1015 Jun 17 00:47 sdla_fr.c.patch
-rwxr-xr-x  1 root root   503 Jun 17 00:47 sdla_ppp.c.patch
-rwxr-xr-x  1 root root  1170 Jun 17 00:47 sdla_x25.c.patch
-rwxr-xr-x  1 root root   784 Jun 17 00:47 sdladrv.c.patch
-rwxr-xr-x  1 root root  1683 Jun 17 00:47 seagate.c.patch
-rwxr-xr-x  1 root root   419 Jun 17 00:47 seq_fifo.c.patch
-rwxr-xr-x  1 root root   456 Jun 17 00:47 seq_timer.c.patch
-rwxr-xr-x  1 root root   428 Jun 17 00:47 setup.c-20555.patch
-rwxr-xr-x  1 root root   451 Jun 17 00:47 setup.c-30769.patch
-rwxr-xr-x  1 root root  1025 Jun 17 00:47 setup.c.patch
-rwxr-xr-x  1 root root   458 Jun 17 00:47 sg.c.patch
-rwxr-xr-x  1 root root   467 Jun 17 00:47 shpchprm_legacy.c.patch
-rwxr-xr-x  1 root root   977 Jun 17 00:47 sis5513.c.patch
-rwxr-xr-x  1 root root   837 Jun 17 00:47 sis900.c.patch
-rwxr-xr-x  1 root root   789 Jun 17 00:47 sk_g16.c.patch
-rwxr-xr-x  1 root root   474 Jun 17 00:47 skgesirq.c.patch
-rwxr-xr-x  1 root root  2750 Jun 17 00:47 skystar2.c.patch
-rwxr-xr-x  1 root root  6627 Jun 17 00:47 smc9194.c.patch
-rwxr-xr-x  1 root root   462 Jun 17 00:47 smc91x.c.patch
-rwxr-xr-x  1 root root   927 Jun 17 00:47 smtparse.c.patch
-rwxr-xr-x  1 root root  1671 Jun 17 00:47 specialix.c.patch
-rwxr-xr-x  1 root root   642 Jun 17 00:47 speedstep-centrino.c.patch
-rwxr-xr-x  1 root root   571 Jun 17 00:47 srf.c.patch
-rwxr-xr-x  1 root root   448 Jun 17 00:47 sstfb.c.patch
-rwxr-xr-x  1 root root   953 Jun 17 00:47 stallion.c.patch
-rwxr-xr-x  1 root root   537 Jun 17 00:47 stx_gp3.c.patch
-rwxr-xr-x  1 root root   547 Jun 17 00:47 sun3_NCR5380.c.patch
-rwxr-xr-x  1 root root   598 Jun 17 00:47 superio.c.patch
-rwxr-xr-x  1 root root   554 Jun 17 00:47 svclock.c.patch
-rwxr-xr-x  1 root root  2668 Jun 17 00:47 swarm_cs4297a.c.patch
-rwxr-xr-x  1 root root  1231 Jun 17 00:47 sx.c.patch
-rwxr-xr-x  1 root root   885 Jun 17 00:47 sycamore.c.patch
-rwxr-xr-x  1 root root   450 Jun 17 00:47 sys_dp264.c.patch
-rwxr-xr-x  1 root root   458 Jun 17 00:47 sys_titan.c.patch
-rwxr-xr-x  1 root root   430 Jun 17 00:47 sysrq.c.patch
-rwxr-xr-x  1 root root  1619 Jun 17 00:47 system.h.patch
-rwxr-xr-x  1 root root   690 Jun 17 00:47 tape_core.c.patch
-rwxr-xr-x  1 root root  1267 Jun 17 00:47 tas_common.h.patch
-rwxr-xr-x  1 root root   450 Jun 17 00:47 tbrsdt.c.patch
-rwxr-xr-x  1 root root   470 Jun 17 00:47 tbxfroot.c.patch
-rwxr-xr-x  1 root root   502 Jun 17 00:47 tg3.c.patch
-rwxr-xr-x  1 root root   503 Jun 17 00:47 therm_adt746x.c.patch
-rwxr-xr-x  1 root root   730 Jun 17 00:47 timer_tsc.c.patch
-rwxr-xr-x  1 root root   633 Jun 17 00:47 tlan.c.patch
-rwxr-xr-x  1 root root   743 Jun 17 00:47 tms380tr.c.patch
-rwxr-xr-x  1 root root   896 Jun 17 00:47 tmscsim.c.patch
-rwxr-xr-x  1 root root   531 Jun 17 00:47 toshiba_rbtx4927_setup.c.patch
-rwxr-xr-x  1 root root   422 Jun 17 00:47 tpm.c.patch
-rwxr-xr-x  1 root root   502 Jun 17 00:47 tqm8xxl.c.patch
-rwxr-xr-x  1 root root   471 Jun 17 00:47 traps.c-26038.patch
-rwxr-xr-x  1 root root   508 Jun 17 00:47 traps.c.patch
-rwxr-xr-x  1 root root   425 Jun 17 00:47 tumbler.c.patch
-rwxr-xr-x  1 root root  1910 Jun 17 00:47 tx4927_irq.c.patch
-rwxr-xr-x  1 root root  1906 Jun 17 00:47 usX2Yhwdep.c.patch
-rwxr-xr-x  1 root root   486 Jun 17 00:47 usbusx2yaudio.c.patch
-rwxr-xr-x  1 root root   360 Jun 17 00:47 virgefb.c.patch
-rwxr-xr-x  1 root root   418 Jun 17 00:47 vlan.c.patch
-rwxr-xr-x  1 root root   646 Jun 17 00:47 vlsi_ir.c.patch
-rwxr-xr-x  1 root root   485 Jun 17 00:47 vmlogrdr.c.patch
-rwxr-xr-x  1 root root   467 Jun 17 00:47 vx_pcm.c.patch
-rwxr-xr-x  1 root root   431 Jun 17 00:47 wakeup.c.patch
-rwxr-xr-x  1 root root   881 Jun 17 00:47 walnut.c.patch
-rwxr-xr-x  1 root root   583 Jun 17 00:47 wanpipe_multppp.c.patch
-rwxr-xr-x  1 root root   634 Jun 17 00:47 wireless.c.patch
-rwxr-xr-x  1 root root   583 Jun 17 00:47 xfs_bmap.c.patch
-rwxr-xr-x  1 root root  2245 Jun 17 00:47 xfs_iomap.c.patch
-rwxr-xr-x  1 root root   440 Jun 17 00:47 xics.c.patch
-rwxr-xr-x  1 root root  3304 Jun 17 00:47 xircom_cb.c.patch
-rwxr-xr-x  1 root root  1726 Jun 17 00:47 xmon.c-23101.patch
-rwxr-xr-x  1 root root   385 Jun 17 00:47 xmon.c.patch
-rwxr-xr-x  1 root root   944 Jun 17 00:47 xpram.c.patch
-rwxr-xr-x  1 root root   499 Jun 17 00:47 zoran_procfs.c.patch
--
vda

