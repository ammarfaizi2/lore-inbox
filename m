Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261525AbVFCUGN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261525AbVFCUGN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Jun 2005 16:06:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261528AbVFCUGN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Jun 2005 16:06:13 -0400
Received: from ylpvm01-ext.prodigy.net ([207.115.57.32]:32954 "EHLO
	ylpvm01.prodigy.net") by vger.kernel.org with ESMTP id S261525AbVFCUFr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Jun 2005 16:05:47 -0400
Date: Fri, 3 Jun 2005 15:03:39 -0500
From: Michael Halcrow <mhalcrow@us.ibm.com>
To: Phillip Hellewell <phillip@hellewell.homeip.net>
Cc: linux-kernel@vger.kernel.org, David Howells <dhowells@redhat.com>
Subject: Re: [PATCH 2/3] eCryptfs: export key type
Message-ID: <20050603200339.GA2445@halcrow.us>
Reply-To: Michael Halcrow <mhalcrow@us.ibm.com>
References: <20050602054852.GB4514@sshock.rn.byu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050602054852.GB4514@sshock.rn.byu.edu>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 01, 2005 at 11:48:52PM -0600, Phillip Hellewell wrote:
> This is the second in a series of three patches for the eCryptfs
> kernel module.
> 
> The key_type_user symbol in user_defined.c needs to be exported.
> ...
> +EXPORT_SYMBOL( key_type_user );

This is the only modification necessary to support eCryptfs. While we
are working on getting it ready for merging into the mainline kernel,
we would like to distribute it as a separate kernel module, and we
would like for users or distro's do not need to modify their kernels
to build and run it.

Would there be any objections to exporting the key_type_user symbol?
Is there any general reason why kernel modules should not have access
to the user key type struct?

Mike
