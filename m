Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262680AbTI1Sha (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Sep 2003 14:37:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262681AbTI1Sha
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Sep 2003 14:37:30 -0400
Received: from fw.osdl.org ([65.172.181.6]:2495 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262680AbTI1Sh3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Sep 2003 14:37:29 -0400
Date: Sun, 28 Sep 2003 11:37:18 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Russell King <rmk@arm.linux.org.uk>
cc: Linux Kernel List <linux-kernel@vger.kernel.org>,
       Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: CONFIG_I8042
In-Reply-To: <20030928161059.B1428@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.44.0309281136141.15408-100000@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 28 Sep 2003, Russell King wrote:
> 
> If we have an AT Keyboard, that does _NOT_ mean that we have an I8042.

Well, it does require us to have at least SERIO. Also, we need to have 
some way to make sure that I8042 does get selected on a PC.

Apart from that, it doesn't matter how it's solved..

		Linus

