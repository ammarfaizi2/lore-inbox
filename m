Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270576AbTGVBlh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jul 2003 21:41:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267491AbTGVBlb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jul 2003 21:41:31 -0400
Received: from fw.osdl.org ([65.172.181.6]:30675 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S270778AbTGVBlD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jul 2003 21:41:03 -0400
Date: Mon, 21 Jul 2003 18:53:35 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Matthew Harrell 
	<mharrell-dated-1059270228.4188fe@bittwiddlers.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: hid: ctrl urb status -75?
Message-Id: <20030721185335.1c6ca3e8.rddunlap@osdl.org>
In-Reply-To: <20030722014345.GA9226@bittwiddlers.com>
References: <20030722012137.GA7159@bittwiddlers.com>
	<20030721183338.44634e51.rddunlap@osdl.org>
	<20030722014345.GA9226@bittwiddlers.com>
Organization: OSDL
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i586-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Jul 2003 21:43:45 -0400 Matthew Harrell <mharrell-dated-1059270228.4188fe@bittwiddlers.com> wrote:

| : include/asm-generic/errno.h says that 75 is EOVERFLOW.
| : Now look in Documentation/usb/error-codes.txt and it says that
| : EOVERFLOW is used for:
| : -EOVERFLOW (*)		The amount of data returned by the endpoint was
| : 			greater than either the max packet size of the
| : 			endpoint or the remaining buffer size.  "Babble".
| : 
| : The device returned too much data.
| : See whichever host controller driver you are using for details.
| 
| Strange.  Thanks.  For some reason I was thinking those error codes returned
| by the driver were more specific to it.  I see where the message is generated
| and now just need to figure out what the deal is with it here.  It works fine
| under at least two other OSes so I know the keyboard works.

Well, there could be unknown workarounds or there could be some
corner case(s) that linux-usb doesn't quite handle, so good luck
on it.  Is source code available for either of the other working
OSes?

--
~Randy
| http://developer.osdl.org/rddunlap/ | http://www.xenotime.net/linux/ |
Linux-2.6 FAQA:
http://www.codemonkey.org.uk/post-halloween-2.5.txt
  or http://lwn.net/Articles/39901/
http://www.kernel.org/pub/linux/kernel/people/rusty/modules/
