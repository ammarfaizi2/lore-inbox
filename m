Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136528AbRD3WbU>; Mon, 30 Apr 2001 18:31:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136530AbRD3WbL>; Mon, 30 Apr 2001 18:31:11 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:24325 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S136529AbRD3WbA>; Mon, 30 Apr 2001 18:31:00 -0400
Subject: Re: Fw: where can I find the IP address ?
To: sebastien.person@sycomore.fr (=?ISO-8859-1?Q?s=E9bastien?= person)
Date: Mon, 30 Apr 2001 23:34:38 +0100 (BST)
Cc: linux-kernel@vger.kernel.org (liste noyau linux)
In-Reply-To: <20010425094406.6554c0b0.sebastien.person@sycomore.fr> from "=?ISO-8859-1?Q?s=E9bastien?= person" at Apr 25, 2001 09:44:06 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14uMFc-0000XX-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> pa_addr in the struct device. but it doesn't exist on my computer.
> 
> so I don't understand why ? Is anybody could tell me where finding the
> IP address in the kernel ?

A driver may not even have an IP address and it may change dynamically. One
side effect of this (and support for multiple addresses per node) is that
the addresses are now a chain attached to the device struct. You might find
netdev@oss.sgi.com a much better place to ask

Alan

