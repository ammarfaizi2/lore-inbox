Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261700AbVDKGl0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261700AbVDKGl0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Apr 2005 02:41:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261706AbVDKGl0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Apr 2005 02:41:26 -0400
Received: from mail.autoweb.net ([198.172.237.26]:53659 "EHLO mail")
	by vger.kernel.org with ESMTP id S261700AbVDKGlT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Apr 2005 02:41:19 -0400
Date: Mon, 11 Apr 2005 02:40:08 -0400
From: Ryan Anderson <ryan@michonline.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Jeff Garzik <jgarzik@pobox.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       James Bottomley <James.Bottomley@SteelEye.com>,
       David Woodhouse <dwmw2@infradead.org>
Subject: Re: New SCM and commit list
Message-ID: <20050411064008.GD5434@mythryan2.michonline.com>
References: <1113174621.9517.509.camel@gaston> <Pine.LNX.4.58.0504101621200.1267@ppc970.osdl.org> <425A10EA.7030607@pobox.com> <Pine.LNX.4.58.0504102304050.1267@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0504102304050.1267@ppc970.osdl.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 10, 2005 at 11:15:20PM -0700, Linus Torvalds wrote:
> On Mon, 11 Apr 2005, Jeff Garzik wrote:
> > > But I hope that I can get non-conflicting merges done fairly soon, and 
> > > maybe I can con James or Jeff or somebody to try out GIT then...
> > 
> > I don't mind being a guinea pig as long as someone else does the hard 
> > work of finding a new way to merge :)
> 
> So I can tell you what merges are going to be like, just to prepare you.
> 
> First, the good news: I think we can make the workflow look like bk, ie
> pretty much like "git pull" and "git push".  And for well-behaved stuff
> (ie minimal changes to the same files on both sides) it will even be fast.  
> I think.

If you can stick something meaningful in a simple text file, overwritten
after each merge completes, similar to the BitKeeper/csets-in file, it
should be trivial to write a wrapper for the basic merge tool that calls
a trigger after each merge and uses csets-in to generate diffs and email
them out.

-- 

Ryan Anderson
  sometimes Pug Majere
