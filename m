Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261804AbTH3N7f (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Aug 2003 09:59:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261825AbTH3N7f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Aug 2003 09:59:35 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:140 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261804AbTH3N7e
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Aug 2003 09:59:34 -0400
Date: Sat, 30 Aug 2003 14:59:33 +0100
From: Matthew Wilcox <willy@debian.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Matthew Wilcox <willy@debian.org>,
       Ruediger Scholz <rscholz@hrzpub.tu-darmstadt.de>,
       parisc-linux@lists.parisc-linux.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [parisc-linux] Security Hole in binfmt_som.c ?
Message-ID: <20030830135933.GJ13467@parcelfarce.linux.theplanet.co.uk>
References: <3F509BBD.2040007@hrzpub.tu-darmstadt.de> <20030830131541.GI13467@parcelfarce.linux.theplanet.co.uk> <1062251389.31150.4.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1062251389.31150.4.camel@dhcp23.swansea.linux.org.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 30, 2003 at 02:49:50PM +0100, Alan Cox wrote:
> On Sad, 2003-08-30 at 14:15, Matthew Wilcox wrote:
> > On Sat, Aug 30, 2003 at 02:42:37PM +0200, Ruediger Scholz wrote:
> > > binfmt_som.c:216:2: #error "Fix security hole before enabling me"
> > > What's this message about?
> > 
> > I don't know.  I wish someone would tell me.  You'd think they'd have the
> > decency to contact the person listed as the author at the top of the file.
> 
> Actually explanations were posted in the previous discussion on this on
> parisc-list.

Um, I can't find it, and neither can Google:
http://www.google.com/search?q=binfmt_som+security&as_q=%5Bparisc-linux&btnG=Google+Search&as_sitesearch=lists.parisc-linux.org

> Someone has to do the equivalent of the 2.4.22 binfmt_elf changes if
> neccessary so that another thread can't change the file handles or 
> steal the exec fd being passed to the loader.

Hm, ok, I'll take a look later this weekend if no-one gets to it first.

-- 
"It's not Hollywood.  War is real, war is primarily not about defeat or
victory, it is about death.  I've seen thousands and thousands of dead bodies.
Do you think I want to have an academic debate on this subject?" -- Robert Fisk
