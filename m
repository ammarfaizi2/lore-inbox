Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316684AbSEQUIf>; Fri, 17 May 2002 16:08:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316685AbSEQUIe>; Fri, 17 May 2002 16:08:34 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:48822 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S316684AbSEQUId>;
	Fri, 17 May 2002 16:08:33 -0400
Date: Fri, 17 May 2002 13:07:07 -0700
From: Mike Kravetz <kravetz@us.ibm.com>
To: Bill Davidsen <davidsen@tmr.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Bug with shared memory.
Message-ID: <20020517130707.C1549@w-mikek2.des.beaverton.ibm.com>
In-Reply-To: <20020515154200.B8975@w-mikek2.des.beaverton.ibm.com> <Pine.LNX.3.96.1020517135011.15351A-100000@gatekeeper.tmr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 17, 2002 at 01:53:10PM -0400, Bill Davidsen wrote:
> On Wed, 15 May 2002, Mike Kravetz wrote:
> 
> > It appears that this was done for 'sparc64', but no other architectures.
> > I would consider doing this for i386, if anyone would actually use it.
> > 
> > One would think these types of things are easily found, but this example
> > suggests otherwise.  Has anyone run the kernel through an extensive
> > (stress) test suite with any of the kernel debug options enabled?
> 
> Does this imply that the option:
>   CONFIG_DEBUG_SPINLOCK=y
> doesn't work on x86? Or works poorly?

No I did not intend to imply this. AFAIK 'CONFIG_DEBUG_SPINLOCK=y'
works fine on x86 (although I'm not a user myself).  My intention
was only to add additional features to x86, that appear to only exist
for sparc64.

-- 
Mike
