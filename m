Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261880AbVAYKny@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261880AbVAYKny (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 05:43:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261882AbVAYKny
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 05:43:54 -0500
Received: from zone4.gcu-squad.org ([213.91.10.50]:35011 "EHLO
	zone4.gcu-squad.org") by vger.kernel.org with ESMTP id S261880AbVAYKnw convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 05:43:52 -0500
Date: Tue, 25 Jan 2005 11:38:44 +0100 (CET)
To: kraxel@bytesex.org, akpm@osdl.org
Subject: Re: [patch] add i2c adapter id for the cx88 driver.
X-IlohaMail-Blah: khali@localhost
X-IlohaMail-Method: mail() [mem]
X-IlohaMail-Dummy: moo
X-Mailer: IlohaMail/0.8.13 (On: webmail.gcu.info)
Message-ID: <sbi0fAAA.1106649524.3006370.khali@localhost>
In-Reply-To: <20050125102036.GA1696@bytesex>
From: "Jean Delvare" <khali@linux-fr.org>
Bounce-To: "Jean Delvare" <khali@linux-fr.org>
CC: "Christoph Bartelmus" <lirc@bartelmus.de>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hallo Gerd,

> +#define I2C_HW_B_CX2388x 0x1a   /* connexant 2388x based tv cards */

0x1a is reserved for TI PCILynx in the i2c project, although I never took
the time to forward the update to the kernel trees. Could you please use
0x1b instead?

Other than that I am fine with the patch ;)

Thanks,
--
Jean Delvare
