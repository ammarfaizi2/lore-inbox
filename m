Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262124AbVANVoQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262124AbVANVoQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jan 2005 16:44:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262194AbVANVmr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jan 2005 16:42:47 -0500
Received: from 3n8-31.servernode.net ([209.152.168.31]:27058 "EHLO
	3n8-31.servernode.net") by vger.kernel.org with ESMTP
	id S262058AbVANVk7 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jan 2005 16:40:59 -0500
Reply-To: <kevin@gw1ngl.com>
From: "gw1ngl" <kevin@gw1ngl.com>
To: <linux-kernel@vger.kernel.org>
Subject: already locked by net/netrom/af_netrom.c/176
Date: Fri, 14 Jan 2005 13:42:09 -0800
Message-ID: <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAAUKBFAOX3R0uYt0ctsIT4Y8KAAAAQAAAArX3UysCVykSb7sy0XnIbmAEAAAAA@gw1ngl.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
In-Reply-To: 
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2527
Thread-Index: AcT3Hmd0eP5+alRURruvjZx69fNa4QAlJ9GwAAGhYqAAlJY4UAAdGgagAABgUPA=
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - 3n8-31.servernode.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - gw1ngl.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

How do I fix this?

Linux gw.w1ngl.ampr.org 2.6.10RadioAX25.1-1.2005 #8 Sun Jan 2 01:23:11 PST
2005 i686 i686 i386 GNU/Linux
 
Gnu C                  3.4.2
Gnu make               3.80
binutils               2.15.92.0.2
util-linux             2.12a
mount                  2.12a
module-init-tools      3.1-pre5
e2fsprogs              1.35
reiserfsprogs          line
reiser4progs           line
pcmcia-cs              3.2.7
quota-tools            3.12.
PPP                    2.4.2
isdn4k-utils           3.3
nfs-utils              1.0.6
Linux C Library        2.3.4
Dynamic linker (ldd)   2.3.4
Procps                 3.2.3
Net-tools              1.60
Kbd                    1.12
Sh-utils               5.2.1
Modules Loaded         ipt_MASQUERADE iptable_nat ip_conntrack
iptable_filter ip_tables slip slhc ipip xfrm4_tunnel md5 ipv6 autofs4 sunrpc
uhci_hcd i2c_piix4 i2c_core snd_ens1371 snd_rawmidi snd_seq_device
snd_ac97_codec snd_pcm_oss snd_mixer_oss snd_pcm snd_timer snd soundcore
snd_page_alloc gameport e100 mii floppy dm_snapshot dm_zero dm_mirror ext3
jbd dm_mod

kernel: net/netrom/nr_in.c:77: spin_lock(net/core/sock.c:ca9f2860) already
locked by net/netrom/af_netrom.c/176
kernel: net/netrom/af_netrom.c:914: spin_unlock(net/core/sock.c:ca9f2860)
not locked
kernel: net/netrom/nr_in.c:157: spin_lock(net/core/sock.c:ca9f2860) already
locked by net/netrom/af_netrom.c/176
kernel: net/netrom/af_netrom.c:914: spin_unlock(net/core/sock.c:ca9f2860)
not locked
kernel: net/netrom/nr_in.c:157: spin_lock(net/core/sock.c:ca9f2860) already
locked by net/netrom/af_netrom.c/176
kernel: net/netrom/nr_in.c:77: spin_lock(net/core/sock.c:ca9f2860) already
locked by net/netrom/af_netrom.c/176
kernel: net/netrom/af_netrom.c:914: spin_unlock(net/core/sock.c:ca9f2860)
not locked
kernel: net/netrom/nr_in.c:157: spin_lock(net/core/sock.c:ca9f2860) already
locked by net/netrom/af_netrom.c/176
kernel: net/netrom/af_netrom.c:914: spin_unlock(net/core/sock.c:ca9f2860)
not locked
kernel: net/netrom/nr_in.c:157: spin_lock(net/core/sock.c:ca9f2860) already
locked by net/netrom/af_netrom.c/176
kernel: net/netrom/nr_in.c:77: spin_lock(net/core/sock.c:ca9f20e0) already
locked by net/netrom/af_netrom.c/176
kernel: net/netrom/af_netrom.c:914: spin_unlock(net/core/sock.c:ca9f20e0)
not locked
kernel: net/netrom/nr_in.c:157: spin_lock(net/core/sock.c:ca9f20e0) already
locked by net/netrom/af_netrom.c/176
kernel: net/netrom/af_netrom.c:914: spin_unlock(net/core/sock.c:ca9f20e0)
not locked
kernel: net/netrom/nr_in.c:157: spin_lock(net/core/sock.c:ca9f2680) already
locked by net/netrom/af_netrom.c/176
kernel: net/netrom/af_netrom.c:914: spin_unlock(net/core/sock.c:ca9f2680)
not locked
kernel: net/netrom/nr_in.c:157: spin_lock(net/core/sock.c:ca9f2680) already
locked by net/netrom/af_netrom.c/176
kernel: net/netrom/af_netrom.c:914: spin_unlock(net/core/sock.c:ca9f2680)
not locked
kernel: net/netrom/nr_in.c:157: spin_lock(net/core/sock.c:ca9f2680) already
locked by net/netrom/af_netrom.c/176
kernel: net/netrom/nr_in.c:157: spin_lock(net/core/sock.c:ca9f20e0) already
locked by net/netrom/af_netrom.c/176
 
Kevin


