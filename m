Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263251AbTIGOTv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Sep 2003 10:19:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263258AbTIGOTv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Sep 2003 10:19:51 -0400
Received: from main.gmane.org ([80.91.224.249]:38028 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S263251AbTIGOTu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Sep 2003 10:19:50 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Jochen Hein <jochen@jochen.org>
Subject: Re: [PATCH] mwave locking
Date: Sun, 07 Sep 2003 15:43:03 +0200
Message-ID: <87iso4iujc.fsf@echidna.jochen.org>
References: <3F5B3021.9090107@colorfullife.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Complaints-To: usenet@sea.gmane.org
X-Face: ""xJff<P[R~C67]V?J|X^Dr`YigXK|;1wX<rt^>%{>hr-{:QXl"Xk2O@@(+F]e{"%EYQiW@mUuvEsL>=mx96j12qW[%m;|:B^n{J8k?Mz[K1_+H;$v,nYx^1o_=4M,L+]FIU~[[`-w~~xsy-BX,?tAF_.8u&0y*@aCv;a}Y'{w@#*@iwAl?oZpvvv
X-Message-Flag: This space is intentionally left blank
X-Noad: Please don't send me ad's by mail.  I'm bored by this type of mail.
X-Note: sending SPAM is a violation of both german and US law and will
	at least trigger a complaint at your provider's postmaster.
X-GPG: 1024D/77D4FC9B 2000-08-12 Jochen Hein (28 Jun 1967, Kassel, Germany) 
     Key fingerprint = F5C5 1C20 1DFC DEC3 3107  54A4 2332 ADFC 77D4 FC9B
X-BND-Spook: RAF Taliban BND BKA Bombe Waffen Terror AES GPG
X-No-Archive: yes
User-Agent: Gnus/5.1002 (Gnus v5.10.2) Emacs/21.2 (gnu/linux)
Cancel-Lock: sha1:Kmeu+qEhsIuyaOyy6UX9HNaIlNs=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Manfred Spraul <manfred@colorfullife.com> writes:

>>drivers/char/mwave/mwavedd.c:331:2: warning: #warning "Sleeping on spinlock"
>>
> Attached is a patch that removes that. Untested due to lack of
> hardware. Anyone around such hardware (IBM Thinkpad?)

I'll try it - it's a Thinkpad 600.  See also 
http://bugzilla.kernel.org/show_bug.cgi?id=185

Jochen

-- 
#include <~/.signature>: permission denied

