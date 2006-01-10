Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932364AbWAJTkF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932364AbWAJTkF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 14:40:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932524AbWAJTkF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 14:40:05 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:9243 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S932364AbWAJTkE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 14:40:04 -0500
Date: Tue, 10 Jan 2006 20:42:00 +0100
From: Jens Axboe <axboe@suse.de>
To: Bernd Eckenfels <be-news06@lina.inka.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2G memory split
Message-ID: <20060110194200.GD3389@suse.de>
References: <43C3E9C2.1000309@rtr.ca> <E1EwNc8-00063F-00@calista.inka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1EwNc8-00063F-00@calista.inka.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


(please don't drop people from the cc list)

On Tue, Jan 10 2006, Bernd Eckenfels wrote:
> Mark Lord <lkml@rtr.ca> wrote:
> > So, the patch would now look like this:
> 
> can we please state something what the 3G_OPT is suppsoed to do? Is
> this "optimzed for 1GB Real RAM"? Should this be something like "2.5G"
> instead?

Hmm I thought it was obvious with the description in paranthesis after
the option. Basically the option is just an optimized default for 1GB of
RAM, like the 2G option is tailored for 2GB of low mem on a 2GB machine.

The reason the option exists is of course to leave the default at the
older not-so-great option for 1G of RAM.

-- 
Jens Axboe

