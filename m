Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272822AbRILOCF>; Wed, 12 Sep 2001 10:02:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272824AbRILOBp>; Wed, 12 Sep 2001 10:01:45 -0400
Received: from [195.66.192.167] ([195.66.192.167]:57092 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S272822AbRILOBh>; Wed, 12 Sep 2001 10:01:37 -0400
Date: Wed, 12 Sep 2001 17:00:34 +0300
From: VDA <VDA@port.imtp.ilyichevsk.odessa.ua>
X-Mailer: The Bat! (v1.44)
Reply-To: VDA <VDA@port.imtp.ilyichevsk.odessa.ua>
Organization: IMTP
X-Priority: 3 (Normal)
Message-ID: <10016113059.20010912170034@port.imtp.ilyichevsk.odessa.ua>
To: linux-kernel@vger.kernel.org
Subject: Re: [GOLDMINE!!!] Athlon optimisation bug (was Re: Duron kernel crash)
In-Reply-To: <Pine.LNX.4.33.0109111325320.4625-100000@falka.mfa.kfki.hu>
In-Reply-To: <Pine.LNX.4.33.0109111325320.4625-100000@falka.mfa.kfki.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok, guys, since we know that Athlon bug is BIOS version dependent,
please do this:
* Flash 'bad' BIOS (one that makes Atlon-optimized kernel to oops)
* Reboot
* Save complete output of lspci -vvvxxx
* Flash 'good' BIOS
* Reboot
* Save complete output of lspci -vvvxxx
* Send me those captured outputs. Include BIOS versions pls.

Note: you don't need to boot with Athlon-optimized kernel.
I just want to compare what's the difference in chipset
programming with 'bad' and 'good' BIOS.
If you feel so inclined, do the comparison yourself
and report.

Does anybody have KT133A data sheet handy to look up
those PCI config register dumps?
-- 
Best regards, VDA
mailto:VDA@port.imtp.ilyichevsk.odessa.ua
http://port.imtp.ilyichevsk.odessa.ua/vda/


