Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318865AbSHLWnh>; Mon, 12 Aug 2002 18:43:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318866AbSHLWnh>; Mon, 12 Aug 2002 18:43:37 -0400
Received: from cpe-24-221-152-185.az.sprintbbd.net ([24.221.152.185]:64407
	"EHLO Bill-The-Cat.bloom.county") by vger.kernel.org with ESMTP
	id <S318865AbSHLWng>; Mon, 12 Aug 2002 18:43:36 -0400
Date: Mon, 12 Aug 2002 15:47:04 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>,
       Greg Banks <gnb@alphalink.com.au>,
       Peter Samuelson <peter@cadcamlab.org>, linux-kernel@vger.kernel.org,
       kbuild-devel@lists.sourceforge.net
Subject: Re: [patch] config language dep_* enhancements
Message-ID: <20020812224704.GG20176@opus.bloom.county>
References: <20020812221555.GF20176@opus.bloom.county> <Pine.LNX.4.44.0208130021200.28515-100000@serv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0208130021200.28515-100000@serv>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 13, 2002 at 12:32:50AM +0200, Roman Zippel wrote:
> Hi,
> 
> On Mon, 12 Aug 2002, Tom Rini wrote:
> 
> > > There is still a bit of overlap. Roughly it's possible to sort the machine
> > > types by cpu type, but IMO it's not the best solution. I think it would be
> > > better to sort them by general machine type.
> >
> > Er, 'general machine type' ?
> 
> +-RPX
> | +- ...
> +-TQM
> | +- ...
> +-Motorola
> | +- ...
> ...
> 
> A bit more flexibility certainly wouldn't hurt. :)

What does that gain however?  And it wouldn't make as much sense to
offer the IBM Spruce (750) next to the IBM Walnut (405GP).

So in short, the various choice menus in arch/ppc/config.in aren't to
work around CML1 issues, it an intentional design (which really needs to
become 4 files).

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/
