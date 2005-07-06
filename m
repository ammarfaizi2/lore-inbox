Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262245AbVGGC2x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262245AbVGGC2x (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Jul 2005 22:28:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262335AbVGFT6p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Jul 2005 15:58:45 -0400
Received: from mail.kroah.org ([69.55.234.183]:17854 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262284AbVGFQQ4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Jul 2005 12:16:56 -0400
Date: Wed, 6 Jul 2005 09:16:13 -0700
From: Greg KH <greg@kroah.com>
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: James Morris <jmorris@redhat.com>, Tony Jones <tonyj@suse.de>,
       serge@hallyn.com, serue@us.ibm.com, lkml <linux-kernel@vger.kernel.org>,
       Chris Wright <chrisw@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Michael Halcrow <mhalcrow@us.ibm.com>,
       David Safford <safford@watson.ibm.com>,
       Reiner Sailer <sailer@us.ibm.com>, Gerrit Huizenga <gh@us.ibm.com>
Subject: Re: [PATCH] securityfs
Message-ID: <20050706161613.GA13551@kroah.com>
References: <Xine.LNX.4.44.0507061125530.7680-100000@thoron.boston.redhat.com> <1120666000.21423.35.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1120666000.21423.35.camel@moss-spartans.epoch.ncsc.mil>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 06, 2005 at 12:06:40PM -0400, Stephen Smalley wrote:
> > I think it should reduce and simplify the SELinux kernel code, with less
> > filesystems in the kernel, consolidating several potential projects into
> > the same security filesystem.
> 
> If there are several such projects in the first place...

Serge has already posted a patch converting the sysfs usage over to it,
and I know the subdomain people are going to also use this code, for
when they submit their patches to mainline (they are currently working
on it, honestly, I've seen them doing it...)

thanks,

greg k-h
