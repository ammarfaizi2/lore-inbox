Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263630AbTJWPpZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Oct 2003 11:45:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263593AbTJWPpY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Oct 2003 11:45:24 -0400
Received: from blacksheep.csh.rit.edu ([129.21.60.6]:27662 "EHLO
	blacksheep.csh.rit.edu") by vger.kernel.org with ESMTP
	id S263630AbTJWPpU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Oct 2003 11:45:20 -0400
Date: Thu, 23 Oct 2003 11:45:16 -0400
From: Matt Zimmerman <mdz@debian.org>
To: viro@parcelfarce.linux.theplanet.co.uk
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       linux-kernel@vger.kernel.org, 171947@bugs.debian.org,
       asd@suespammers.org, Bruno Rodrigues <bruno.rodrigues@litux.org>
Subject: Re: Linux 2.4.23-pre8
Message-ID: <20031023154516.GH1538@dijkstra.csh.rit.edu>
Mail-Followup-To: Matt Zimmerman <mdz@debian.org>,
	viro@parcelfarce.linux.theplanet.co.uk,
	Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
	linux-kernel@vger.kernel.org, 171947@bugs.debian.org,
	asd@suespammers.org, Bruno Rodrigues <bruno.rodrigues@litux.org>
References: <Pine.LNX.4.44.0310222116270.1364-100000@logos.cnet> <20031023015301.GN7665@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031023015301.GN7665@parcelfarce.linux.theplanet.co.uk>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 23, 2003 at 02:53:01AM +0100, viro@parcelfarce.linux.theplanet.co.uk wrote:

> On Wed, Oct 22, 2003 at 09:24:17PM -0200, Marcelo Tosatti wrote:
> > Here goes -pre8... It contains a quite big amount of ACPI fixes,
> > networking changes, network driver changes, few IDE fixes, SPARC merge, SH
> > merge, tmpfs fixes, NFS fixes, important VM typo fix, amongst others.
> > 
> > People seeing boot IDE related crashes on Alpha with previous kernels
> > please try this.
> 
> 	BTW, another thing that might be worth rechecking is the pile of bugs
> related to ownership of ksymoops files.  In particular, bugs.debian.org/171947
> might have been caused by the bug fixed in 2.4.23-pre8 (UID/GID leaking into
> modprobe).  Matt, do you still see that crap appearing in /var/log/ksymoops
> with that kernel?

Unfortunately, I don't have a means to test right now.  A few other folks
were seeing that bug as well, though, so I'm copying them and the Debian bug
so that someone else can verify.

-- 
 - mdz (dialup and an ancient laptop for now)
