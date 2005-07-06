Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261848AbVGGAX2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261848AbVGGAX2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Jul 2005 20:23:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262393AbVGFUEz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Jul 2005 16:04:55 -0400
Received: from smtp.osdl.org ([65.172.181.4]:29830 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262151AbVGFSCA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Jul 2005 14:02:00 -0400
Date: Wed, 6 Jul 2005 11:01:20 -0700
From: Chris Wright <chrisw@osdl.org>
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: James Morris <jmorris@redhat.com>, Greg KH <greg@kroah.com>,
       Tony Jones <tonyj@suse.de>, serge@hallyn.com, serue@us.ibm.com,
       lkml <linux-kernel@vger.kernel.org>, Chris Wright <chrisw@osdl.org>,
       Andrew Morton <akpm@osdl.org>, Michael Halcrow <mhalcrow@us.ibm.com>,
       David Safford <safford@watson.ibm.com>,
       Reiner Sailer <sailer@us.ibm.com>, Gerrit Huizenga <gh@us.ibm.com>
Subject: Re: [PATCH] securityfs
Message-ID: <20050706180120.GC9046@shell0.pdx.osdl.net>
References: <Xine.LNX.4.44.0507061125530.7680-100000@thoron.boston.redhat.com> <1120666000.21423.35.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1120666000.21423.35.camel@moss-spartans.epoch.ncsc.mil>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Stephen Smalley (sds@epoch.ncsc.mil) wrote:
> It still has to be mounted by userspace, right?  So /sbin/init still
> needs to know to mount securityfs, and where the selinux nodes live
> under it, so you are still talking about changing it (and libselinux and
> rc.sysinit), and risking compatibility breakage for existing systems
> when they update their kernels.

initrd, and proper dependency during kernel upgrade?
