Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272038AbRIQSm7>; Mon, 17 Sep 2001 14:42:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271995AbRIQSmt>; Mon, 17 Sep 2001 14:42:49 -0400
Received: from cpe-24-221-152-185.az.sprintbbd.net ([24.221.152.185]:11920
	"EHLO opus.bloom.county") by vger.kernel.org with ESMTP
	id <S272038AbRIQSmj>; Mon, 17 Sep 2001 14:42:39 -0400
Date: Mon, 17 Sep 2001 11:42:41 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Allan Sandfeld <linux@sneulv.dk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] bzImage target for PPC
Message-ID: <20010917114241.C23163@cpe-24-221-152-185.az.sprintbbd.net>
In-Reply-To: <E15ivIz-00087v-00@wagner> <E15j1Jr-0002ci-00@Princess>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E15j1Jr-0002ci-00@Princess>
User-Agent: Mutt/1.3.22i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 17, 2001 at 06:32:25PM +0200, Allan Sandfeld wrote:

> What is holding us back from deciding on a limited number of supported and 
> implemented make targets and making these fast(e.g. moving install to top 
> level)? This would then become a part of kbuild2.5

Eh?  What kbuild2.5 does, last time I looked at it, is let the user pick from
the list of targets for that arch, for 'installable'.  This looks great
from the PPC side, which has ~6 targets for this right now.  No need to
limit to some 'generic' names or limit the number.  For 2.4, I don't think
we should bother to do anything, except _maybe_ change the text after
oldconfig/whatnot to say 'zImage or bzImage and then install'  Or nuke
it all together.

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/
