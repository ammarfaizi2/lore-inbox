Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751310AbWDUUae@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751310AbWDUUae (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Apr 2006 16:30:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751354AbWDUUad
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Apr 2006 16:30:33 -0400
Received: from cantor.suse.de ([195.135.220.2]:6340 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751310AbWDUUac (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Apr 2006 16:30:32 -0400
Date: Fri, 21 Apr 2006 13:29:18 -0700
From: Greg KH <gregkh@suse.de>
To: Adrian Bunk <bunk@stusta.de>
Cc: chrisw@sous-sol.org, linux-security-module@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] remove the Root Plug Support sample module
Message-ID: <20060421202918.GB32119@suse.de>
References: <20060421201943.GJ19754@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060421201943.GJ19754@stusta.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 21, 2006 at 10:19:43PM +0200, Adrian Bunk wrote:
> No matter whether LSM will stay or not, there's no reason to include a 
> sample module in the build (e.g. Debian kernels are currently shipping 
> this module).
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>

As much as I'd like to agree with this (SuSE also ships this module for
some odd reason), I do have reports of people using it for their
machines at times.

So, I'd like to keep this in the tree, for as long as the LSM interface
sticks around, if possible.  It's not hurting anything, and it does work
for users, and is a good example starting point for people wanting to
use the LSM interface.

Unless there are any known security problems with it?  If so, please let
me know.

thanks,

greg k-h
