Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317400AbSIEKxs>; Thu, 5 Sep 2002 06:53:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317402AbSIEKxs>; Thu, 5 Sep 2002 06:53:48 -0400
Received: from pc1-cwma1-5-cust128.swa.cable.ntl.com ([80.5.120.128]:27899
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S317400AbSIEKxs>; Thu, 5 Sep 2002 06:53:48 -0400
Subject: Re: 2.4.x (including -ac) SiS agp not recognized
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "Murray J. Root" <murrayr@brain.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020905013149.GA31910@Master.Wizards>
References: <20020905013149.GA31910@Master.Wizards>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-6) 
Date: 05 Sep 2002 11:59:11 +0100
Message-Id: <1031223551.6178.4.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-09-05 at 02:31, Murray J. Root wrote:
> SiS645DX chipset:
> 
> Sep  2 03:28:17 Master kernel: Linux agpgart interface v0.99 (c) Jeff Hartmann
> Sep  2 03:28:17 Master kernel: agpgart: Maximum main memory to use for agp memory: 816M
> Sep  2 03:28:17 Master kernel: agpgart: Unsupported SiS chipset (device id: 0646), you might want to
>  try agp_try_unsupported=1.
> Sep  2 03:28:17 Master kernel: agpgart: no supported devices found.

Try insmod agpgart agp_try_unsupported=1 and see if it works. (it may
crash if not)

