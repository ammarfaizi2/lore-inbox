Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264307AbUGaVYt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264307AbUGaVYt (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Jul 2004 17:24:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264298AbUGaVYt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Jul 2004 17:24:49 -0400
Received: from pfepc.post.tele.dk ([195.41.46.237]:22938 "EHLO
	pfepc.post.tele.dk") by vger.kernel.org with ESMTP id S264286AbUGaVYr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Jul 2004 17:24:47 -0400
Date: Sat, 31 Jul 2004 23:25:47 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: William Lee Irwin III <wli@holomorphy.com>,
       Sam Ravnborg <sam@ravnborg.org>, Linus Torvalds <torvalds@osdl.org>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: kbuild: Various updates for 2.6.8
Message-ID: <20040731212547.GA1364@mars.ravnborg.org>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Sam Ravnborg <sam@ravnborg.org>, Linus Torvalds <torvalds@osdl.org>,
	linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
References: <20040731075838.GA7469@mars.ravnborg.org> <20040731211739.GE2334@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040731211739.GE2334@holomorphy.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 31, 2004 at 02:17:39PM -0700, William Lee Irwin III wrote:
> On Sat, Jul 31, 2004 at 09:58:38AM +0200, Sam Ravnborg wrote:
> > I have arranged with Andrew that he sucks my kbuild tree in -mm,
> > and this is the fist update I send direct to you.
> > The following set of patches has been in -mm for a few days now
> > with no complaints. Please include these before 2.6.8.
> > 	bk pull bk://linux-sam.bkbits.net/kbuild
> > The most important fix is the $LANG fix. Without this users
> > from .cz, .fr etc. cannot use menuconfig/xconfig with good result.
> 
> By any chance could you update make rpm so it respects the -j flags?
> Single-threaded make rpm is horrifically slow.
I have below patch queue up already but will try to experiment with a better fix.
Something where we pass all options to make.

I have to redo some of the package stuff anyway cause today there needs
to be too much arch dependent knowledge spread out in several files.
But for now klibc is on top of the list, the package stuff will wait a bit.

	Sam
