Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316712AbSEQWQ1>; Fri, 17 May 2002 18:16:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316725AbSEQWQ0>; Fri, 17 May 2002 18:16:26 -0400
Received: from chaos.physics.uiowa.edu ([128.255.34.189]:16533 "EHLO
	chaos.physics.uiowa.edu") by vger.kernel.org with ESMTP
	id <S316712AbSEQWQ0>; Fri, 17 May 2002 18:16:26 -0400
Date: Fri, 17 May 2002 17:16:22 -0500 (CDT)
From: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
X-X-Sender: kai@chaos.physics.uiowa.edu
To: William Lee Irwin III <wli@holomorphy.com>
cc: Andrew Morton <akpm@zip.com.au>, <Wayne.Brown@altec.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: kbuild 2.5 is ready for inclusion in the 2.5 kernel - take 3
In-Reply-To: <20020517214247.GA26374@holomorphy.com>
Message-ID: <Pine.LNX.4.44.0205171707510.26436-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 May 2002, William Lee Irwin III wrote:

> On Fri, May 17, 2002 at 02:14:38PM -0700, Andrew Morton wrote:
> > The deteriorating performance of gcc and the tendency of
> > the current build system to needlessly recompile stuff are
> > acute problems.  ccache saves me probably one hour per day.
> 
> A build on my laptop takes well over an hour. This is not useful
> for actually getting things done. I'm all for mitigating build
> time in such cases, by kbuild-2.5 and perhaps other methods.

I suppose you want ccache then. kbuild-2.5 may save two minutes of your
one hour build. The current kbuild's problem is not that it recompiles too
many files, but rather too few sometimes (in particular with modversions).

(And yes, ccache won't work too well if you move your trees around, since 
*both* build systems use absolute paths. That needs fixing)

--Kai


