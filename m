Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265063AbSJaBDy>; Wed, 30 Oct 2002 20:03:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265065AbSJaBDy>; Wed, 30 Oct 2002 20:03:54 -0500
Received: from ip68-105-128-224.tc.ph.cox.net ([68.105.128.224]:43944 "EHLO
	Bill-The-Cat.bloom.county") by vger.kernel.org with ESMTP
	id <S265063AbSJaBDx>; Wed, 30 Oct 2002 20:03:53 -0500
Date: Wed, 30 Oct 2002 18:10:02 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: Rasmus Andersen <rasmus@jaquet.dk>, linux-kernel@vger.kernel.org
Subject: Re: CONFIG_TINY
Message-ID: <20021031011002.GB28191@opus.bloom.county>
References: <20021030233605.A32411@jaquet.dk> <Pine.NEB.4.44.0210310145300.20835-100000@mimas.fachschaften.tu-muenchen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.NEB.4.44.0210310145300.20835-100000@mimas.fachschaften.tu-muenchen.de>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 31, 2002 at 01:53:14AM +0100, Adrian Bunk wrote:
> On Wed, 30 Oct 2002, Rasmus Andersen wrote:
> 
> > Hi,
> 
> Hi Rasmus,
> 
> >...
> > As before, your comments and suggestions will be
> > appreciated.
> 
> could you try to use "-Os" instead of "-O2" as gcc optimization option
> when CONFIG_TINY is enabled? Something like the following (completely
> untested) patch:

-Os can produce larger binaries, keep in mind.  If we're going to go
this route, how about something generally useful, and allow for general
optimization level / additional CFLAGS to be added.

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/
