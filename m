Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265857AbUFIR4f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265857AbUFIR4f (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jun 2004 13:56:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265859AbUFIR4f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jun 2004 13:56:35 -0400
Received: from mail.gmx.de ([213.165.64.20]:25290 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S265857AbUFIR4d (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jun 2004 13:56:33 -0400
X-Authenticated: #1226656
Date: Wed, 9 Jun 2004 19:56:40 +0200
From: Marc Giger <gigerstyle@gmx.ch>
To: linux-kernel@vger.kernel.org
Subject: cpqarray controller in a alpha
Message-Id: <20040609195640.08ff53a1@vaio.gigerstyle.ch>
X-Mailer: Sylpheed version 0.9.10claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi List,

I'm trying to get a SA431 smart array controller working with my Alpha.

Dmesg (2.6.6) shows:

cpqarray ida0: idaSendPciCmd FIFO full, waiting!
....
<near endless loop of the same message>
....
cpqarray ida0: idaSendPciCmd FIFO full, waiting!
cpqarray ida0: idaSendPciCmd Timeout out, No command list address
returned! cpqarray: error sending ID controller

lspci:

00:06.0 RAID bus controller: Digital Equipment Corporation DECchip 21554
(rev 01)        Subsystem: Compaq Computer Corporation Integrated Smart
Array        Flags: bus master, medium devsel, latency 0, IRQ 16
        Memory at 000000000a874000 (32-bit, non-prefetchable) [size=4K]
        I/O ports at 8000 [size=256]
        Expansion ROM at 000000000a800000 [disabled] [size=256K]
        Capabilities: [dc] Power Management version 2
        Capabilities: [e4] Slot ID: 0 slots, First-, chassis 00
        Capabilities: [ec] #06 [0080]

Does this controller not work with an Alpha?

Thanks and greetings

Marc
