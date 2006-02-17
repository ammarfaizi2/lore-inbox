Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750702AbWBQLUx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750702AbWBQLUx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Feb 2006 06:20:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751088AbWBQLUx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Feb 2006 06:20:53 -0500
Received: from verein.lst.de ([213.95.11.210]:42474 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S1750702AbWBQLUw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Feb 2006 06:20:52 -0500
Date: Fri, 17 Feb 2006 12:20:32 +0100
From: Christoph Hellwig <hch@lst.de>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Christoph Hellwig <hch@lst.de>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] deprecate the tasklist_lock export
Message-ID: <20060217112032.GD28448@lst.de>
References: <20060215130734.GA5590@lst.de> <Pine.LNX.4.58.0602150903020.25659@gandalf.stny.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0602150903020.25659@gandalf.stny.rr.com>
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 15, 2006 at 09:09:36AM -0500, Steven Rostedt wrote:
> Hmm, I have some debug modules that do use that lock.  Is it possible to
> export it only if CONFIG_DEBUG_KERNEL?

That doesn't make a whole lot of sense.  What's your debug module doing?
Should we just put it in the tree as builtin-code under a debug option?

