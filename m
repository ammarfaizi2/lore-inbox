Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262223AbTFFTK1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jun 2003 15:10:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262237AbTFFTK1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jun 2003 15:10:27 -0400
Received: from auemail2.lucent.com ([192.11.223.163]:28837 "EHLO
	auemail2.firewall.lucent.com") by vger.kernel.org with ESMTP
	id S262223AbTFFTKZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jun 2003 15:10:25 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16096.59965.283412.477292@gargle.gargle.HOWL>
Date: Fri, 6 Jun 2003 15:23:41 -0400
From: "John Stoffel" <stoffel@lucent.com>
To: kwijibo@zianet.com
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Smart Array driver
In-Reply-To: <3EE0D5E0.4060408@zianet.com>
References: <3EE0D5E0.4060408@zianet.com>
X-Mailer: VM 7.14 under Emacs 20.6.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


kwijibo> Is the Compaq Smart Array 5XXX driver 2.5.x ready?  Before I
kwijibo> get to far into debugging this computer I figure I would ask.
kwijibo> It boots fine in 2.4.x kernels but when I try 2.5.70 it
kwijibo> freezes at the Uncompressing Linux line.  I thought maybe I
kwijibo> didn't the console set up right for 2.5 but as far as I can
kwijibo> tell it is and even if it wasn't it should still continue
kwijibo> booting and eventually be pingable.  My first thought was of
kwijibo> the RAID controller.  This is on a HP Proliant ML530.  Any
kwijibo> suggestions?  Config attached.

I was going to suggest that you make sure ACPI was turned off, but
your config shows that already.  Make sure you have CONFIG_VGA_CONSOLE
set is all I can think of.

John
