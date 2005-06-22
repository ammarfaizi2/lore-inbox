Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262501AbVFVXCG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262501AbVFVXCG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 19:02:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262560AbVFVW4u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 18:56:50 -0400
Received: from mx1.redhat.com ([66.187.233.31]:46024 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262557AbVFVWxB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 18:53:01 -0400
Date: Wed, 22 Jun 2005 18:52:55 -0400
From: Dave Jones <davej@redhat.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       Git Mailing List <git@vger.kernel.org>
Subject: Re: Updated git HOWTO for kernel hackers
Message-ID: <20050622225255.GB21298@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Jeff Garzik <jgarzik@pobox.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	Git Mailing List <git@vger.kernel.org>
References: <42B9E536.60704@pobox.com> <20050622224003.GA21298@redhat.com> <42B9EA67.1040407@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42B9EA67.1040407@pobox.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 22, 2005 at 06:47:03PM -0400, Jeff Garzik wrote:

 > > > install tarball:  unpack && make && sudo make prefix=/usr/local install
 > >
 > >the sudo thing isn't necessary. make install by itself installs it
 > >in ~/bin/ just fine.
 > 
 > Clearly this does not work if installing in /usr/local, as I and others 
 > do (and as the example shows).

Sure, it just seemed to imply that it doesn't work with a non-root install,
which isn't true.

 > > > After reading the rest of this document, come back and update your copy 
 > > > of git to the latest:
 > > > rsync://rsync.kernel.org/pub/scm/linux/kernel/git/torvalds/git.git
 > >
 > >See above, which allows you to skip this step ;)
 > 
 > huh?  Nothing allows you to skip that step.  Regardless of when you suck 
 > the tarball, even from your snapshots, the users should not skip this step.

At worse, users will have tools 59 minutes old.  If a situation arises
where git from an hour ago isn't new enough to pull from the repository,
we have bigger problems.

You seem to be proposing that everyone needs the shiniest newest things,
which clearly isn't true, and suggesting so just complicates things
further imo.

		Dave

