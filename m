Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262034AbSIYRma>; Wed, 25 Sep 2002 13:42:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262037AbSIYRma>; Wed, 25 Sep 2002 13:42:30 -0400
Received: from magic.adaptec.com ([208.236.45.80]:48054 "EHLO
	magic.adaptec.com") by vger.kernel.org with ESMTP
	id <S262034AbSIYRm3>; Wed, 25 Sep 2002 13:42:29 -0400
Date: Wed, 25 Sep 2002 11:47:36 -0600
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
Reply-To: "Justin T. Gibbs" <gibbs@scsiguy.com>
To: "Cress, Andrew R" <andrew.r.cress@intel.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: aic7xxx support for aic7902?
Message-ID: <1338716224.1032976056@aslan.btc.adaptec.com>
In-Reply-To: <A5974D8E5F98D511BB910002A50A66470580D20D@hdsmsx103.hd.intel.com>
References: <A5974D8E5F98D511BB910002A50A66470580D20D@hdsmsx103.hd.intel.com
 >
X-Mailer: Mulberry/3.0.0a4 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Justin,
> 
> I've seen a special U320 driver aic79xx v1.10, but I suppose that the new
> U320 controllers will be folded into a new version of your aic7xxx driver
> (?).

Nope.  The U320 chips will never be supported in the aic7xxx driver due
to their very different architecture.  aic79xx v1.1.0 (or 1.1.1 which
includes the port to the 2.5.X kernels) is what you want.

> If so, I'd like to know which version of the aic7xxx driver will
> include support of the new aic7902 controller, and which kernel version
> will be targeted to have that folded in.  

Which kernel version it will be folded into is beyond my control.  The
code has been sent to both Marcelo and Linus.

--
Justin
