Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293705AbSCFRGy>; Wed, 6 Mar 2002 12:06:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293696AbSCFRF6>; Wed, 6 Mar 2002 12:05:58 -0500
Received: from zamok.crans.org ([138.231.136.6]:50148 "EHLO zamok.crans.org")
	by vger.kernel.org with ESMTP id <S293701AbSCFRFE>;
	Wed, 6 Mar 2002 12:05:04 -0500
To: arjanv@redhat.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: xmms segfaulting on 2.4.18 and 2.4.19-pre2-ac2 + oops
In-Reply-To: <m3pu2hn1z2.fsf@neo.loria> <3C864048.27DF51E4@redhat.com>
X-PGP-KeyID: 0xF22A794E
X-PGP-Fingerprint: 5854 AF2B 65B2 0E96 2161  E32B 285B D7A1 F22A 794E
From: Vincent Bernat <bernat@free.fr>
In-Reply-To: <3C864048.27DF51E4@redhat.com> (Arjan van de Ven's message of
 "Wed, 06 Mar 2002 16:14:00 +0000")
Organization: Kabale Inc
Date: Wed, 06 Mar 2002 18:05:01 +0100
Message-ID: <m31yexfwzm.fsf@neo.loria>
User-Agent: Gnus/5.090006 (Oort Gnus v0.06) XEmacs/21.4 (Common Lisp,
 i686-pc-linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OoO Lors de la soirée naissante du mercredi 06 mars 2002, vers 17:14,
Arjan van de Ven <arjanv@redhat.com> disait:

>> I encounter problems with xmms segfaulting on two different
>> kernels. The first one is 2.4.18-xfs-preempt-lockbreak-bttv. I use
>> alsa drivers (0.90.0b12) for my SB PCI 128 card. The second one is
>> 2.4.19-pre2-ac2 with shawn patch (xfs + rmap 12g) and preempt patch.
>> 

> might be worth testing without preempt to rule that out...

I will try to catch the next oops to its correctness then I will try
without preempt.
-- 
panic("huh?\n");
	2.2.16 /usr/src/linux/arch/i386/kernel/smp.c
