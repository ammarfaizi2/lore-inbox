Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269825AbTGOWQP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 18:16:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269814AbTGOWN1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 18:13:27 -0400
Received: from login.osdl.org ([65.172.181.5]:46003 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S269807AbTGOWL3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 18:11:29 -0400
Date: Tue, 15 Jul 2003 15:22:57 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Fernando Sanchez <fsanchez@mail.usfq.edu.ec>
Cc: linux-kernel@vger.kernel.org
Subject: Re: modules problems with 2.6.0
Message-Id: <20030715152257.614d628b.rddunlap@osdl.org>
In-Reply-To: <3F147B8F.5000103@mail.usfq.edu.ec>
References: <3F147B8F.5000103@mail.usfq.edu.ec>
Organization: OSDL
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i586-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Jul 2003 17:09:19 -0500 Fernando Sanchez <fsanchez@mail.usfq.edu.ec> wrote:

| Hi,
| 
| I've been trying to get 2.6.0 to work, I've enabled modules support, but 
| I get this error on my logs:
| 
| Jul 15 15:38:36 Darakemba kernel: No module symbols loaded - kernel 
| modules not enabled.
| 
| Is there any thing like a new modutils that should be used with 2.6.x 
| family?

Yes, they are at
  http://www.kernel.org/pub/linux/kernel/people/rusty/modules/

Also, a summary of 2.5/2.6 changes is very worthwhile reading.  See:
  http://www.codemonkey.org.uk/post-halloween-2.5.txt
for which config options that you really need to enable.

| The kernel does boot, but not having any modules I can't do much, and 
| also, I never get to really see the messages on screen, on logs I have 
| this line:
| 
| Jul 15 15:38:36 Darakemba kernel: Video mode to be used for restore is ffff
| 
| What does it mean?

Dunno.  Anyone?

| I disabled all the framebuffer things so I can just use vga, on lilo, 
| vga mode is set to normal, but still can't see anything.


--
~Randy
| http://developer.osdl.org/rddunlap/ | http://www.xenotime.net/linux/ |
