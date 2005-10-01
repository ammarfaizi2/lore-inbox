Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750858AbVJAV2W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750858AbVJAV2W (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Oct 2005 17:28:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750859AbVJAV2W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Oct 2005 17:28:22 -0400
Received: from smtpout5.uol.com.br ([200.221.4.196]:54233 "EHLO
	smtp.uol.com.br") by vger.kernel.org with ESMTP id S1750856AbVJAV2V
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Oct 2005 17:28:21 -0400
Date: Sat, 1 Oct 2005 18:28:06 -0300
From: =?iso-8859-1?Q?Rog=E9rio?= Brito <rbrito@ime.usp.br>
To: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
Cc: Grant Coady <grant_lkml@dodo.com.au>, linux-kernel@vger.kernel.org
Subject: Re: Strange disk corruption with Linux >= 2.6.13
Message-ID: <20051001212806.GD6397@ime.usp.br>
Mail-Followup-To: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>,
	Grant Coady <grant_lkml@dodo.com.au>, linux-kernel@vger.kernel.org
References: <20050927111038.GA22172@ime.usp.br> <9ncij11fqb4l70qrhb0a8nri5moohnkaaf@4ax.com> <20050927140434.GL28578@csclub.uwaterloo.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20050927140434.GL28578@csclub.uwaterloo.ca>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sep 27 2005, Lennart Sorensen wrote:
> The board is allowed 1.5GB using 3 x 512M.  I believe the 512M modules
> must be double sided to work but I am not 100% sure of that.

Right now, I'm using just a single 512MB module, but it is single-sided
(I guess that by double-sided you guys mean that it has chips on both
sides of the module, right?). The only double-sided module that I have
here is the 256MB module.

OTOH, with just one 512MB everything *seems* to be working fine, but,
honestly, I'm not sure.

> It is also generally unstable if set to anything over PC100 memory speed
> in my experience (my machine has the same board).

Hummm, nice to see that you have also experienced this. With 256 + 128,
I had to use PC100 to have it work stably.

> The memory speed detection doesn't work properly.  I have found it
> perfectly stable when set to PC100 in bios and using PC133 memory.  It
> seems to prefer having the extra margin.

I'd obviously prefer to have everything working at PC133 speed, but
wouldn't mind running at PC100 speed if I could use everything, since I
sometimes need to use some large programs (for some dynamic programming
problems).


Thanks for sharing your experiences,

-- 
Rogério Brito : rbrito@ime.usp.br : http://www.ime.usp.br/~rbrito
Homepage of the algorithms package : http://algorithms.berlios.de
Homepage on freshmeat:  http://freshmeat.net/projects/algorithms/
