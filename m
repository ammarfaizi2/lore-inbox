Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261592AbVFBHWo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261592AbVFBHWo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Jun 2005 03:22:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261593AbVFBHWo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Jun 2005 03:22:44 -0400
Received: from mail.kroah.org ([69.55.234.183]:29372 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261592AbVFBHWn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Jun 2005 03:22:43 -0400
Date: Thu, 2 Jun 2005 00:33:03 -0700
From: Greg KH <greg@kroah.com>
To: Phillip Hellewell <phillip@hellewell.homeip.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] eCryptfs: eCryptfs kernel module
Message-ID: <20050602073303.GA9373@kroah.com>
References: <20050602054740.GA4514@sshock.rn.byu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050602054740.GA4514@sshock.rn.byu.edu>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 01, 2005 at 11:47:40PM -0600, Phillip Hellewell wrote:
> 
> While eCryptfs is functional, there is a significant amount of work
> yet to be done; a perusal of the source will reveal that there is a
> lot of low-hanging fruit/trivial fixes (David Howells: we promise that
> using your keyring correctly is near the top of the list, right after
> we get these memory leaks resolved).  It derives from cryptfs, which
> is a cryptographic filesystem instantiated by Erez Zadok's stackable
> filesystem framework, FiST.  We are aware that there are some extant
> bugs in the version of cryptfs that we built off of; as those are made
> known, we will be applying fixes.  In the meantime, we would like the
> eCryptfs kernel module to be merged into the mainline kernel.

Why not fix up the stuff that you know needs to be fixed?  It should not
be merged until then at the least.

Good luck,

greg k-h
