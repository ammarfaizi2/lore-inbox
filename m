Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131738AbQLGXyP>; Thu, 7 Dec 2000 18:54:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131757AbQLGXyF>; Thu, 7 Dec 2000 18:54:05 -0500
Received: from enterprise.cistron.net ([195.64.68.33]:21523 "EHLO
	enterprise.cistron.net") by vger.kernel.org with ESMTP
	id <S131738AbQLGXxw>; Thu, 7 Dec 2000 18:53:52 -0500
From: miquels@cistron.nl (Miquel van Smoorenburg)
Subject: Re: Linux 2.2.18pre25
Date: 7 Dec 2000 23:23:31 GMT
Organization: Cistron Internet Services B.V.
Message-ID: <90p65j$4k7$1@enterprise.cistron.net>
In-Reply-To: <E1447Fx-0002vA-00@the-village.bc.nu>
X-Trace: enterprise.cistron.net 976231411 4743 195.64.65.201 (7 Dec 2000 23:23:31 GMT)
X-Complaints-To: abuse@cistron.nl
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <E1447Fx-0002vA-00@the-village.bc.nu>,
Alan Cox  <alan@lxorguk.ukuu.org.uk> wrote:
>So I figure this is it for 2.2.18, subject to evidence to the contrary

Megaraid still needs fixing. I sent you the patch twice, so have
other people, but it still isn't fixed. The

megaBase &= PCI_BASE_ADDRESS_MEM_MASK;

...

megaBase &= PCI_BASE_ADDRESS_IO_MASK;

is removed by the 2.2.18 version (read the patch) and that breaks
older megaraid cards.

Existing megaraid system with 2.2.x kernels WILL break with 2.2.18

Mike.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
