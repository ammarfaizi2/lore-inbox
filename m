Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273030AbRIITwf>; Sun, 9 Sep 2001 15:52:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273024AbRIITwZ>; Sun, 9 Sep 2001 15:52:25 -0400
Received: from smtp02.mrf.mail.rcn.net ([207.172.4.61]:63457 "EHLO
	smtp02.mrf.mail.rcn.net") by vger.kernel.org with ESMTP
	id <S273027AbRIITwK>; Sun, 9 Sep 2001 15:52:10 -0400
Message-ID: <014001c1389f$16b4fcc0$0200a8c0@lazybrain.com>
From: "faybaby" <faybaby@enter.net>
To: <linux-kernel@vger.kernel.org>
Subject: SB live problems with new kernels
Date: Sat, 8 Sep 2001 15:47:26 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.00.2615.200
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2615.200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I finally turned off that set version info for all modules (which broke
everything)
and most everything is working now with 2.4.9.

My sound however is not. I tried 2.4.6 and sound still doesnt work.
With 2.4.6 I get the following from insmod. what is broken and how do i fix
it.
im running mandrake 7.2 gcc-2.95mdk

emu10k1.o: unresolved symbol unregister_sound_dsp
emu10k1.o: unresolved symbol unregister_sound_midi
emu10k1.o: unresolved symbol register_sound_dsp
emu10k1.o: unresolved symbol register_sound_mixer
emu10k1.o: unresolved symbol unregister_sound_mixer
emu10k1.o: unresolved symbol register_sound_midi

and if i type depmod i get this

depmod: *** Unresolved symbols in
/lib/modules/2.4.6/kernel/drivers/net/8139too.o
depmod: *** Unresolved symbols in
/lib/modules/2.4.6/kernel/drivers/net/dummy.o
depmod: *** Unresolved symbols in
/lib/modules/2.4.6/kernel/drivers/net/tulip/tulip.o
depmod: *** Unresolved symbols in
/lib/modules/2.4.6/kernel/drivers/sound/emu10k1/emu10k1.o
depmod: *** Unresolved symbols in
/lib/modules/2.4.6/kernel/net/ipv4/netfilter/ip_conntrack.o
depmod: *** Unresolved symbols in
/lib/modules/2.4.6/kernel/net/ipv4/netfilter/ip_conntrack_ftp.o
depmod: *** Unresolved symbols in
/lib/modules/2.4.6/kernel/net/ipv4/netfilter/ip_nat_ftp.o
depmod: *** Unresolved symbols in
/lib/modules/2.4.6/kernel/net/ipv4/netfilter/ip_tables.o
depmod: *** Unresolved symbols in
/lib/modules/2.4.6/kernel/net/ipv4/netfilter/ipt_LOG.o
depmod: *** Unresolved symbols in
/lib/modules/2.4.6/kernel/net/ipv4/netfilter/ipt_MARK.o
depmod: *** Unresolved symbols in
/lib/modules/2.4.6/kernel/net/ipv4/netfilter/ipt_MASQUERADE.o
depmod: *** Unresolved symbols in
/lib/modules/2.4.6/kernel/net/ipv4/netfilter/ipt_REJECT.o
depmod: *** Unresolved symbols in
/lib/modules/2.4.6/kernel/net/ipv4/netfilter/ipt_TCPMSS.o
depmod: *** Unresolved symbols in
/lib/modules/2.4.6/kernel/net/ipv4/netfilter/ipt_TOS.o
depmod: *** Unresolved symbols in
/lib/modules/2.4.6/kernel/net/ipv4/netfilter/ipt_limit.o
depmod: *** Unresolved symbols in
/lib/modules/2.4.6/kernel/net/ipv4/netfilter/ipt_mac.o
depmod: *** Unresolved symbols in
/lib/modules/2.4.6/kernel/net/ipv4/netfilter/ipt_tcpmss.o
depmod: *** Unresolved symbols in
/lib/modules/2.4.6/kernel/net/ipv4/netfilter/iptable_filter.o
depmod: *** Unresolved symbols in
/lib/modules/2.4.6/kernel/net/ipv4/netfilter/iptable_mangle.o
depmod: *** Unresolved symbols in
/lib/modules/2.4.6/kernel/net/ipv4/netfilter/iptable_nat.o


