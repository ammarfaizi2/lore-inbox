Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261868AbSL2WSJ>; Sun, 29 Dec 2002 17:18:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261874AbSL2WSJ>; Sun, 29 Dec 2002 17:18:09 -0500
Received: from smtp06.iddeo.es ([62.81.186.16]:5265 "EHLO smtp06.retemail.es")
	by vger.kernel.org with ESMTP id <S261868AbSL2WSH>;
	Sun, 29 Dec 2002 17:18:07 -0500
Date: Sun, 29 Dec 2002 23:26:28 +0100
From: "J.A. Magallon" <jamagallon@able.es>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] make i2c use initcalls everywhere
Message-ID: <20021229222628.GC2259@werewolf.able.es>
References: <20021229220436.A11420@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <20021229220436.A11420@lst.de>; from hch@lst.de on Sun, Dec 29, 2002 at 22:04:36 +0100
X-Mailer: Balsa 2.0.4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2002.12.29 Christoph Hellwig wrote:
> The use of explicit initializers all over the i2c core anoyed for
> long, but the lm_sensors merge with two new files just for initializers
> was too much.  Conver all of i2c to sane initialization (mostly
> initcall, but some driver also got other cleanups in that area)
> 

Wil this reach the i2c maintainer or the next auto-generated patch from i2c
2.8.x will undo what you do now and will be sized 4Gb  ?

Will i2c ever get in sync into 2.4 ? Nowadays the main of the patch is a ton
of 'stupid' changes from printk(xxx) to I2C_DEBUG(xxx) or the like.
Will this be accepted if I submit it, even independently of the maintainer ?
Because I suppose (???) that maintainer is sending changes and they are going
to trash...

-- 
J.A. Magallon <jamagallon@able.es>      \                 Software is like sex:
werewolf.able.es                         \           It's better when it's free
Mandrake Linux release 9.1 (Cooker) for i586
Linux 2.4.21-pre2-jam2 (gcc 3.2.1 (Mandrake Linux 9.1 3.2.1-2mdk))
