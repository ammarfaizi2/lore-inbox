Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261201AbVFYR3S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261201AbVFYR3S (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Jun 2005 13:29:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261204AbVFYR3S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Jun 2005 13:29:18 -0400
Received: from mx1.redhat.com ([66.187.233.31]:31913 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261169AbVFYR3K (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Jun 2005 13:29:10 -0400
Date: Sat, 25 Jun 2005 13:29:02 -0400
From: Dave Jones <davej@redhat.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       Git Mailing List <git@vger.kernel.org>
Subject: Re: Updated git HOWTO for kernel hackers
Message-ID: <20050625172902.GA2852@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Jeff Garzik <jgarzik@pobox.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	Git Mailing List <git@vger.kernel.org>
References: <42B9E536.60704@pobox.com> <20050622224003.GA21298@redhat.com> <42BCD092.6050201@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42BCD092.6050201@pobox.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 24, 2005 at 11:33:38PM -0400, Jeff Garzik wrote:
 > Dave Jones wrote:
 > >On Wed, Jun 22, 2005 at 06:24:54PM -0400, Jeff Garzik wrote:
 > > > 
 > > > Things in git-land are moving at lightning speed, and usability has 
 > > > improved a lot since my post a month ago:  
 > > http://lkml.org/lkml/2005/5/26/11
 > > > 
 > > > 
 > > > 
 > > > 1) installing git
 > > > 
 > > > git requires bootstrapping, since you must have git installed in order 
 > > > to check out git.git (git repo), and linux-2.6.git (kernel repo).  I 
 > > > have put together a bootstrap tarball of today's git repository.
 > > > 
 > > > Download tarball from:
 > > > 
 > > http://www.kernel.org/pub/linux/kernel/people/jgarzik/git-20050622.tar.bz2
 > >
 > ><blatant self-promotion>
 > >daily snapshots (refreshed once an hour) are available at:
 > >http://www.codemonkey.org.uk/projects/git-snapshots/git/
 > ></blatant self-promotion>
 > 
 > I was about to link to this, but a problem arose:  your snapshots don't 
 > include the .git/objects directory.

This is intentional.  Why is this a problem ?
In the same way, the bitkeeper snapshots I used to do never included
Bitkeeper/, and CVS snapshots don't include the CVS/ dirs.

 > Also, a git-latest.tar.gz symlink would be nice.

That's doable.

		Dave

