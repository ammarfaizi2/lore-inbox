Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267464AbTGMPgz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Jul 2003 11:36:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269900AbTGMPgz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Jul 2003 11:36:55 -0400
Received: from h68-147-142-75.cg.shawcable.net ([68.147.142.75]:45294 "EHLO
	schatzie.adilger.int") by vger.kernel.org with ESMTP
	id S267464AbTGMPgx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Jul 2003 11:36:53 -0400
Date: Sun, 13 Jul 2003 08:51:18 -0700
From: Andreas Dilger <adilger@clusterfs.com>
To: Jamie Lokier <jamie@shareable.org>
Cc: Jeff Garzik <jgarzik@pobox.com>, Andrew Morton <akpm@osdl.org>,
       davej@codemonkey.org.uk, linux-kernel@vger.kernel.org
Subject: Re: 2.5 'what to expect'
Message-ID: <20030713085118.V4482@schatzie.adilger.int>
Mail-Followup-To: Jamie Lokier <jamie@shareable.org>,
	Jeff Garzik <jgarzik@pobox.com>, Andrew Morton <akpm@osdl.org>,
	davej@codemonkey.org.uk, linux-kernel@vger.kernel.org
References: <20030711140219.GB16433@suse.de> <20030712152406.GA9521@mail.jlokier.co.uk> <3F103018.6020008@pobox.com> <20030712112722.55f80b60.akpm@osdl.org> <20030712183929.GA10450@mail.jlokier.co.uk> <3F105B9A.7070803@pobox.com> <20030712193401.GD10450@mail.jlokier.co.uk> <3F1063AD.40206@pobox.com> <20030712194624.GF10450@mail.jlokier.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030712194624.GF10450@mail.jlokier.co.uk>; from jamie@shareable.org on Sat, Jul 12, 2003 at 08:46:24PM +0100
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jul 12, 2003  20:46 +0100, Jamie Lokier wrote:
> Jeff Garzik wrote:
> > Jamie Lokier wrote:
> > >2.4 fails on write()?  A strace of "rpm --rebuilddb" shows it is
> > >opening with O_DIRECT and writing just fine.  Or does that only work
> > >with RedHat's 2.4 kernels?
> > 
> > Are you testing on a filesystem where an O_DIRECT is not supported?
> > The "it works" case is not an issue.
> 
> ext3.

ext3 in 2.4 kernels does not support O_DIRECT.  To confuse matters,
recent RH kernels silently ignore O_DIRECT if you are not root, so
you may think O_DIRECT is being used, but it isn't.

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

