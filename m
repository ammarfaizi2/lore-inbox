Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261674AbSJFQ3w>; Sun, 6 Oct 2002 12:29:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261677AbSJFQ3w>; Sun, 6 Oct 2002 12:29:52 -0400
Received: from pc1-cwma1-5-cust51.swa.cable.ntl.com ([80.5.120.51]:42737 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261674AbSJFQ3w>; Sun, 6 Oct 2002 12:29:52 -0400
Subject: Re: Bizarre network issue
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Mazhar Memon <mazhar@nmt.edu>
Cc: law@dodinc.com, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20021005210308.07d381ff.mazhar@nmt.edu>
References: <3D9F7169.8020008@dodinc.com> 
	<20021005210308.07d381ff.mazhar@nmt.edu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 06 Oct 2002 17:44:09 +0100
Message-Id: <1033922649.21282.18.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2002-10-06 at 04:03, Mazhar Memon wrote:
> Are you willing share your code? I'd love to see what you have so far since I have a similar project.  It is basically using a wireless link that supposed to look like a terminal.  I'm hoping that all I'll need to do is make a simple driver to implement hard_start_xmit and let pppd do the rest.  Probably like your radio, it has a 0-7 network id which I assume you are including in your MAC addr some how.

For network protocols you might also want to look at the daemon called
"scarabd" that Robin O'Leary and I did years ago for a low speed radio
modem that needed software to manage things like tx/rx, carrier handling
and so forth

