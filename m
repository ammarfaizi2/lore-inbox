Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268587AbTGOPvT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 11:51:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268511AbTGOPvS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 11:51:18 -0400
Received: from air-2.osdl.org ([65.172.181.6]:36767 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S268784AbTGOPur (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 11:50:47 -0400
Date: Tue, 15 Jul 2003 09:03:37 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: koala.gnu@tiscalinet.it
Cc: Riley@Williams.Name, linux-kernel@vger.kernel.org
Subject: Re: Linux boot code
Message-Id: <20030715090337.6ce4b9a3.rddunlap@osdl.org>
In-Reply-To: <3F13C6BA.80102@tiscalinet.it>
References: <BKEGKPICNAKILKJKMHCACEAKEOAA.Riley@Williams.Name>
	<3F13C6BA.80102@tiscalinet.it>
Organization: OSDL
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i586-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Jul 2003 11:17:46 +0200 Koala GNU <koala.gnu@tiscalinet.it> wrote:

| Hi, Riley,
| 
| thanks for your reply.
| 
| I noticed the native boot code for floppy is not supported any more. In 
| fact in the current code display a message and reboot the machine after 
| the press of a key.
| 
| But I am interested on how the old native boot code worked.
| 
| Do you know if there is a particular reason why the boot sector is moved 
| to 0x9000:0 (excuse me if I repeat the question, but I need help on this)?

Why do you need to know?

IIRC, it's because the code being loaded also (usually) is written
as a boot loader also, and boot loaders often assume that they are
loaded at 0:7c00.  (disclaimer: it's been a few years since I worked
on boot loaders.)

| I hope someone else can point me a site where is reported the format of 
| the floppy parameter table at address 0x0:0x78.

http://www.delorie.com/djgpp/doc/rbinter/id/55/24.html (for one)

--
~Randy
| http://developer.osdl.org/rddunlap/ | http://www.xenotime.net/linux/ |
