Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316703AbSEQWgH>; Fri, 17 May 2002 18:36:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316705AbSEQWgG>; Fri, 17 May 2002 18:36:06 -0400
Received: from holomorphy.com ([66.224.33.161]:25517 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S316703AbSEQWgG>;
	Fri, 17 May 2002 18:36:06 -0400
Date: Fri, 17 May 2002 15:34:31 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
Cc: Andrew Morton <akpm@zip.com.au>, Wayne.Brown@altec.com,
        linux-kernel@vger.kernel.org
Subject: Re: kbuild 2.5 is ready for inclusion in the 2.5 kernel - take 3
Message-ID: <20020517223431.GB26374@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>,
	Andrew Morton <akpm@zip.com.au>, Wayne.Brown@altec.com,
	linux-kernel@vger.kernel.org
In-Reply-To: <20020517214247.GA26374@holomorphy.com> <Pine.LNX.4.44.0205171707510.26436-100000@chaos.physics.uiowa.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 May 2002, William Lee Irwin III wrote:
>> A build on my laptop takes well over an hour. This is not useful
>> for actually getting things done. I'm all for mitigating build
>> time in such cases, by kbuild-2.5 and perhaps other methods.

On Fri, May 17, 2002 at 05:16:22PM -0500, Kai Germaschewski wrote:
> I suppose you want ccache then. kbuild-2.5 may save two minutes of your
> one hour build. The current kbuild's problem is not that it recompiles too
> many files, but rather too few sometimes (in particular with modversions).
> (And yes, ccache won't work too well if you move your trees around, since 
> *both* build systems use absolute paths. That needs fixing)

Hmm. That kind of blows. Well, someone else's problem (or is it?). I'll
take it for what it can do now and plod along.


Cheers,
Bill
