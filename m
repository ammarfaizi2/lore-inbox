Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266540AbSKULNA>; Thu, 21 Nov 2002 06:13:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266552AbSKULNA>; Thu, 21 Nov 2002 06:13:00 -0500
Received: from uranus.lan-ks.de ([194.45.71.1]:49412 "EHLO uranus.lan-ks.de")
	by vger.kernel.org with ESMTP id <S266540AbSKULM7> convert rfc822-to-8bit;
	Thu, 21 Nov 2002 06:12:59 -0500
X-MDaemon-Deliver-To: <linux-kernel@vger.kernel.org>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [2.5.48] Config.help misleading
References: <871y5iuajl.fsf@gswi1164.jochen.org>
	<200211181823.gAIIN1eA002882@pool-151-204-203-202.delv.east.verizon.net>
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
Date: Wed, 20 Nov 2002 17:54:26 +0100
In-Reply-To: <200211181823.gAIIN1eA002882@pool-151-204-203-202.delv.east.verizon.net> (Skip
 Ford's message of "Mon, 18 Nov 2002 19:30:17 +0100")
Message-ID: <87zns4chbx.fsf@gswi1164.jochen.org>
User-Agent: Gnus/5.090008 (Oort Gnus v0.08) Emacs/21.2
 (i386-debian-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Skip Ford <skip.ford@verizon.net> writes:

> Jochen Hein wrote:
>> Help says to say "Y" if unsure, but that isn't allowed:
>> ,----
>> |   UHCI HCD (most Intel and VIA) support (USB_UHCI_HCD) [N/m/?] (NEW) ?
>> | 
> [snip]
>> | 133). If unsure, say Y.
>> | 
>> |   UHCI HCD (most Intel and VIA) support (USB_UHCI_HCD) [N/m/?] (NEW) y
>> `----
>
> Did you choose to make USB support a module?  

Yes.

> If you said 'y' to USB
> support, then you should have a 'y' option above.  However, you most
> likely said 'm' for USB support so 'm' is all you can do for this
> because it depends on it.  Had you said 'n' to USB support, you wouldn't
> be able to select 'y' or 'm' for the above.

So, what should the help text say?  I propose
"If unsure, say M".
That should get it right more often than the current text.
Or perhaps your explanation should be included.  I think that's even
better.  Randy?

Jochen

-- 
Wenn Du nicht weiﬂt was Du tust, tu's mit Eleganz.
