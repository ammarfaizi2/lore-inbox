Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279141AbRJ0KUG>; Sat, 27 Oct 2001 06:20:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279802AbRJ0KT4>; Sat, 27 Oct 2001 06:19:56 -0400
Received: from mlist.austria.eu.net ([193.81.83.3]:39569 "EHLO
	hausmasta.austria.eu.net") by vger.kernel.org with ESMTP
	id <S279801AbRJ0KTn>; Sat, 27 Oct 2001 06:19:43 -0400
Message-ID: <3BDA8A5E.503EDD28@eunet.at>
Date: Sat, 27 Oct 2001 12:20:14 +0200
From: Michael Reinelt <reinelt@eunet.at>
Organization: netWorks
X-Mailer: Mozilla 4.77 [de] (X11; U; Linux 2.4.10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: strange hangs with kernel 2.4.12 (and 13)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-AntiVirus: OK (checked by AntiVir Version 6.10.0.20)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there,

I've got some strange problems here, since 2.4.12 (2.4.10 was ok, I
never tried .11)

The System boots fine, I can login on a text console, but when I log out
again, the system partly gets unusable. The load rises, and the text
console where I logout hangs. 

I've got seveal processes hanging in "D" state, especially devfsd. I
think something with devfs and/or devfsd is broken here. If I kill
devfsd before, the problem does not arise (but I need devfsd :-)

Now, It gets even more strange: The problem does only exist if I
deactivate ACPI! I tried with a ACPI enabled kernel with the command
line "acpi=off", I tried on a machine which is too old for ACPI, and I
even compiled a kernel without ACPI at all. Everywhere the same problem.
When I boot with activated ACPI, there's no problem.

I don't understand what's happening here. I tried to debug a bit, but
couldn't find something sense- or useful. 


Any hints? If someone could tell me what I should try or which debug
info could be useful, please let me know!

TIA, Michael

-- 
netWorks                                          Vox: +43 316  698260
Michael Reinelt                                   Fax: +43 316  692343
Geisslergasse 4                                   GSM: +43 676 3079941
A-8045 Graz, Austria                          e-mail: reinelt@eunet.at
