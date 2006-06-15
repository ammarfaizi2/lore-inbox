Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750854AbWFOGta@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750854AbWFOGta (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jun 2006 02:49:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750786AbWFOGta
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jun 2006 02:49:30 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:25625 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1750728AbWFOGt3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jun 2006 02:49:29 -0400
Date: Thu, 15 Jun 2006 08:50:06 +0200
From: Jens Axboe <axboe@suse.de>
To: Nathan Scott <nathans@sgi.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: cfq_update_io_seektime oops
Message-ID: <20060615065006.GM1522@suse.de>
References: <20060615152131.A898607@wobbly.melbourne.sgi.com> <20060615060152.GK1522@suse.de> <20060615162107.B898607@wobbly.melbourne.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060615162107.B898607@wobbly.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 15 2006, Nathan Scott wrote:
> On Thu, Jun 15, 2006 at 08:01:53AM +0200, Jens Axboe wrote:
> > The patch for this was just merged in 2.6.17-rc6-git last night, so it
> 
> Ah, great - thanks.
> 
> > should be fine now. Just curious - did you have any slab debugging
> > features enabled?
> 
> Hmm, lemme see - no, not slab for this particular build - here's
> my CONFIG_DEBUG_* list:

Ok, thanks for checking. Just wondering what the likelyhood of
->seek_samples being -36 initially, which will cause this crash. You're
now the 2nd person to have hit this bug.

-- 
Jens Axboe

