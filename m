Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932463AbVIEUN3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932463AbVIEUN3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Sep 2005 16:13:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932467AbVIEUN3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Sep 2005 16:13:29 -0400
Received: from pfepb.post.tele.dk ([195.41.46.236]:8296 "EHLO
	pfepb.post.tele.dk") by vger.kernel.org with ESMTP id S932463AbVIEUN2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Sep 2005 16:13:28 -0400
Date: Mon, 5 Sep 2005 22:13:45 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Alistair John Strachan <s0348365@sms.ed.ac.uk>
Cc: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [GIT PATCHES] kbuild updates
Message-ID: <20050905201345.GA26106@mars.ravnborg.org>
References: <20050905174150.GA17923@mars.ravnborg.org> <200509052035.14156.s0348365@sms.ed.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200509052035.14156.s0348365@sms.ed.ac.uk>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 05, 2005 at 08:35:14PM +0100, Alistair John Strachan wrote:
> On Monday 05 September 2005 18:41, Sam Ravnborg wrote:
> > Hi Linus.
> >
> > kbuild updates as accumulated over the last few months.
> > All patches has been in -mm in one or several versions.
> >
> > Most noteworthy:
> > 1) -Wundef added to CFLAGS. This is the cause of several new warnings,
> >    which for the most part has been fixed for now.
> > 2) "PREEMPT" in UTS_VERSION. So we complain when dealing
> >    with modules compiled for a wrong kernel
> 
> How is this different from the preempt module vermagic?
> 
> ~$ modinfo agpgart | grep vermagic
> vermagic:       2.6.13 preempt gcc-4.0

My bad. Adding PREEMT to UTS_VERSION makes it visible in uname -a.

	Sam
