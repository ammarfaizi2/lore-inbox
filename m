Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030349AbVIVNzx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030349AbVIVNzx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Sep 2005 09:55:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030348AbVIVNzx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Sep 2005 09:55:53 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:19016 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1030345AbVIVNzw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Sep 2005 09:55:52 -0400
Date: Thu, 22 Sep 2005 15:56:09 +0200
From: Jens Axboe <axboe@suse.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Jeff Garzik <jgarzik@pobox.com>, Joshua Kwan <joshk@triplehelix.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: SATA suspend-to-ram patch - merge?
Message-ID: <20050922135607.GK4262@suse.de>
References: <433104E0.4090308@triplehelix.org> <433221A1.5000600@pobox.com> <20050922061849.GJ7929@suse.de> <1127398679.18840.84.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1127398679.18840.84.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 22 2005, Alan Cox wrote:
> On Iau, 2005-09-22 at 08:18 +0200, Jens Axboe wrote:
> > > So currently we are in limbo...
> > 
> > Which is a shame, since it means that software suspend on sata is
> > basically impossible :)
> 
> Not really, everyone on the planet who cares is using the existing patch
> and that just works. If the SCSI folks can't fix the SCSI layer to do
> power management then the scsi drivers just need to not provide pm
> methods until they catch up.

It's a shame for the people not using distros, since they need to first
experience the suspend failure, then google around for a solution, find
the patch, etc. That is a shame, since it could have worked out of the
box since 2.6.12 at least.

And it's a shame because it causes extra work for me everytime we update
the SUSE kernel :-)

-- 
Jens Axboe

