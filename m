Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267005AbRGIKkG>; Mon, 9 Jul 2001 06:40:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267007AbRGIKj4>; Mon, 9 Jul 2001 06:39:56 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:14600 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S267004AbRGIKjn>; Mon, 9 Jul 2001 06:39:43 -0400
Subject: Re: PATCH: linux-2.4.7-pre3/drivers/char/sonypi.c would hang some non-Sony notebooks
To: stelian@alcove.fr (Stelian Pop)
Date: Mon, 9 Jul 2001 11:39:47 +0100 (BST)
Cc: arjan@fenrus.demon.nl, linux-kernel@vger.kernel.org
In-Reply-To: <E15JXZa-0001YZ-00@come.alcove-fr> from "Stelian Pop" at Jul 09, 2001 11:43:22 AM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15JYSB-0001QR-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> But it doesn't seem to me like the dmi routines (arch/i386/kernel/dmi_s=
> can.c)
> were designed to be used from outside this scope.

They are designed to be __init - on the grounds that its cheaper to set
a single ickypurplebox=1 in __init code and keep the variable around than
keep the parser around

> 

