Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130552AbQLEWZG>; Tue, 5 Dec 2000 17:25:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130517AbQLEWY4>; Tue, 5 Dec 2000 17:24:56 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:14852 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129849AbQLEWYi>; Tue, 5 Dec 2000 17:24:38 -0500
Subject: Re: [RFC-2] Configuring Synchronous Interfaces in Linux
To: lists@cyclades.com (Ivan Passos)
Date: Tue, 5 Dec 2000 21:56:08 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        linux-kernel@vger.kernel.org (Linux Kernel List), netdev@oss.sgi.com
In-Reply-To: <Pine.LNX.4.10.10012051118140.1713-100000@main.cyclades.com> from "Ivan Passos" at Dec 05, 2000 11:23:50 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E143Q4I-0000EZ-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Alan, what's the approach you'd feel more comfortable with:
> - One ioctl that passes a pointer to a known structure in ifr.ifr_data as 
>   its argument.
> - Several ioctl's, one for each parameter, that pass only the specific 
>   parameter new value as the argument.
> 
> The former is good because it relies on a _single_ ioctl. However, every
> time you change the ioctl structure you may lose backward compatibility.

One ioctl with a set of subcommands seems to be quite common

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
