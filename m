Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265314AbUAETqN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jan 2004 14:46:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265328AbUAETqN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jan 2004 14:46:13 -0500
Received: from galileo.bork.org ([66.11.174.156]:50817 "HELO galileo.bork.org")
	by vger.kernel.org with SMTP id S265314AbUAETqI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jan 2004 14:46:08 -0500
Date: Mon, 5 Jan 2004 14:46:06 -0500
From: Martin Hicks <mort@bork.org>
To: DervishD <raul@pleyades.net>
Cc: Linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Weird problems with printer using USB
Message-ID: <20040105194606.GA1112@localhost>
References: <20040105192430.GA15884@DervishD>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040105192430.GA15884@DervishD>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, Jan 05, 2004 at 08:24:30PM +0100, DervishD wrote:
>     Hi all :)
> 
>     I have a Lexmark E312 laser printer, which comes with both a parallel
> port and an USB port. It interprets PostScript, so when I print I
> simply 'cat' the file to the printer device (together with some
> codes, quite simple). This method works smoothly when using the
> printer through the parallel port, no problem, but when I use the USB
> port, sometimes I get the following:
> 
> kernel: host/usb-uhci.c: interrupt, status 2, frame# 682
> kernel: printer.c: usblp0: nonzero read/write bulk status received: -110
> kernel: printer.c: usblp0: error -84 reading printer status
> kernel: printer.c: usblp0: removed

I'm getting this same error when printing anything but the smallest
print job to an HP DeskJet 3550 USB.  Using latest RH9 errata packages.

>     I have shown one of each error messages I get in my system logs.
> Normally I get a couple or three of the first message, a few of the
> last and a good bunch of the another two. Whenever I get the message
> about the 'bulk status', the printer dies and I must turn cycle it.
> 

I also have to power cycle the printer to get it to do anything again.

mh

-- 
Martin Hicks || mort@bork.org || PGP/GnuPG: 0x4C7F2BEE
