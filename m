Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263760AbSKRSX4>; Mon, 18 Nov 2002 13:23:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263968AbSKRSXz>; Mon, 18 Nov 2002 13:23:55 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:13572 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S263760AbSKRSXx>;
	Mon, 18 Nov 2002 13:23:53 -0500
Message-ID: <3DD931BA.9040407@pobox.com>
Date: Mon, 18 Nov 2002 13:30:18 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2b) Gecko/20021018
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Eyal Lebedinsky <eyal@eyal.emu.id.au>
CC: list linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: RTL8139D support for 2.4?
References: <3DD8B521.19184544@eyal.emu.id.au>
In-Reply-To: <3DD8B521.19184544@eyal.emu.id.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eyal Lebedinsky wrote:

> I recently got a local (Australian, NetComm) NIC that uses a 8139D.
> The standard 8139too seems to work with it but I wonder if I can
> get something more out of a driver that has extra support.

[...]

> Anyone knows the difference between the 8139C and 8139D?



At the driver level, there should not be appreciable differences between 
the two chips.  8139C+ is the super-cool tulip-like chip from RealTek 
with all the speed and features.  8139D is just a small incremental 
revision of the chip.  It does add a few features, but none that would 
affect performance or stability (positively or negatively).

RealTek's 8139C+, and it's GigE cousin 8169 are really nice.  I hope 
RealTek finds a lot of customers for these chips, because so far they 
are both solid, fast, and feature-full.

Regards,

	Jeff



