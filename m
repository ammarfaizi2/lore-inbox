Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264278AbTH1UZd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Aug 2003 16:25:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264282AbTH1UZd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Aug 2003 16:25:33 -0400
Received: from kweetal.tue.nl ([131.155.3.6]:19723 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id S264278AbTH1UZ2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Aug 2003 16:25:28 -0400
Date: Thu, 28 Aug 2003 22:25:26 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: "H.Rosmanith (Kernel Mailing List)" <kernel@wildsau.idv.uni.linz.at>
Cc: Andries Brouwer <aebr@win.tue.nl>, root@chaos.analogic.com,
       linux-kernel@vger.kernel.org
Subject: Re: usb-storage: how to ruin your hardware(?)
Message-ID: <20030828222526.A2441@pclin040.win.tue.nl>
References: <20030828154454.A2343@pclin040.win.tue.nl> <200308281618.h7SGIMMp014455@wildsau.idv.uni.linz.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200308281618.h7SGIMMp014455@wildsau.idv.uni.linz.at>; from kernel@wildsau.idv.uni.linz.at on Thu, Aug 28, 2003 at 06:18:22PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 28, 2003 at 06:18:22PM +0200, H.Rosmanith (Kernel Mailing List) wrote:

> > [If you only think about cylinder boundaries: cylinders do not exist,
> > and cylinder boundaries do not exist either. So that in itself does
> > not mean a thing.]
> 
> well ... I would assume that a proper "emulation" of a harddisk by a
> flashdrive would also look like a real harddisk, with correct
> cylinder boundaries. But obviously, this is not the case. Should
> I get a new drive, I will mail you the strange-looking partiotion-table:
> it will look like "physical start at (0,3,3)" or similar.

Didnt you get formatting utilities to repair such situations?

But concerning cylinders: Also harddisks do not have cylinders in the
partition table sense. Disk geometry is a fiction. If you print a
partition table and it looks ugly given one fiction, this just means
that you can invent some other fiction that makes it look nicer.
There is no underlying reality to these cylinder boundaries.

