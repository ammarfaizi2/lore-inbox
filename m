Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261471AbTH2RUP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Aug 2003 13:20:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261596AbTH2RRt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Aug 2003 13:17:49 -0400
Received: from yankee.rb.xcalibre.co.uk ([217.8.240.35]:4803 "EHLO
	yankee.rb.xcalibre.co.uk") by vger.kernel.org with ESMTP
	id S261556AbTH2RP3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Aug 2003 13:15:29 -0400
Envelope-to: linux-kernel@vger.kernel.org
From: Alistair J Strachan <alistair@devzero.co.uk>
To: Rahul Karnik <rahul@genebrew.com>
Subject: Re: Weird problem with nforce2
Date: Fri, 29 Aug 2003 18:15:31 +0100
User-Agent: KMail/1.5.9
References: <3F4F54F2.4080506@ihme.org> <3F4F5B1B.1030909@genebrew.com>
In-Reply-To: <3F4F5B1B.1030909@genebrew.com>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Message-Id: <200308291815.32082.alistair@devzero.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 29 August 2003 14:54, Rahul Karnik wrote:
> Markus Hästbacka wrote:
> > My chipset is NForce2, and needs NVIDIA NForce/NForce2 so the agp
> > can work with full power. Thank you.
>
> This is not true; AGP works perfectly fine with the in-kernel drivers.
> You can set your video card to use the in-kernel AGP even if it is
> Nvidia, I think (use the NvAgp option in XF86Config).
>
> If not, maybe the patch has not been updated for the latest kernels, and
> you will have to wait for someone to do so. In that case, this list is
> not the place to ask.
>

The patch is fully up to date, I'm running 2.6.0-test4-mm1.

nForce2 AGPGART plus the binary NVIDIA drivers kills my box on startup. I just 
disabled AGPGART and used NVAGP provided with the drivers and I get working 
AGP 8x.

Anybody else with this?

Cheers,
Alistair.
