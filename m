Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130144AbQLSTPI>; Tue, 19 Dec 2000 14:15:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130316AbQLSTO6>; Tue, 19 Dec 2000 14:14:58 -0500
Received: from mail.zikzak.de ([195.21.249.46]:38926 "EHLO mail.zikzak.de")
	by vger.kernel.org with ESMTP id <S130144AbQLSTOw>;
	Tue, 19 Dec 2000 14:14:52 -0500
From: amk@krell.snafu.de (Andreas M. Kirchwitz)
Subject: Re: [PATCH] fix emu10k1 init breakage in 2.2.18
Date: 19 Dec 2000 18:44:20 GMT
Organization: Touched By The Hand Of God.
Message-ID: <slrn93vb44.enh.amk@krell.zikzak.de>
In-Reply-To: <200012191201.NAA02004@harpo.it.uu.se>
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mikael Pettersson wrote:

 > 2.2.18 broke the emu10k1 driver when compiled into the kernel.
 > The problem is that 2.2.18 now implements 2.4-style module_init,
 > so emu10k1 ended up being initialised twice when built non-modular,
 > which rendered it dysfunctional. The fix is to remove the now
 > obsolete explicit init calls. Patch below. Please apply.

Is there also a fix available to make the bass and treble settings
work again in mixer applications (for example, Gnome mix 1.2.0)?
This is (now, was) one of the biggest advantages of this card to have
control over bass and treble settings. 

It worked for the early 2.2.18pre patches, but stopped working in
the latest ones (including final 2.2.18).

	Greetings, Andreas
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
