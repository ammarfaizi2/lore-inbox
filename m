Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318868AbSHLX3L>; Mon, 12 Aug 2002 19:29:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318869AbSHLX3L>; Mon, 12 Aug 2002 19:29:11 -0400
Received: from cpe-24-221-152-185.az.sprintbbd.net ([24.221.152.185]:15512
	"EHLO Bill-The-Cat.bloom.county") by vger.kernel.org with ESMTP
	id <S318868AbSHLX3K>; Mon, 12 Aug 2002 19:29:10 -0400
Date: Mon, 12 Aug 2002 16:32:17 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>,
       Greg Banks <gnb@alphalink.com.au>,
       Peter Samuelson <peter@cadcamlab.org>, linux-kernel@vger.kernel.org,
       kbuild-devel@lists.sourceforge.net
Subject: Re: [patch] config language dep_* enhancements
Message-ID: <20020812233217.GH20176@opus.bloom.county>
References: <20020812224704.GG20176@opus.bloom.county> <Pine.LNX.4.44.0208130053360.28515-100000@serv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0208130053360.28515-100000@serv>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 13, 2002 at 01:17:15AM +0200, Roman Zippel wrote:
> Hi,
> 
> On Mon, 12 Aug 2002, Tom Rini wrote:
> 
> > > A bit more flexibility certainly wouldn't hurt. :)
> >
> > What does that gain however?  And it wouldn't make as much sense to
> > offer the IBM Spruce (750) next to the IBM Walnut (405GP).
> 
> You weren't forced to sort them by cpu type. Maybe it works as is, you
> should know that better than me.

heh.  It is something actually works pretty well, and with the rare
exception of things which can show up twice (see below) it's rather
logical too.

> I only used it as an example, because my tool has problems to
> automatically convert this construct into something useful (e.g. because
> of CONFIG_WILLOW in 2 seperate choice statements).

That's because CONFIG_WILLOW can either have an 8260 CPU or a 7xx/74xx
CPU.  Or I think an ARM cpu...  And unfortunatly I don't think support
for anything beyond maybe 8260 is actually in the trees right now
anyhow.

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/
