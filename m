Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316715AbSEQWkF>; Fri, 17 May 2002 18:40:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316717AbSEQWkE>; Fri, 17 May 2002 18:40:04 -0400
Received: from bitmover.com ([192.132.92.2]:14241 "EHLO bitmover.com")
	by vger.kernel.org with ESMTP id <S316715AbSEQWkE>;
	Fri, 17 May 2002 18:40:04 -0400
Date: Fri, 17 May 2002 15:40:04 -0700
From: Larry McVoy <lm@bitmover.com>
To: William Lee Irwin III <wli@holomorphy.com>,
        Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>,
        Andrew Morton <akpm@zip.com.au>, Wayne.Brown@altec.com,
        linux-kernel@vger.kernel.org
Subject: Re: kbuild 2.5 is ready for inclusion in the 2.5 kernel - take 3
Message-ID: <20020517154004.I8794@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	William Lee Irwin III <wli@holomorphy.com>,
	Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>,
	Andrew Morton <akpm@zip.com.au>, Wayne.Brown@altec.com,
	linux-kernel@vger.kernel.org
In-Reply-To: <20020517214247.GA26374@holomorphy.com> <Pine.LNX.4.44.0205171707510.26436-100000@chaos.physics.uiowa.edu> <20020517223431.GB26374@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 17, 2002 at 03:34:31PM -0700, William Lee Irwin III wrote:
> On Fri, May 17, 2002 at 05:16:22PM -0500, Kai Germaschewski wrote:
> > I suppose you want ccache then. kbuild-2.5 may save two minutes of your
> > one hour build. The current kbuild's problem is not that it recompiles too
> > many files, but rather too few sometimes (in particular with modversions).
> > (And yes, ccache won't work too well if you move your trees around, since 
> > *both* build systems use absolute paths. That needs fixing)
> 
> Hmm. That kind of blows. Well, someone else's problem (or is it?). I'll
> take it for what it can do now and plod along.

In the for what it is worth department, we like ccache here at BitMover and
converted the CVS tree to BK just for fun.

	http://ccache.bkbits.net

-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
