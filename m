Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265424AbSLCSmk>; Tue, 3 Dec 2002 13:42:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265469AbSLCSmk>; Tue, 3 Dec 2002 13:42:40 -0500
Received: from uranus.lan-ks.de ([194.45.71.1]:32012 "EHLO uranus.lan-ks.de")
	by vger.kernel.org with ESMTP id <S265424AbSLCSmj> convert rfc822-to-8bit;
	Tue, 3 Dec 2002 13:42:39 -0500
To: EricAltendorf@orst.edu
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [2.5.50, ACPI] link error
References: <E18Ix71-0003ik-00@gswi1164.jochen.org>
	<200212031007.01782.EricAltendorf@orst.edu>
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
Date: Tue, 03 Dec 2002 19:35:05 +0100
In-Reply-To: <200212031007.01782.EricAltendorf@orst.edu> (Eric Altendorf's
 message of "Tue, 03 Dec 2002 19:10:09 +0100")
Message-ID: <87znrn3q92.fsf@gswi1164.jochen.org>
User-Agent: Gnus/5.090008 (Oort Gnus v0.08) Emacs/21.2
 (i386-debian-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric Altendorf <EricAltendorf@orst.edu> writes:

> On Monday 02 December 2002 12:24, Jochen Hein wrote:
>> When compiling 2.5.50 with CONFIG_ACPI_SLEEP=y
>> I get:
>>
>> arch/i386/kernel/built-in.o(.data+0x1304): In function 
> `do_suspend_lowlevel':
>> : undefined reference to `save_processor_state'
>>
>> arch/i386/kernel/built-in.o(.data+0x130a): In function 
> `do_suspend_lowlevel':
>> : undefined reference to `saved_context_esp'
>>
> Try turning on software suspend in the kernel hacking section.  

It is off (and has been all the time, AFAIR).

Jochen

-- 
Wenn Du nicht weiﬂt was Du tust, tu's mit Eleganz.
