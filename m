Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262880AbTIANXo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Sep 2003 09:23:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262881AbTIANXo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Sep 2003 09:23:44 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:39326 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262880AbTIANXn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Sep 2003 09:23:43 -0400
Date: Mon, 1 Sep 2003 10:26:24 -0300 (BRT)
From: Marcelo Tosatti <marcelo@parcelfarce.linux.theplanet.co.uk>
X-X-Sender: marcelo@logos.cnet
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: request_firmware() backport to 2.4
In-Reply-To: <1062421224.13730.111.camel@pegasus>
Message-ID: <Pine.LNX.4.44.0309011022140.2504-100000@logos.cnet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On 1 Sep 2003, Marcel Holtmann wrote:

> Hi Marcelo,
> 
> > > I have collected the patches for the request_firmware() interface
> > > backport for 2.4 done by Manuel Estrada Sainz. It is now in -ac for a
> > > while and I have used it in my -mh patches. It works fine and seems to
> > > be clean and very stable. Karsten Keil has tested it together with my
> > > ported bfusb.o Bluetooth driver on AMD64.
> > > 
> > > Please do a
> > > 
> > >         bk pull http://linux-mh.bkbits.net/fw-loader-2.4
> > > 
> > > This will update the following files:
> > > 
> > >  drivers/bluetooth/bfusb.h                             |52261 ------------------
> > 
> > Now bfusb loads "bfubase.frm", but stock kernel has no such thing. 
> > 
> > I assume that breaks bfusb?
> 
> no, the bfubase.frm is the original firmware file from AVM. This file
> have to be placed somewhere on the filesystem. 

Right, and without placing the file somewhere on the filesystem bfusb
2.4.22 users wont have 2.4.23 working without "issues".

But well, I dont know if I should care that much. 


