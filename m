Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266835AbUI1UWR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266835AbUI1UWR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Sep 2004 16:22:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267783AbUI1UWQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Sep 2004 16:22:16 -0400
Received: from mailgate.pit.comms.marconi.com ([169.144.68.6]:9213 "EHLO
	mailgate.pit.comms.marconi.com") by vger.kernel.org with ESMTP
	id S266835AbUI1UUs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Sep 2004 16:20:48 -0400
Message-ID: <313680C9A886D511A06000204840E1CF0A6471D6@whq-msgusr-02.pit.comms.marconi.com>
From: "Povolotsky, Alexander" <Alexander.Povolotsky@marconi.com>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Linux 2.6.8-rc4 "Kernel panic: Attempted to kill init!" - after 
	replacing /fadsroot on the Linux NFSserver with the one from Arabella cdr
	om
Date: Tue, 28 Sep 2004 16:20:46 -0400
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2657.72)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have built (cross-compiled for ppc 82xx) Linux 2.6.8-rc4 kernel and am
trying to boot it on PQ2FADS-VR 

> I am getting: "Kernel panic: Attempted to kill init!" - after replacing
> /fadsroot (with the BusyBox) on the remote Linux NFS server with the newer
> one from the new version of the Arabella cdrom. 
Is it software or hardware (bad memory ?) issue ?

Thanks,
Best Regards,
Povolotsky, Alexander
*****************************  
> => printenv
> bootdelay=5
> bootcmd=bootm 200000
> ethaddr=08:00:17:00:00:03
> serverip=192.168.0.3
> ipaddr=192.168.0.5
> baudrate=9600
> bootargs=root=/dev/nfs rw nfsroot=192.168.0.4:/fadsroot
> stdin=serial
> stdout=serial
> stderr=serial
> 
> Environment size: 210/262140 bytes
> => tftpboot 200000 uimage
> Using FCC2 ETHERNET device
> TFTP from server 192.168.0.3; our IP address is 192.168.0.5
> Filename 'uimage'.
> Load address: 0x200000
> Loading: #################################################################
>          #################################################################
>          #######################################
> done
> Bytes transferred = 864364 (d306c hex)
> => bootm 200000
> ## Booting image at 00200000 ...
>    Image Name:   Linux-2.6.8-rc4
>    Image Type:   PowerPC Linux Kernel Image (gzip compressed)
>    Data Size:    864300 Bytes = 844 kB
>    Load Address: 00000000
>    Entry Point:  00000000
>    Verifying Checksum ... OK
>    Uncompressing Kernel Image ... OK
> Linux version 2.6.8-rc4 (apovolot@USPITLAD104868) (gcc version 3.3.2) #5
> Mon Aug
>  16 08:49:38 EDT 2004
> PQ2 ADS Port
> Built 1 zonelists
> Kernel command line: root=/dev/nfs rw nfsroot=192.168.0.4:/fadsroot nobats
> ip=19
> 2.168.0.5
> PID hash table entries: 256 (order 8: 2048 bytes)
> Warning: real time clock seems stuck!
> Dentry cache hash table entries: 8192 (order: 3, 32768 bytes)
> Inode-cache hash table entries: 4096 (order: 2, 16384 bytes)
> Memory: 30432k available (1348k kernel code, 324k data, 272k init, 0k
> highmem)
> Calibrating delay loop... 131.07 BogoMIPS
> Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
> NET: Registered protocol family 16
> PCI: Probing PCI hardware
> Generic RTC Driver v1.07
> Serial: CPM driver $Revision: 0.01 $
> ttyCPM0 at MMIO 0xf0011a00 (irq = 40) is a CPM UART
> RAMDISK driver initialized: 16 RAM disks of 32768K size 1024 blocksize
> loop: loaded (max 8 devices)
> eth0: FCC ENET Version 0.3, 08:00:17:40:00:03
> NET: Registered protocol family 2
> IP: routing cache hash table of 512 buckets, 4Kbytes
> TCP: Hash tables configured (established 2048 bind 4096)
> NET: Registered protocol family 1
> NET: Registered protocol family 17
> IP-Config: Guessing netmask 255.255.255.0
> IP-Config: Complete:
>       device=eth0, addr=192.168.0.5, mask=255.255.255.0,
> gw=255.255.255.255,
>      host=192.168.0.5, domain=, nis-domain=(none),
>      bootserver=255.255.255.255, rootserver=192.168.0.4, rootpath=
> Looking up port of RPC 100003/2 on 192.168.0.4
> Looking up port of RPC 100005/1 on 192.168.0.4
> VFS: Mounted root (nfs filesystem).
> Freeing unused kernel memory: 272k init
> Kernel panic: Attempted to kill init!
>  <0>Rebooting in 180 seconds..
> 
> 	 
> 
