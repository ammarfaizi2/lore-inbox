Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261169AbVCGR23@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261169AbVCGR23 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Mar 2005 12:28:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261170AbVCGR23
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Mar 2005 12:28:29 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:26859 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S261169AbVCGR2X
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Mar 2005 12:28:23 -0500
Subject: Re: Atheros wi-fi card drivers (?)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Mateusz Berezecki <mateuszb@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <422C7722.40301@gmail.com>
References: <422C7722.40301@gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1110216394.3072.72.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Mon, 07 Mar 2005 17:26:36 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2005-03-07 at 15:45, Mateusz Berezecki wrote:
> I've been doing some reverse engineering of madwifi HAL (Hardware 
> Abstraction Layer) object file recently.
> I ended up with an almost complete source code for one chipset so far 
> and I was wondering if it is legal
> to publish such source code on the internet?

You should normally avoid doing this. Instead write a description of the
chip registers and functions from the source you have produced and get
someone else to write a chip driver from that. This avoids the risk of
you being held to have "copied" their code - in the EU while you have
rights to reverse engineer for interoperability in general if you copy
their code that may still be a copyright violation.

>  The note on a card says it 
> is "protected by us patents <patents number list>".
> Does the patent apply to the reverse engineered source code, or just to 
> the hardware? Or is it even legal to create such source code?

Depends if you are in the USA. To answer that question you would also
need to look at the US patents. If you are in the USA then you should
not do this even though it is what patent law was intended for because
the US legal system is broken.

Another question would be "do Atheros care" as I understand their
fundamental issue was compliance with FCC regulations rather than
concerns about free software.

> I would like to ask for some comments regarding this case. And let's say 
> the driver works, would it be included into kernel source ?

There is other code in the kernel where reverse engineering was used. 

Alan

