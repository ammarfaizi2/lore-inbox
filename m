Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272016AbRHVOud>; Wed, 22 Aug 2001 10:50:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272021AbRHVOuX>; Wed, 22 Aug 2001 10:50:23 -0400
Received: from cpe-24-221-152-185.az.sprintbbd.net ([24.221.152.185]:30343
	"EHLO opus.bloom.county") by vger.kernel.org with ESMTP
	id <S272016AbRHVOuM>; Wed, 22 Aug 2001 10:50:12 -0400
Date: Wed, 22 Aug 2001 07:50:22 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Kent Borg <kentborg@borg.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: State of PPC in kernel.org Sources?
Message-ID: <20010822075022.G6366@cpe-24-221-152-185.az.sprintbbd.net>
In-Reply-To: <20010822094440.B11350@borg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010822094440.B11350@borg.org>
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 22, 2001 at 09:44:40AM -0400, Kent Borg wrote:

> What is the state of Power PC support in Linus' kernels?  What about
> in -ac kernels?  

2.4.8 is just dandy on most (6xx/7xx/74xx) PPCs.  The default config won't
compile because of one of the IDE options (CONFIG_BLK_DEV_SL82C105), but
aside from that, it's good.

> I have noticed some recent PPC work in summaries of recent -ac kernels
> and wonder how intact it is.

Just Alan picking up what Paul sends to linux-kernel.

> Are they merges to keep PPC forks from
> drifting too far?

2.4.8 vs the PPC tree at the time was very close.  Hopefully 2.4.10 will be
as well.

> Are they merges to make furture back-ports from
> kernel.org to PPC forks easier?  Are they actually complete in and of
> themselves but lagging PPC forks?  (What about 405 support?  I think I
> see evidence of recent 405 activity in 2.4.8-ac4...)

4xx support hasn't worked in the 'stable' trees for a while.  It's finally
being caught up in the '2_4_devel' tree.  See 
http://penguinppc.org/dev/kernel.shtml

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/
