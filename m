Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261757AbTCZQJA>; Wed, 26 Mar 2003 11:09:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261758AbTCZQJA>; Wed, 26 Mar 2003 11:09:00 -0500
Received: from uranus.lan-ks.de ([194.45.71.1]:49415 "EHLO uranus.lan-ks.de")
	by vger.kernel.org with ESMTP id <S261757AbTCZQI4>;
	Wed, 26 Mar 2003 11:08:56 -0500
To: James Simmons <jsimmons@infradead.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [Bug 500] New: fbcon sleeping function call from illegal
 context
X-Face: ""xJff<P[R~C67]V?J|X^Dr`YigXK|;1wX<rt^>%{>hr-{:QXl"Xk2O@@(+F]e{"%EYQiW@mUuvEsL>=mx96j12qW[%m;|:B^n{J8k?Mz[K1_+H;$v,nYx^1o_=4M,L+]FIU~[[`-w~~xsy-BX,?tAF_.8u&0y*@aCv;a}Y'{w@#*@iwAl?oZpvvv
X-Message-Flag: This space is intentionally left blank
X-Noad: Please don't send me ad's by mail.  I'm bored by this type of mail.
X-Note: sending SPAM is a violation of both german and US law and will
	at least trigger a complaint at your provider's postmaster.
X-GPG: 1024D/77D4FC9B 2000-08-12 Jochen Hein (28 Jun 1967, Kassel, Germany) 
     Key fingerprint = F5C5 1C20 1DFC DEC3 3107  54A4 2332 ADFC 77D4 FC9B
X-BND-Spook: RAF Taliban BND BKA Bombe Waffen Terror AES GPG
X-No-Archive: yes
From: Jochen Hein <jochen@jochen.org>
Date: Wed, 26 Mar 2003 17:09:01 +0100
In-Reply-To: <Pine.LNX.4.44.0303252114470.6228-100000@phoenix.infradead.org> (James
 Simmons's message of "Tue, 25 Mar 2003 21:16:21 +0000 (GMT)")
Message-ID: <87wuimds9u.fsf@echidna.jochen.org>
User-Agent: Gnus/5.090015 (Oort Gnus v0.15) Emacs/21.2
References: <Pine.LNX.4.44.0303252114470.6228-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Simmons <jsimmons@infradead.org> writes:

> Please try my patch I sent to Ben. I attached it to this email for people 
> to try it.

This is not against stock (can't remember applying a patch) 2.5.66; I
get Rejects:

root@gswi1164:/usr/src/linux-2.5.66# patch -p1 <
~jochen/tmp/fbcon-illegal-context.diff
patching file drivers/video/console/fbcon.c
Hunk #3 FAILED at 232.
Hunk #8 succeeded at 588 with fuzz 2.
Hunk #10 FAILED at 1024.
Hunk #11 FAILED at 1147.
3 out of 11 hunks FAILED -- saving rejects to file
drivers/video/console/fbcon.c.rej
patching file drivers/video/softcursor.c
patching file include/linux/fb.h
Hunk #2 FAILED at 407.
1 out of 2 hunks FAILED -- saving rejects to file
include/linux/fb.h.rej

-- 
#include <~/.signature>: permission denied
