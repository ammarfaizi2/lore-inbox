Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270496AbTGUQeQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jul 2003 12:34:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270525AbTGUQeQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jul 2003 12:34:16 -0400
Received: from pub234.cambridge.redhat.com ([213.86.99.234]:41996 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S270496AbTGUQeN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jul 2003 12:34:13 -0400
Date: Mon, 21 Jul 2003 17:49:14 +0100 (BST)
From: James Simmons <jsimmons@infradead.org>
To: michaelm <admin@www0.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test1 won't go further than "uncompressing" on a p1/32MB
 pc
In-Reply-To: <20030721163517.GA597@www0.org>
Message-ID: <Pine.LNX.4.44.0307211745170.6905-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> .config: http://www0.org/config

First your CONFIG_INPUT is modular. You will not have keyboard support 
when you boot. Also no keyboard or mouse is configured. Turn them on by 
selecting Serio IO support. Then select i8042 chipset and then enable 
keyboard and mouse support. After that you need to enable CONFIG_VT in
the Characters device menu. Then after that in the framebuffer menu you 
go into the Console menu and select Framebuffer console. Then you should 
be ready to go.


