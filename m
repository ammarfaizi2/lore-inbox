Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263942AbRFDE2B>; Mon, 4 Jun 2001 00:28:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263943AbRFDE1u>; Mon, 4 Jun 2001 00:27:50 -0400
Received: from 513.holly-springs.nc.us ([216.27.31.173]:26351 "EHLO
	513.holly-springs.nc.us") by vger.kernel.org with ESMTP
	id <S263942AbRFDE1h>; Mon, 4 Jun 2001 00:27:37 -0400
Date: Mon, 4 Jun 2001 00:24:51 -0400
From: Michael Rothwell <rothwell@interlan.net>
To: James Simmons <jsimmons@transvirtual.com>
Cc: Michael Rothwell <rothwell@holly-springs.nc.us>, Andries.Brouwer@cwi.nl,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux console project <linuxconsole-dev@lists.sourceforge.net>
Subject: Re: keyboard hook?
Message-ID: <20010604002451.A5516@513.holly-springs.nc.us>
Mail-Followup-To: Michael Rothwell <rothwell@interlan.net>,
	James Simmons <jsimmons@transvirtual.com>,
	Michael Rothwell <rothwell@holly-springs.nc.us>,
	Andries.Brouwer@cwi.nl,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux console project <linuxconsole-dev@lists.sourceforge.net>
In-Reply-To: <20010603110239.A4982@513.holly-springs.nc.us> <Pine.LNX.4.10.10106032056310.14554-100000@transvirtual.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.10.10106032056310.14554-100000@transvirtual.com>; from jsimmons@transvirtual.com on Sun, Jun 03, 2001 at 09:02:18PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Input API looks nice. For now, I'll write a patch against pc_keyb.c to add a hook for my qoder stuff, and a loadable module for the meat of the driver. Then I'll port up to the input API. The Qoder is strictly ps/2 keyboard, as far as its interface goes, so I cannot use the input API for now. I have a Sparc here; does it have drivers you wish to have ported?

On Sun, Jun 03, 2001 at 09:02:18PM -0700, James Simmons wrote:
> 
> > Thanks, I'm loking through your driver now. Does the input api 
> > already/currently support ps2 keyboards?
> 
> With the current tree no. The work around is to make input api keyboards
> behave as PS/2 keyboards. In 2.5.X ps2 keyboards will be input api based. 
> As you can see we already have PS/2 input api driver (i8042.c and atkbd.c). 
> I have been using it for several months now. It is just a matter of making
> sure it works on other platforms besides intel. 
> 
> P.S
>    I also need to port other keyboard drivers on other platforms over to
> the input api and test these drivers. If anyone would like to help out
> contact me.
