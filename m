Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316954AbSFWBfH>; Sat, 22 Jun 2002 21:35:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316955AbSFWBfG>; Sat, 22 Jun 2002 21:35:06 -0400
Received: from bitmover.com ([192.132.92.2]:28139 "EHLO bitmover.com")
	by vger.kernel.org with ESMTP id <S316954AbSFWBfG>;
	Sat, 22 Jun 2002 21:35:06 -0400
Date: Sat, 22 Jun 2002 18:35:07 -0700
From: Larry McVoy <lm@bitmover.com>
To: sean darcy <seandarcy@hotmail.com>
Cc: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>,
       linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: piggy broken in 2.5.24 build
Message-ID: <20020622183507.B26425@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	sean darcy <seandarcy@hotmail.com>,
	Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>,
	linux kernel <linux-kernel@vger.kernel.org>
References: <linux.kernel.Pine.LNX.4.44.0206221501430.7338-100000@chaos.physics.uiowa.edu> <3D152513.8010801@hotmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3D152513.8010801@hotmail.com>; from seandarcy@hotmail.com on Sat, Jun 22, 2002 at 09:32:03PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 22, 2002 at 09:32:03PM -0400, sean darcy wrote:
> Kai Germaschewski wrote:
> > On Sat, 22 Jun 2002, sean darcy wrote:
> > 
> > 
> >>At the end of make bzImage I get:
> >>
> ...................
> > So the question is why does the objcopy ... line not generate the tmp_xx
> > file. I don't see it spitting out any error either, but could you check
> > the obvious, like remaining free space on that filesystem and /tmp?
> > 
> ........................
> > --Kai
> > 
> 20 gigs free. Aren't these big new disks great?
> 
> Glad it's not a build problem. Just wish I could figure out what kind of 
> problem it is.

I just checked in some changes that changed all the find commands to 
disregard the BK directories.  Is there any chance that that could 
screw it up?  
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
