Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265355AbRGBRl7>; Mon, 2 Jul 2001 13:41:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265356AbRGBRls>; Mon, 2 Jul 2001 13:41:48 -0400
Received: from isua1.iastate.edu ([129.186.1.201]:28164 "EHLO
	isua1.iastate.edu") by vger.kernel.org with ESMTP
	id <S265355AbRGBRll>; Mon, 2 Jul 2001 13:41:41 -0400
Date: Mon, 2 Jul 2001 12:41:41 -0500 (CDT)
From: Swami <swamis@iastate.edu>
To: linux-kernel@vger.kernel.org
Subject: Doubt in interrupts
Message-ID: <Pine.OSF.3.95.1010702123304.30601F-100000@isua1.iastate.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

Are there any interrupts which doesn't affect local_irq_count(cpu) or that
doesn't enter do_IRQ()? (other than NMIs).

Because I'm implementing my own locking routine and I'm getting
interrupted during spin, but I check and found that in_interupt() returns
zero.


Thanking in advance,

Swami

--------------------------
http://www.swaminathans.com


