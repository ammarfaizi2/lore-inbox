Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265708AbSL1Uz4>; Sat, 28 Dec 2002 15:55:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265713AbSL1Uzt>; Sat, 28 Dec 2002 15:55:49 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:5384 "EHLO www.home.local")
	by vger.kernel.org with ESMTP id <S265708AbSL1Uzr>;
	Sat, 28 Dec 2002 15:55:47 -0500
Date: Sat, 28 Dec 2002 22:04:01 +0100
From: Willy Tarreau <willy@w.ods.org>
To: "Justin T. Gibbs" <gibbs@scsiguy.com>
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] aic7xxx bouncing over 4G
Message-ID: <20021228210401.GA596@alpha.home.local>
References: <200212210012.gBL0Cng21338@eng2.beaverton.ibm.com> <176730000.1040430221@aslan.btc.adaptec.com> <3E03BB0D.5070605@rackable.com> <Pine.LNX.4.50L.0212280331110.30646-100000@freak.distro.conectiva> <20021228091608.GA13814@louise.pinerecords.com> <Pine.LNX.4.50L.0212281131580.26879-100000@imladris.surriel.com> <705128112.1041102818@aslan.scsiguy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <705128112.1041102818@aslan.scsiguy.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 28, 2002 at 12:13:38PM -0700, Justin T. Gibbs wrote:
> The main reason why the new driver "breaks" where the old one
> doesn't is that the new driver does not perform an extra register
> read to work-around chipsets that screw up memory mapped I/O.

Thanks for this clear description, Justin. I now understand why I've had
problems in the past with earlier versions here, since I have other devices
(eg dl2k) which can't do MMIO on my system.

Cheers,
Willy

