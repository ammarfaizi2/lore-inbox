Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268119AbUJCUM5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268119AbUJCUM5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Oct 2004 16:12:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268120AbUJCUM5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Oct 2004 16:12:57 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:5776 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S268119AbUJCUMx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Oct 2004 16:12:53 -0400
Date: Sun, 3 Oct 2004 21:48:31 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Jeff Moyer <jmoyer@redhat.com>
Cc: linux-kernel@vger.kernel.org, mingo@redhat.com, sct@redhat.com
Subject: Re: [patch rfc] towards supporting O_NONBLOCK on regular files
Message-ID: <20041003194831.GB3089@openzaurus.ucw.cz>
References: <16733.50382.569265.183099@segfault.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16733.50382.569265.183099@segfault.boston.redhat.com>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> This patch makes an attempt at supporting the O_NONBLOCK flag for regular
> files.  It's pretty straight-forward.  One limitation is that we still call
> into the readahead code, which I believe can block.  However, if we don't
> do this, then an application which only uses non-blocking reads may never
> get it's data.

This looks very nice. Does it mean that aio and friends are instantly obsolete?

Does it have comparable performance to aio?
				Pavel


-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

