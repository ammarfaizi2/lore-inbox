Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315257AbSFXU0i>; Mon, 24 Jun 2002 16:26:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315259AbSFXU0h>; Mon, 24 Jun 2002 16:26:37 -0400
Received: from pimout4-ext.prodigy.net ([207.115.63.103]:28143 "EHLO
	pimout4-int.prodigy.net") by vger.kernel.org with ESMTP
	id <S315257AbSFXU0f>; Mon, 24 Jun 2002 16:26:35 -0400
Message-ID: <022f01c21bbd$2f6c70c0$fad88842@ribald.com>
From: "Niels Christiansen" <nc@ejna.ribald.com>
To: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       <lse-tech@lists.sourceforge.net>
References: <OFCB119CD8.D6AE7B3D-ON85256BE2.006AC911@raleigh.ibm.com>
Subject: Re: [Lse-tech] efficient copy_to_user and copy_from_user routines in Linux Kernel
Date: Mon, 24 Jun 2002 15:24:46 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4807.1700
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4807.1700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mala,

As you may recall, I showed you results back in February with MMX registers
enabled.  I also gave you a simple patch to test activate the use of the MMX
registers.  It would be interesting if you could run your test with the MMX
patch so we could see the difference.  In case you forgot the patch, it is
as simple as setting CONFIG_X86_USE_3DNOW on for Pentium III in
arch/i386/config.in.

Niels Christiansen

----- Original Message -----
From: "Mala Anand" <manand@us.ibm.com>
To: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>;
<lse-tech@lists.sourceforge.net>
Sent: Monday, June 24, 2002 2:34 PM
Subject: [Lse-tech] efficient copy_to_user and copy_from_user routines in
Linux Kernel


> Here is a 2.5.19 patch that improves the performance of IA32 copy_to_user
> and copy_from_user routines used by :
>
> (1) tcpip protocol stack
> (2) file systems
>
> Badari Pulavarty has suggested using mmx registers instead of integer
> registers in the unrolled loop copy method.  We are both investigating
> the performance of the copy routines when the mmx registers are used.
>
> Regards,
>     Mala

