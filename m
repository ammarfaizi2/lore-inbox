Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261317AbSJCNij>; Thu, 3 Oct 2002 09:38:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261351AbSJCNii>; Thu, 3 Oct 2002 09:38:38 -0400
Received: from mbr.sphere.ne.jp ([210.150.254.228]:7165 "HELO mbr.sphere.ne.jp")
	by vger.kernel.org with SMTP id <S261317AbSJCNig>;
	Thu, 3 Oct 2002 09:38:36 -0400
Date: Thu, 3 Oct 2002 22:44:06 +0900
From: Bruce Harada <harada@mbr.sphere.ne.jp>
To: jbradford@dial.pipex.com
Cc: vojtech@suse.cz, tori@ringstrom.mine.nu, linux-kernel@vger.kernel.org
Subject: Re: 2.5.40: AT keyboard input problem
Message-Id: <20021003224406.77471ed6.harada@mbr.sphere.ne.jp>
In-Reply-To: <200210031320.g93DKnqx000460@darkstar.example.net>
References: <20021003144319.A38785@ucw.cz>
	<200210031320.g93DKnqx000460@darkstar.example.net>
X-Mailer: Sylpheed version 0.7.8 (GTK+ 1.2.6; i686-pc-linux-gnu)
X-Face: $qrUU,Lz=B[A}i%m2Rg^Ik;~V@]$Ay)$S`wUf3:^aZ1UdLf,_;1y7_xbEh=Yv*wB0=Fv]a1hj14_qQsl[f1KX]q4IdhwmSIeP6>Ap@[e$c$G;;ObLI7?Y<H5";4<{GAPoak2U)!da]-ZJb}!.#>Xsq*)M'3Jp<M,l~'4F{qWpM$%"%p'
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Oct 2002 14:20:48 +0100 (BST)
jbradford@dial.pipex.com wrote:

> > Do you by any chance know the names of the unknown keys so that I could
> > add them to the Set 3 default scancode map?
> 
> All I can tell you is a translation of what is written on the scancode 0x87
> key on this particular keyboard:
> 
> 'Hiragana/Roma_characters'
> 
> I can't translate the characters on the other keys.
> 
> However, somebody else might be able to - I found this diagram of the
> keyboard:
> 
> http://www.pfu.co.jp/hhkeyboard/kb_collection/ibm5576-002.gif
> 
> The legends on the bottom row of keys are exactly the same as on my
> keyboard, and from left to right, they have the following functions:
> 
> Control
> ALT, (it says, 'Kanji/Katakana/Kanji???', but works as ALT)
> Scancode 0x85
> Space bar
> Scancode 0x86
> Scancode 0x87, (it says, 'Hiragana/Roma characters')
> ALT GR
> Control

In the order you gave above, they are:

- Control

- Kanji/Hiragana (The smaller characters underneath are 'Kanji bango' [=
 "Kanji number"])

- Muhenkan [="No conversion"]  (The smaller characters underneath are
 'Bunsetsu yomi' [="Sentence fragment reading"])

- Space

- Zenkoho [="Previous candidate"] / Henkan (Jikoho) [="Conversion (Next
 candidate)"] / Zenkoho [="All candidates"]

- Hiragana (Underneath is 'Romaji', i.e. English characters)

- Zenmen ki [="Next screen key"]

- Control


Hope that helps,

Bruce
