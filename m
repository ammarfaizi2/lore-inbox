Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264436AbTFIOxg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jun 2003 10:53:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264437AbTFIOxg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jun 2003 10:53:36 -0400
Received: from air-2.osdl.org ([65.172.181.6]:31111 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264436AbTFIOxe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jun 2003 10:53:34 -0400
Date: Mon, 9 Jun 2003 08:05:52 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Jurgen Kramer <gtm.kramer@inter.nl.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Completely disable AT/PS2 keyboard support in 2.4?
Message-Id: <20030609080552.2b0d7e8c.rddunlap@osdl.org>
In-Reply-To: <1055156075.3824.7.camel@paragon.slim>
References: <1055156075.3824.7.camel@paragon.slim>
Organization: OSDL
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i586-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 09 Jun 2003 12:54:36 +0200 Jurgen Kramer <gtm.kramer@inter.nl.net> wrote:

| Hi,
| 
| Is it possible to completely disable AT/PS2 keyboard support
| in 2.4 or is this still needed when I only use a USB keyboard?
| 
| I am currently getting dozens of keyboard messages:
| 
| keyboard.c: can't emulate rawmode for keycode 272
| keyboard.c: can't emulate rawmode for keycode 272
| keyboard.c: can't emulate rawmode for keycode 272
| 
| I am not sure if the comes from the USB keyboard or from
| the non-connected PS2 port.

I have made a couple of patches for non-AT/PS2 keyboard controllers
in 2.4.x -- and which a few people have told me that they have
used successfully.  The latest version that I have done is:
  http://www.osdl.org/archive/rddunlap/patches/kbc_option_2420.patch
if you would like to try it.

--
~Randy
