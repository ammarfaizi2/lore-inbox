Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261410AbVGCTNg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261410AbVGCTNg (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Jul 2005 15:13:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261492AbVGCTNg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Jul 2005 15:13:36 -0400
Received: from cerebus.immunix.com ([198.145.28.33]:53467 "EHLO
	ermintrude.int.immunix.com") by vger.kernel.org with ESMTP
	id S261410AbVGCTNe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Jul 2005 15:13:34 -0400
Date: Sun, 3 Jul 2005 12:09:14 -0700
From: Tony Jones <tonyj@suse.de>
To: James Morris <jmorris@redhat.com>
Cc: Tony Jones <tonyj@suse.de>, serge@hallyn.com, Greg KH <greg@kroah.com>,
       serue@us.ibm.com, lkml <linux-kernel@vger.kernel.org>,
       Chris Wright <chrisw@osdl.org>, Stephen Smalley <sds@epoch.ncsc.mil>,
       Andrew Morton <akpm@osdl.org>, Michael Halcrow <mhalcrow@us.ibm.com>,
       David Safford <safford@watson.ibm.com>,
       Reiner Sailer <sailer@us.ibm.com>, Gerrit Huizenga <gh@us.ibm.com>
Subject: Re: [patch 5/12] lsm stacking v0.2: actual stacker module
Message-ID: <20050703190914.GB30292@immunix.com>
References: <20050703182505.GA29491@immunix.com> <Xine.LNX.4.44.0507031450540.30297-100000@thoron.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Xine.LNX.4.44.0507031450540.30297-100000@thoron.boston.redhat.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 03, 2005 at 02:53:17PM -0400, James Morris wrote:

> It might be worth thinking about a more general securityfs as part of LSM,
> to be used by stacker and LSM modules.  SELinux could use this instead of
> managing its own selinuxfs.

Good idea.   In the case of stacked modules each with a custom fs, having them
be part of a common hierarchy makes a lot of sense.

I'm assuming you are advocating for adding LSM support to provide some level 
of consistency in presentation rather than it _just_ being a new mount point
for every module to live under?

Take the discussion to the LSM list?

Thanks!

Tony
