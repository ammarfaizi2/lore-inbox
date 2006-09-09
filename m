Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932104AbWIIDQO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932104AbWIIDQO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Sep 2006 23:16:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932105AbWIIDQO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Sep 2006 23:16:14 -0400
Received: from ns2.suse.de ([195.135.220.15]:131 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932104AbWIIDQO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Sep 2006 23:16:14 -0400
Date: Fri, 8 Sep 2006 20:16:02 -0700
From: Greg KH <gregkh@suse.de>
To: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Cc: linux-kernel@vger.kernel.org, jeffm@suse.de
Subject: Re: Linux 2.6.17.12
Message-ID: <20060909031602.GA25541@suse.de>
References: <20060908220741.GA26950@kroah.com> <45022333.6030605@eyal.emu.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45022333.6030605@eyal.emu.id.au>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 09, 2006 at 12:13:07PM +1000, Eyal Lebedinsky wrote:
> Greg KH wrote:
> > We (the -stable team) are announcing the release of the 2.6.17.12 kernel.
> 
> A quick report, will investigate later:
> 
> WARNING: /lib/modules/2.6.17.12/kernel/drivers/md/dm-mod.ko needs unknown symbol idr_replace
> 
> I did not change my config throughout the series.

Oh nevermind, I need another patch from Jeff that adds idr_replace(),
sorry about that, I'll go dig it up from the proper git tree...

thanks,

greg k-h
