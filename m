Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262251AbTEHXY5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 May 2003 19:24:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262253AbTEHXY5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 May 2003 19:24:57 -0400
Received: from h-64-105-35-101.SNVACAID.covad.net ([64.105.35.101]:40109 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP id S262251AbTEHXYy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 May 2003 19:24:54 -0400
Date: Thu, 8 May 2003 16:36:42 -0700
From: "Adam J. Richter" <adam@yggdrasil.com>
Message-Id: <200305082336.h48Nage18416@freya.yggdrasil.com>
To: root@mauve.demon.co.uk
Subject: Re: Binary firmware in the kernel - licensing issues.
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> 	Let's be clear: embedding binary firmware into a GPL'ed
>> work is fine if the firmware contains no additional restriction
>> beyond the GPL and complete source code for the firmware is
>> included.  I think you understand this much already, but I just
>> want to be clear about it.

>> 	All three distribution options in section 3 of the version 2
>> of the GNU General Public License require distribution or arrangments
>> for distribution "machine-readable source code", and defines
>> "source code" as "the preferred form of the work for making
>> modifications to it."  That seems pretty clear to me.

root@mauve.demon.co.uk wrote:
>So if you've got a CPU, that you have to load the microcode into before
>fully booting, you can't run linux on it natively, unless the CPU maker
>provides full microcode source? 

	I don't know of any such CPU, but I imagine you could run
Linux on it natively.  Just make sure that the microcode is not part
of a GPL'ed work.  For example, have the boot loader load the
microcode from a separate file before booting Linux.

	If the CPU can start boot Linux far enough to mount
a root file system and run some user space programs manually,
you could even have a separate user space program running under
Linux update the microcode.

>Presumably the "preferred form" clause would mean that there must 
>be hardware documentation too.

	No.  I just expalained the differences in these two
messages:

http://marc.theaimsgroup.com/?l=linux-kernel&m=105240981525737&w=2
http://marc.theaimsgroup.com/?l=linux-kernel&m=105241295329617&w=2

>And when is a binary a binary, and not a string constant?

	When the developers create the binary from an assembler
rather calculating numbers manually, then the file that they
feed to the assembler is part of the preferred form of the
work for making modifications to it.

	All of the above is "in my humble opinion."  Also, remember
that I am not a lawyer, so do not rely on this as legal advice.

Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Miplitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."
