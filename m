Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132643AbRDOMtZ>; Sun, 15 Apr 2001 08:49:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132636AbRDOMtP>; Sun, 15 Apr 2001 08:49:15 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:28165 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S132643AbRDOMtD>; Sun, 15 Apr 2001 08:49:03 -0400
Subject: Re: 2.4.3 - Module problems?
To: swds.mlowe@home.com (Matthew W. Lowe)
Date: Sun, 15 Apr 2001 13:51:02 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3ADA49F0.A412EAA@home.com> from "Matthew W. Lowe" at Apr 15, 2001 07:25:04 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14olzc-0006iz-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> as I did the previous kernel. They were the NE2000 PCI module and the
> 3C59X module. The two NICs I have are: Realtek 8029 PCI, 3COM Etherlink
> III ISA. Both are PNP, the etherlink is NOT the one with the b extention
> at the end.

Make sure you use either the kernel or the usermode PnP and not both. (You
probably want to turn kernel PnP off)


