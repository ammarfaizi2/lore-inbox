Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265097AbSJRMzn>; Fri, 18 Oct 2002 08:55:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265098AbSJRMzn>; Fri, 18 Oct 2002 08:55:43 -0400
Received: from fep03-mail.bloor.is.net.cable.rogers.com ([66.185.86.73]:58648
	"EHLO fep03-mail.bloor.is.net.cable.rogers.com") by vger.kernel.org
	with ESMTP id <S265097AbSJRMzl>; Fri, 18 Oct 2002 08:55:41 -0400
Message-ID: <0d8c01c276a6$67cf9020$370a0a0a@slappy>
Reply-To: "Sean Estabrooks" <seanlkml@rogers.com>
From: "Sean Estabrooks" <seanlkml@rogers.com>
To: <linux-kernel@vger.kernel.org>
Cc: =?iso-8859-1?Q?Gerrit_Bruchh=E4user?= <gbruchhaeuser@orga.com>
References: <3DAFDC88.2010009@orga.com>
Subject: Re: bootsect.S and magic address 0x78
Date: Fri, 18 Oct 2002 09:00:59 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1106
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
X-Authentication-Info: Submitted using SMTP AUTH LOGIN at fep03-mail.bloor.is.net.cable.rogers.com from [24.102.213.12] using ID <seanlkml@rogers.com> at Fri, 18 Oct 2002 09:01:00 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Hello Linus,
>
>
> Can you tell me where this magic address 0x78 in arch/i386/bootsect.S
> refers to? I mean, is this somewhere specified?
>
> Many thanks and cheers from germany.
>
> Gerrit

> Hello Linus,
>
>
> Can you tell me where this magic address 0x78 in arch/i386/bootsect.S
> refers to? I mean, is this somewhere specified?
>

Hope you'll settle for an answer from a simple lkml lurker and not the top
gun.

The address 0x78 points to the floppy disk drive parameter table
described here:  http://www.xs4all.nl/~matrix/fdd_pt.html

A list of all the low memory ROM BIOS vectors and addresses can be
found here:  http://www.cybertrails.com/~fys/rombios.htm

Cheers,
Sean

