Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932285AbWEAVy1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932285AbWEAVy1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 May 2006 17:54:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932284AbWEAVy1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 May 2006 17:54:27 -0400
Received: from ns1.suse.de ([195.135.220.2]:61094 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932282AbWEAVy0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 May 2006 17:54:26 -0400
Date: Mon, 1 May 2006 14:52:50 -0700
From: Greg KH <greg@kroah.com>
To: NeilBrown <neilb@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-raid@vger.kernel.org,
       linux-kernel@vger.kernel.org, stable@kernel.org
Subject: Re: [stable] [PATCH 001 of 5] md: Avoid oops when attempting to fix read errors on raid10
Message-ID: <20060501215250.GA11226@kroah.com>
References: <20060428124313.29510.patches@notabene> <1060428025015.30731@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1060428025015.30731@suse.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 28, 2006 at 12:50:15PM +1000, NeilBrown wrote:
> 
> We should add to the counter for the rdev *after* checking
> if the rdev is NULL !!!
> 
> Signed-off-by: Neil Brown <neilb@suse.de>

Queued to -stable, thanks.

greg k-h
