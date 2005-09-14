Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965226AbVINO7f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965226AbVINO7f (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 10:59:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965233AbVINO7f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 10:59:35 -0400
Received: from laf31-5-82-235-130-100.fbx.proxad.net ([82.235.130.100]:49634
	"EHLO lexbox.fr") by vger.kernel.org with ESMTP id S965226AbVINO7f convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 10:59:35 -0400
Subject: RE: Corrupted file on a copy
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Date: Wed, 14 Sep 2005 16:56:57 +0200
Content-class: urn:content-classes:message
Message-ID: <17AB476A04B7C842887E0EB1F268111E026F9E@xpserver.intra.lexbox.org>
X-MimeOLE: Produced By Microsoft Exchange V6.5.6944.0
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Corrupted file on a copy
thread-index: AcW5Ob/Ex6T+dbCAQNuBsgivuB/7TQAAipYg
From: "David Sanchez" <david.sanchez@lexbox.fr>
To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Cc: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Unfortunately, the cmp command shows me a difference between the 2 files!
I known that it is a strange behaviour and that probably come from my code but I don't find it yet :(
More, I try the last linux kernel 2.6.13 from linux-mips.org with the last busybox version and the problem persists!


David SANCHEZ
LexBox :: The Digital Evidence 
3, avenue Didier Daurat
31400 TOULOUSE / FRANCE
david.sanchez@lexbox.fr
Tel :  +33 (0)5 62 47 15 81
Fax : +33 (0)5 62 47 15 84
-----Message d'origine-----
De : linux-os (Dick Johnson) [mailto:linux-os@analogic.com] 
Envoyé : mercredi 14 septembre 2005 16:46
À : David Sanchez
Cc : linux-kernel@vger.kernel.org
Objet : Re: Corrupted file on a copy


On Wed, 14 Sep 2005, David Sanchez wrote:

> Hi,
>
> I'm using the linux kernel 2.6.10 and busybox 1.0 on a AMD AU1550 board.
>
> When I copy a big file (around 300M) within an ext2 filesystem (even on
> ext3 filesystem) then the output file is sometime "corrupted" (I mean
> that the source and the destination files are different and thus
> generate a different SHA1).
> Does somebody have a same behaviour?
>
> Thanks,
> David
>

Use `cmp` to compare the two files. You could have discovered
a bug in your checksum utility, you need to isolate it to
the file-system. FYI, I have never seen a copy of a file, including
the image of an entire DVD (saved to clone another), that was not
properly identical.


Cheers,
Dick Johnson
Penguin : Linux version 2.6.13 on an i686 machine (5589.53 BogoMips).
Warning : 98.36% of all statistics are fiction.
.
I apologize for the following. I tried to kill it with the above dot :

****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.


Thank you.





