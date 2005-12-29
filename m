Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750835AbVL2SvN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750835AbVL2SvN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Dec 2005 13:51:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750836AbVL2SvN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Dec 2005 13:51:13 -0500
Received: from waste.org ([64.81.244.121]:56793 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S1750835AbVL2SvN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Dec 2005 13:51:13 -0500
Date: Thu, 29 Dec 2005 12:47:18 -0600
From: Matt Mackall <mpm@selenic.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel <linux-kernel@vger.kernel.org>,
       linux-tiny@selenic.com
Subject: Re: [PATCH] Make vm86 support optional
Message-ID: <20051229184717.GY3356@waste.org>
References: <20051228202735.GU3356@waste.org> <20051229043900.GD4872@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051229043900.GD4872@stusta.de>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 29, 2005 at 05:39:00AM +0100, Adrian Bunk wrote:
> On Wed, Dec 28, 2005 at 02:27:35PM -0600, Matt Mackall wrote:
> >...
> > +config VM86
> > +	depends X86
> > +	default y
> > +	bool "Enable VM86 support" if EMBEDDED
> > +	help
> > +          This option is required by programs like DOSEMU to run 16-bit legacy
> > +	  code on X86 processors. It also may be needed by software like
> > +          XFree86 to initialize some video cards via BIOS. Disabling this
> > +          option saves about 6k.
> >...
> 
> I don't like such space statements ("about 6k") in help texts, since 
> history has shown that noone updates them when the actual size 
> changes...

What would you prefer? It's important to give a relative size vs
functionality savings so people can decide whether they want a feature
and simply saying a little/a lot is insufficient.

-- 
Mathematics is the supreme nostalgia of our time.
