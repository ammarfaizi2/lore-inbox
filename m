Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932686AbWFMAdI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932686AbWFMAdI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jun 2006 20:33:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932688AbWFMAdI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jun 2006 20:33:08 -0400
Received: from cantor.suse.de ([195.135.220.2]:37838 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932686AbWFMAdG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jun 2006 20:33:06 -0400
Date: Mon, 12 Jun 2006 17:30:33 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org
Cc: vgoyal@in.ibm.com
Subject: Reworked 64bit resource patches
Message-ID: <20060613003033.GA10717@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the -mm tree (and my pci quilt tree) has a series of patches
that enable 64bit resource sizes.  It was originally done by Vivek
Goyal, and that work was based on something done by someone else before
that (sorry, can't remember that far back anymore...)

Anyway, here's a rework of that series of patches.  It drops the number
of patches from 24 to 16, and enables the tree to build at any step
along the way.  It also doesn't change the same lines twice (as the old
series did).

The end result is _identical_ to Vivek's patches, but will now play
nicer when ending up in the main kernel git tree.

If anyone has any comments on these, please let me know.

thanks,

greg k-h
