Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264760AbSKFKfp>; Wed, 6 Nov 2002 05:35:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264861AbSKFKfp>; Wed, 6 Nov 2002 05:35:45 -0500
Received: from twilight.ucw.cz ([195.39.74.230]:28037 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S264760AbSKFKfo>;
	Wed, 6 Nov 2002 05:35:44 -0500
Date: Wed, 6 Nov 2002 11:42:15 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: vojtech@suse.cz, linux-kernel@vger.kernel.org
Subject: Re: busmouse support (2 of them?)
Message-ID: <20021106114215.E25154@ucw.cz>
References: <Pine.LNX.4.33L2.0211051734410.21048-100000@dragon.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.33L2.0211051734410.21048-100000@dragon.pdx.osdl.net>; from rddunlap@osdl.org on Tue, Nov 05, 2002 at 05:37:37PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 05, 2002 at 05:37:37PM -0800, Randy.Dunlap wrote:
> 
> Hi,
> 
> In (menu)config, there is
>   Character Devices, Mice --->, Bus mouse support
> and then there is
>   Input drivers, Mice, Inport busmouse
> 
> Are both of these needed?  I.e., can the first one be removed?

The first can be removed once all the drivers using the busmouse.c
infrastructure are removed. They were all removed on i386 and other
modern architectures, but I'm not 100% sure some Atari driver is not
using it.

-- 
Vojtech Pavlik
SuSE Labs
