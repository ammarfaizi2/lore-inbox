Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263807AbTK2Qim (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Nov 2003 11:38:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263794AbTK2Qim
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Nov 2003 11:38:42 -0500
Received: from ppp-62-245-235-62.mnet-online.de ([62.245.235.62]:14210 "EHLO
	frodo.midearth.frodoid.org") by vger.kernel.org with ESMTP
	id S263807AbTK2Qij (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Nov 2003 11:38:39 -0500
To: "Prakash K. Cheemplavam" <prakashpublic@gmx.de>
Cc: unlisted-recipients:;;;linux-kernel@vger.kernel.org; (no To-header on input),
       marcush@onlinehome.de
Illegal-Object: Syntax error in Cc: address found on vger.kernel.org:
	Cc:	unlisted-recipients:; (no To-header on input)linux-kernel@vger.kernel.org
								     ^-missing end of address
Illegal-Object: Syntax error in Cc: address found on vger.kernel.org:
	Cc:	unlisted-recipients:; (no To-header on input)linux-kernel@vger.kernel.org
								     ^-missing end of address
Subject: Re: Silicon Image 3112A SATA trouble
References: <3FC36057.40108@gmx.de> <3FC8BDB6.2030708@gmx.de>
From: Julien Oster <frodoid@frodoid.org>
Organization: FRODOID.ORG
X-Face: #C"_SRmka_V!KOD9IoD~=}8-P'ekRGm,8qOM6%?gaT(k:%{Y+\Cbt.$Zs<[X|e)<BNuB($kI"KIs)dw,YmS@vA_67nR]^AQC<w;6'Y2Uxo_DT.yGXKkr/s/n'Th!P-O"XDK4Et{`Di:l2e!d|rQoo+C6)96S#E)fNj=T/rGqUo$^vL_'wNY\V,:0$q@,i2E<w[_l{*VQPD8/h5Y^>?:O++jHKTA(
Date: Sat, 29 Nov 2003 17:38:37 +0100
In-Reply-To: <3FC8BDB6.2030708@gmx.de> (Prakash K. Cheemplavam's message of
 "Sat, 29 Nov 2003 16:39:34 +0100")
Message-ID: <frodoid.frodo.878ylzjfjm.fsf@usenet.frodoid.org>
User-Agent: Gnus/5.1002 (Gnus v5.10.2) Emacs/21.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Prakash K. Cheemplavam" <prakashpublic@gmx.de> writes:

Hello Prakash,

> Holy Shit!

> I just tried the libata driver and it ROCKSSSS! So far, at least.
> I already wrote about the crappy SiI3112 ide driver, now with libata I
> get >60mb/sec!!!! More then I get with windows.
> Also tests with dd. This rocks. Lets see whether it likes swsup, as well...

Sounds GREAT!

> So folks, try libata, as well.
> I dunno what all is actuall needed. I enabled scsi, scie disk, scsi
> generic, sata and its driver. In grub I appended "doataraid noraid".
> YES!

I can't find the Silicon Image driver under

"SCSI low-level drivers" -> "Serial ATA (SATA) support"

under 2.6.0-test11. Just the following are there:

ServerWorks Frodo
Intel PIIX/ICH
Promisa SATA
VIA SATA

So, which kernel do I need?

Regards,
Julien
