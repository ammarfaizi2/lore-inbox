Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262753AbTJTRrz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Oct 2003 13:47:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262757AbTJTRrz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Oct 2003 13:47:55 -0400
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:42112 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S262753AbTJTRry (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Oct 2003 13:47:54 -0400
Date: Mon, 20 Oct 2003 18:49:26 +0100
From: John Bradford <john@grabjohn.com>
Message-Id: <200310201749.h9KHnQ0C000781@81-2-122-30.bradfords.org.uk>
To: "Richard B. Johnson" <root@chaos.analogic.com>,
       Rik van Riel <riel@redhat.com>
Cc: "Mudama, Eric" <eric_mudama@Maxtor.com>,
       "'Nuno Silva'" <nuno.silva@vgertech.com>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.53.0310201204100.13739@chaos>
References: <Pine.LNX.4.44.0310201153150.26888-100000@chimarrao.boston.redhat.com>
 <Pine.LNX.4.53.0310201204100.13739@chaos>
Subject: RE: Blockbusting news, this is important (Re: Why are bad disk se ctors numbered strangely, and what happens to them?)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Battery-backed SRAM "drives" in the gigabyte sizes already exist.
> Terabytes should not be too far off.
> 
> Soon those "drives" will be as cheap as their mechanical emulations
> and you won't need those metal boxes with the rotating mass anymore.
> The batteries last about 10 years. Better than most mechanical
> drives.

You could make a solid state device really cheaply yourself - all you
need is a simple circuit that will allow you to connect 512 Mb of
EPROMs to the parallel port, and write a device driver to make them
appear as a block device.  If you wan to boot from it, just find any
old network card with a boot PROM socket, write a bootloader which
could read a kernel image from the parallel port connected device,
write that bootloader to a PROM, and put it on the network card.

John.
