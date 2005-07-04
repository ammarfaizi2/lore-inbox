Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261688AbVGDMpq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261688AbVGDMpq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Jul 2005 08:45:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261668AbVGDMoN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Jul 2005 08:44:13 -0400
Received: from ms-smtp-01.texas.rr.com ([24.93.47.40]:45748 "EHLO
	ms-smtp-01-eri0.texas.rr.com") by vger.kernel.org with ESMTP
	id S261680AbVGDMj3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Jul 2005 08:39:29 -0400
Date: Mon, 4 Jul 2005 07:39:14 -0500
From: serge@hallyn.com
To: Greg KH <greg@kroah.com>
Cc: James Morris <jmorris@redhat.com>, Tony Jones <tonyj@suse.de>,
       serue@us.ibm.com, lkml <linux-kernel@vger.kernel.org>,
       Chris Wright <chrisw@osdl.org>, Stephen Smalley <sds@epoch.ncsc.mil>,
       Andrew Morton <akpm@osdl.org>, Michael Halcrow <mhalcrow@us.ibm.com>,
       David Safford <safford@watson.ibm.com>,
       Reiner Sailer <sailer@us.ibm.com>, Gerrit Huizenga <gh@us.ibm.com>
Subject: Re: [PATCH] securityfs
Message-ID: <20050704123914.GB28322@vino.hallyn.com>
References: <20050703182505.GA29491@immunix.com> <Xine.LNX.4.44.0507031450540.30297-100000@thoron.boston.redhat.com> <20050703204423.GA17418@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050703204423.GA17418@kroah.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Greg KH (greg@kroah.com):
> On Sun, Jul 03, 2005 at 02:53:17PM -0400, James Morris wrote:
> > On Sun, 3 Jul 2005, Tony Jones wrote:
> > 
> > > There just isn't enough content to justify a stacker specific filesystem IMHO.
> > 
> > It might be worth thinking about a more general securityfs as part of LSM,
> > to be used by stacker and LSM modules.  SELinux could use this instead of
> > managing its own selinuxfs.
> 
> Good idea.  Here's a patch to do just that (compile tested only...)

Having all the security relevant stuff under one place has been
something we've wanted to do for awhile :)  Thanks, Greg!

All my good machines are down right now, so compiling is slow, but I'm
attempting to convert seclvl to use securityfs.  So far the resulting
code is quite nice.  I'll hopefully send something out tomorrow.

thanks,
-serge
