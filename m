Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280674AbRKNQML>; Wed, 14 Nov 2001 11:12:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280676AbRKNQMB>; Wed, 14 Nov 2001 11:12:01 -0500
Received: from quimbies.gnus.org ([195.204.10.148]:45841 "EHLO
	quimbies.gnus.org") by vger.kernel.org with ESMTP
	id <S280670AbRKNQLq>; Wed, 14 Nov 2001 11:11:46 -0500
X-Now-Playing: Supersilent's _5_: "5.2"
To: Alastair Stevens <alastair.stevens@mrc-bsu.cam.ac.uk>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: Athlon SMP blues - kernels 2.4.[9 13 15-pre4]
In-Reply-To: <Pine.GSO.4.33.0111141533320.14971-100000@gurney>
From: Lars Magne Ingebrigtsen <larsi@gnus.org>
Date: Wed, 14 Nov 2001 17:09:15 +0100
In-Reply-To: <Pine.GSO.4.33.0111141533320.14971-100000@gurney> (Alastair
 Stevens's message of "Wed, 14 Nov 2001 15:38:37 +0000 (GMT)")
Message-ID: <m3vggde3mc.fsf@quimbies.gnus.org>
User-Agent: Gnus/5.090004 (Oort Gnus v0.04) Emacs/21.0.104
 (i686-pc-linux-gnu)
X-Face: &w!^oO<W.WBH]FsTP:P0f9X6M-ygaADlA_)eF$<UwQzj7:C=Gi<a?/_4$LX^@$Qq7-O&XHp
 lDARi8e8iT<(A$LWAZD*xjk^')/wI5nG;1cNB>~dS|}-P0~ge{$c!h\<y
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alastair Stevens <alastair.stevens@mrc-bsu.cam.ac.uk> writes:

> Forgive me, but what does 'registered' strictly refer to? It is ECC RAM,
> in a single 512Mb module, but more than that, I don't know.

Registered RAM sticks look somewhat different from normal (ECC or not)
RAM sticks.  They have a few more ICs on the stick, and are usually
bigger than their normal counterparts.

(The "register" bit refers to, I believe, those buffers on the
sticks.)

> But the key question is still this: is this purely a hardware issue? My
> understanding is that with recent 2.4 kernels, Athlon optimisations and
> AMD 760 issues are sorted - am I right?

If you compile a kernel without any Athlon optimizations, it should
work on the Tyan Tiger.  Try that first, and then try out the
optimizations when you've got that working.

-- 
(domestic pets only, the antidote for overdose, milk.)
   larsi@gnus.org * Lars Magne Ingebrigtsen
