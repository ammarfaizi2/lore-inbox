Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285828AbSAIOXs>; Wed, 9 Jan 2002 09:23:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286825AbSAIOXj>; Wed, 9 Jan 2002 09:23:39 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:29804 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S285828AbSAIOXS>; Wed, 9 Jan 2002 09:23:18 -0500
Date: Wed, 9 Jan 2002 15:22:21 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: Robert Love <rml@tech9.net>, Anton Blanchard <anton@samba.org>,
        Luigi Genoni <kernel@Expansa.sns.it>,
        Dieter N?tzel <Dieter.Nuetzel@hamburg.de>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        Rik van Riel <riel@conectiva.com.br>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@zip.com.au>
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
Message-ID: <20020109152221.I1543@inspiron.school.suse.de>
In-Reply-To: <20020108030420Z287595-13997+1799@vger.kernel.org> <E16OHLf-0000Dn-00@starship.berlin> <20020109145509.G1543@inspiron.school.suse.de> <E16OJOJ-0000Q6-00@starship.berlin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <E16OJOJ-0000Q6-00@starship.berlin>; from phillips@bonn-fries.net on Wed, Jan 09, 2002 at 03:07:40PM +0100
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 09, 2002 at 03:07:40PM +0100, Daniel Phillips wrote:
> On January 9, 2002 02:55 pm, Andrea Arcangeli wrote:
> > On Wed, Jan 09, 2002 at 12:56:50PM +0100, Daniel Phillips wrote:
> > > BTW, I find your main argument confusing.  First you don't want -preempt with
> > > CONFIG_EXERIMENTAL because it might not get wide enough testing, so you want 
> > > to enable it by default in the mainline kernel, then you argue it's too risky 
> > > because everybody will use it and it might break some obscure driver.  Sorry, 
> > > you lost me back there.
> > 
> > the point I am making is very simple: _if_ we include it, it should _not_
> > be a config option.
> 
> That doesn't make any sense to me.  Why should _SMP be a config option and not

getting the drivers tested with preempt enable makes lots of sense to
me.

> _PREEMPT?

SMP in 2.1 wasn't a config option.

Andrea
