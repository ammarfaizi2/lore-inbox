Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261582AbSJUSYP>; Mon, 21 Oct 2002 14:24:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261584AbSJUSYO>; Mon, 21 Oct 2002 14:24:14 -0400
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:60424 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S261582AbSJUSYB>;
	Mon, 21 Oct 2002 14:24:01 -0400
Date: Mon, 21 Oct 2002 11:29:05 -0700
From: Greg KH <greg@kroah.com>
To: Adam Belay <ambx1@neo.rr.com>, linux-kernel@vger.kernel.org,
       stelian.pop@fr.alcove.com, bunk@fs.tum.de, zippel@linux-m68k.org,
       skip.ford@verizon.net
Subject: Re: [PATCH] PnP Rewrite Fixes - 2.5.44
Message-ID: <20021021182905.GD32441@kroah.com>
References: <20021019151948.GA328@neo.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021019151948.GA328@neo.rr.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 19, 2002 at 03:19:48PM +0000, Adam Belay wrote:
> This patch addresses a few minor issues for the Linux Plug and Play Rewrite.  It
> is against 2.5.44.
> 
> They are as follows.
> 
> 1.) fix Config.in file - from Adrian Bunk and Roman Zippel
> 2.) if unable to activate a device the match should fail.  This can be done now 
> that the driver model matching bug has been corrected.
> 3.) move compat.c to isapnp directory and fix everything accordingly - suggested
> by Stelian Pop.  This fixes a compile error if ISAPNP is disabled.
> 4.) fix a typo in pnp.h - patch from Skip Ford
> 
> Please Apply,

Thanks, I've added this to a bk tree, and will send to Linus when he
gets back from vacation.

greg k-h
