Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266939AbSKSPj7>; Tue, 19 Nov 2002 10:39:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266948AbSKSPj7>; Tue, 19 Nov 2002 10:39:59 -0500
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:20712 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S266939AbSKSPj5>;
	Tue, 19 Nov 2002 10:39:57 -0500
Date: Tue, 19 Nov 2002 15:45:18 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: Alan Cox <alan@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.5.47-ac6
Message-ID: <20021119154518.GA560@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Alan Cox <alan@redhat.com>, linux-kernel@vger.kernel.org
References: <200211191414.gAJEE8N05498@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200211191414.gAJEE8N05498@devserv.devel.redhat.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 19, 2002 at 09:14:08AM -0500, Alan Cox wrote:

 > | Still versus 2.5.47 - the 2.5.48 tree is a little bit too broken to run
 > | IDE development against. This should also get pnp working on the 
 > | RadeonIGP boxes and fix several weird early boot crashes
 > 
 > Linux 2.5.47-ac6
 > o	Move isapnp to device_init			(me)
 > 	| This is needed so pci init runs first and can mark
 > 	| areas reserved before PnP stomps on them blindly
 > o	Reserve 0x3d3 on the ATI chipset		(me)
 > 	| These two fix isapnp on the Presario 900 at least

FYI, This seems to work fine on my Compaq Evo N1015v too.
This monster seems to have the same chipset as you mentioned.
(unknown ATI gfx card id: 1002:4336, with ALI bridge)

Every other 2.4 kernel goes mental with machine checks,
and assorted IDE errors. had to use a 2.2 Debian install
to get things off the ground. Strange how 2.2 IDE worked much
better than 2.4's here.

		Dave
-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
