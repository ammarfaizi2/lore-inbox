Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261286AbVGDPxn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261286AbVGDPxn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Jul 2005 11:53:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261285AbVGDPxn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Jul 2005 11:53:43 -0400
Received: from dsl017-059-136.wdc2.dsl.speakeasy.net ([69.17.59.136]:50346
	"EHLO luther.kurtwerks.com") by vger.kernel.org with ESMTP
	id S261286AbVGDPqh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Jul 2005 11:46:37 -0400
Date: Mon, 4 Jul 2005 11:46:52 -0400
From: Kurt Wall <kwall@kurtwerks.com>
To: linux-kernel@vger.kernel.org
Cc: kbuild-devel@lists.sourceforge.net, zippel@linux-m68k.org
Subject: Re: [PATCH]Fix menuconfig error message
Message-ID: <20050704154652.GA2082@kurtwerks.com>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	kbuild-devel@lists.sourceforge.net, zippel@linux-m68k.org
References: <20050704135700.GB32056@kurtwerks.com> <20050704151632.GF16867@khan.acc.umu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050704151632.GF16867@khan.acc.umu.se>
User-Agent: Mutt/1.4.2.1i
X-Operating-System: Linux 2.6.12
X-Woot: Woot!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 04, 2005 at 05:16:32PM +0200, David Weinehall wrote:
> On Mon, Jul 04, 2005 at 09:57:00AM -0400, Kurt Wall wrote:
> > If you try to run `make menuconfig' on a system that lacks ncurses
> > development libs, you get an error message telling you to install
> > ncurses-devel. Some popular distributions don't have an ncurses-devel
> > package. This patch generalizes the error message. Patch is against
> > 2.6.12.

[...]

> > +		echo ">> to use 'make menuconfig'. If you have an RPM-based" ;\
> > +		echo ">> Debian-based distribution you should install the" ;\ 
> > +		echo ">> ncurses-devel package." ;\
> >  		echo ;\
> >  		exit 1 ;\
> >  	fi
> 
> You know, I'd say that *very* few (approximately zero)
> Debian-based distributions are RPM-based =)  The Debian package is
> called libncurses5-dev, btw.

Silly typo. I'll post a new patch with the Debian package name.
Thanks.

Kurt
-- 
Bradley's Bromide:
	If computers get too powerful, we can organize them into a
committee -- that will do them in.
