Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750876AbWF2EyM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750876AbWF2EyM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 00:54:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750886AbWF2EyM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 00:54:12 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:9305 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1750846AbWF2EyL convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 00:54:11 -0400
Date: Thu, 29 Jun 2006 06:55:53 +0200
From: Jens Axboe <axboe@suse.de>
To: Pavel Machek <pavel@suse.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.17-git broke suspend!
Message-ID: <20060629045552.GT32115@suse.de>
References: <20060627181045.GA32115@suse.de> <20060628211937.GA30373@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20060628211937.GA30373@elf.ucw.cz>
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 28 2006, Pavel Machek wrote:
> On Tue 2006-06-27 20:10:45, Jens Axboe wrote:
> > Hi,
> > 
> > The git tree from yesterday and as of right now doesn't suspend on my
> > laptop. It does it's regular thing, then hits:
> > 
> > [...]
> > Stopping tasks:
> > ===========================================================================================|
> > eth1: Going into suspend...
> > Class driver suspend failed for cpu0
> > Could not power down device `×1x: error -22
>                               ~~~~
> 
> Someone fails to initialize device name properly? :-(. Can you try
> with minimum drivers?

It works now, I think it was a combination of a bug that got fixed with
and my missing .config entry.

-- 
Jens Axboe

