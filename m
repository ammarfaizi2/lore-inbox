Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314705AbSECQnt>; Fri, 3 May 2002 12:43:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314706AbSECQns>; Fri, 3 May 2002 12:43:48 -0400
Received: from cpe-24-221-152-185.az.sprintbbd.net ([24.221.152.185]:11136
	"EHLO opus.bloom.county") by vger.kernel.org with ESMTP
	id <S314705AbSECQnq>; Fri, 3 May 2002 12:43:46 -0400
Date: Fri, 3 May 2002 09:43:58 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Krzysiek Taraszka <dzimi@ep09.kernel.pl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PPC and 2.2.21rc3 with modular ide subsystem
Message-ID: <20020503164358.GC894@opus.bloom.county>
In-Reply-To: <20020503155313.GA894@opus.bloom.county> <Pine.LNX.4.44.0205031802420.32723-100000@ep09.kernel.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 03, 2002 at 06:05:34PM +0200, Krzysiek Taraszka wrote:
> On Fri, 3 May 2002, Tom Rini wrote:
> 
> > Date: Fri, 3 May 2002 08:53:13 -0700
> > From: Tom Rini <trini@kernel.crashing.org>
> > To: Krzysiek Taraszka <dzimi@ep09.kernel.pl>
> > Cc: linux-kernel@vger.kernel.org
> > Subject: Re: PPC and 2.2.21rc3 with modular ide subsystem
> > 
> > On Fri, May 03, 2002 at 01:58:49PM +0200, Krzysiek Taraszka wrote:
> > 
> > > I tried compile 2.2.21rc3 with modular ide subsystem and i got that 
> > > messages:
> > 
> > Pmac IDE is not able to be built as a module.  If you just have a PCI
> > IDE card you want to use, you should be able to if you set
> > CONFIG_BLK_DEV_IDE_PMAC to n.  Otherwise you must compile it in.
> 
> What about 2.4/2.5 kernels ? 

The same restrictions apply to 2.4 as well.  It's planned to try and fix
this issue in 2.5 at some point.

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/
