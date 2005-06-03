Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261208AbVFCKZG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261208AbVFCKZG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Jun 2005 06:25:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261211AbVFCKZG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Jun 2005 06:25:06 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:12759 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S261208AbVFCKZC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Jun 2005 06:25:02 -0400
Date: Fri, 3 Jun 2005 12:25:01 +0200
From: Jan Kara <jack@suse.cz>
To: Andrew Morton <akpm@osdl.org>
Cc: sct@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Split the checkpoint lists
Message-ID: <20050603102501.GB1387@atrey.karlin.mff.cuni.cz>
References: <20050601080357.GF5933@atrey.karlin.mff.cuni.cz> <20050603015717.7512ea3a.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050603015717.7512ea3a.akpm@osdl.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Jan Kara <jack@ucw.cz> wrote:
> >
> > 
> >    attached patch (to be applied after my previous two bugfixes) is a new
> >  version of my patch splitting the JBD checkpoint lists into two
> 
> Seems to have a use-after-free bug.  Did you test it with CONFIG_SLAB_DEBUG?
  I'm not sure now (and as I'm in the process of moving from Berlin back
to Prague I'll be able to find out only on Monday because my laptop is
already packed). Thanks for spotting it I'll try to debug it on Monday.

									Honza

-- 
Jan Kara <jack@suse.cz>
SuSE CR Labs
