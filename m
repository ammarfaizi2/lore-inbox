Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317169AbSFBLxg>; Sun, 2 Jun 2002 07:53:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317170AbSFBLxg>; Sun, 2 Jun 2002 07:53:36 -0400
Received: from mailg.telia.com ([194.22.194.26]:40904 "EHLO mailg.telia.com")
	by vger.kernel.org with ESMTP id <S317169AbSFBLxf>;
	Sun, 2 Jun 2002 07:53:35 -0400
To: Thunder from the hill <thunder@ngforever.de>
Cc: Daniel Phillips <phillips@bonn-fries.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: KBuild 2.5 Impressions
In-Reply-To: <Pine.LNX.4.44.0206020534461.29405-100000@hawkeye.luckynet.adm>
From: Peter Osterlund <petero2@telia.com>
Date: 02 Jun 2002 13:53:33 +0200
Message-ID: <m2bsathp6q.fsf@ppro.localdomain>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thunder from the hill <thunder@ngforever.de> writes:

> On 2 Jun 2002, Peter Osterlund wrote:
> > 3. You have to remember the "-f Makefile-2.5" arguments to make,
> >    otherwise it will use the old makefile system. This seems to mess
> >    things up so that subsequent make commands fail.
> >    I tried to "mv Makefile-2.5 Makefile" to overcome this problem, but
> >    it doesn't work because the original Makefile appears to be needed
> >    for extracting kernel version information.
> 
> There was no intention to reinvent the wheel. The only _replacing_ 
> Makefile is a _merged_ version of them. Then you'll also have to find any 
> Makefile-2.5s and revert them to Makefiles. This will take a moment, and 
> is not yet intented.

Yes, I realize this problem will go away automatically when support
for the old makefile system is removed. I just wanted to present my
complete list of problems with kbuild 2.5. Except for those three
issues, I don't see any advantages with the old makefile system.

-- 
Peter Osterlund - petero2@telia.com
http://w1.894.telia.com/~u89404340
