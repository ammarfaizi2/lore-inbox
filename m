Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262948AbTI2KQ0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Sep 2003 06:16:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262986AbTI2KQ0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Sep 2003 06:16:26 -0400
Received: from 153.Red-213-4-13.pooles.rima-tde.net ([213.4.13.153]:26633 "EHLO
	small.felipe-alfaro.com") by vger.kernel.org with ESMTP
	id S262948AbTI2KQZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Sep 2003 06:16:25 -0400
Subject: Re: irq 12: nobody cared! (2.6.0-test6)
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: Meelis Roos <mroos@linux.ee>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.GSO.4.44.0309290947230.9442-100000@math.ut.ee>
References: <Pine.GSO.4.44.0309290947230.9442-100000@math.ut.ee>
Content-Type: text/plain
Message-Id: <1064830579.1389.0.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Mon, 29 Sep 2003 12:16:20 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-09-29 at 08:56, Meelis Roos wrote:
> This is Linux 2.6.0-test6 on a PC with VIA KT133A chipset (MSI MS-6330
> mainboard), PS/2 keyboard, USB mouse. In test5 it hung on boot just
> after printing
> mice: PS/2 mouse device common for all mice
> input: PC Speaker
> 
> In 2.6.0-test6, it spits out several "irq 12: nobody cared!" messages
> with backtraces and then continues as if nothing happened. The system
> works fine, PS/2 keyboard and USB mouse both work too. Similar
> configuration (PS/2 keyboard + USB mouse) works fine on an i815 chipset
> computer.

Have you tried with 2.6.0-test6-mm1? It includes a fix for ACPI PCI
routing which may help in your case.

