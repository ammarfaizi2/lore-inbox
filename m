Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310391AbSCGQWg>; Thu, 7 Mar 2002 11:22:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310389AbSCGQW0>; Thu, 7 Mar 2002 11:22:26 -0500
Received: from web.dragon.cz ([212.71.160.4]:32131 "EHLO web.dragon.cz")
	by vger.kernel.org with ESMTP id <S310392AbSCGQWO>;
	Thu, 7 Mar 2002 11:22:14 -0500
Message-ID: <3C8793AB.5080309@afd.cz>
Date: Thu, 07 Mar 2002 17:22:03 +0100
From: Martin Zabadal <zabadal@afd.cz>
Organization: Aufeer Design s.r.o
User-Agent: Mozilla/5.0 (X11; U; AIX 0040FD5C4C00; en-US; rv:0.9.8) Gecko/20020205
X-Accept-Language: en, cs
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, linux-xfs@oss.sgi.com
Subject: PROBLEM: XFS on LVM over NFS (Linux) mounted by AIX
X-Priority: 1 (highest)
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi experts!

I cannot solve the problem with Linux xfs-1.0.2 on LVM on kernel-2.4.14 
and higher served per nfs-server to AIX(4.3.3.0) nfs-clients.

Compiling with the same .config:
1.) kernel-2.4.2 with xfs-1.0 runs nfs excellent with AIX-clients 
(except quotas)
2.) kernel-2.4.16 up to 2.4.18 makes use of nfs useless (tranfer rates 
about 3kB).
     I get the same bad result with precompiled kernel from SGI:
ftp://oss.sgi.com/projects/xfs/download/Release-1.0.2/kernel_rpms/i386/2.4.14/kernel-2.4.14-SGI_XFS_1.0.2.i686.rpm


Here my system: SUSE 7.1

/usr/src/linux/scripts # sh ver_linux
-- Versions installed: (if some fields are empty or look
-- unusual then possibly you have very old versions)
Linux pc3 2.4.2-XFS #1 Mon Jul 9 19:47:15 CEST 2001 i686 unknown
Kernel modules         2.4.2
Gnu C                  2.95.2  but kernels compiled with egcs 1.1.2
Gnu Make               3.79.1
Binutils               2.10.0.33
Linux C Library        x    1 root     root      1382179 Dec 18 16:32 
/lib/libc.so.6
Dynamic linker         ldd (GNU libc) 2.2
Procps                 2.0.7
Mount                  2.10q
Net-tools              1.57
Kbd                    1.02
Sh-utils               2.0

LVM                    0.9.4
NFSUTILS               0.2.1-20

Modules Loaded         nls_iso8859-1 snd-pcm-oss snd-pcm-plugin 
snd-mixer-oss ipt_REDIRECT ipt_MASQUERADE iptable_mangle iptable_nat 
ip_conntrack iptable_filter ip_tables ide-scsi sr_mod sg scsi_mod 
parport_pc lp parport ipv6 snd-seq-midi snd-seq-midi-event snd-seq 
snd-card-via686a snd-pcm snd-timer snd-ac97-codec snd-mixer 
snd-mpu401-uart snd-rawmidi snd-seq-device snd soundcore 3c59x

Please help !

-- 
Martin Zabadal
  http://www.aufeerdesign.cz

