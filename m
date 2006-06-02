Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751200AbWFBGPW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751200AbWFBGPW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jun 2006 02:15:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751152AbWFBGPW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jun 2006 02:15:22 -0400
Received: from mga03.intel.com ([143.182.124.21]:47446 "EHLO
	azsmga101-1.ch.intel.com") by vger.kernel.org with ESMTP
	id S1751092AbWFBGPV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jun 2006 02:15:21 -0400
X-IronPort-AV: i="4.05,202,1146466800"; 
   d="scan'208"; a="44925115:sNHT26187322"
Subject: Re: State of resume for AHCI?
From: "zhao, forrest" <forrest.zhao@intel.com>
To: Jens Axboe <axboe@suse.de>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, Mark Lord <lkml@rtr.ca>,
       Jeff Garzik <jeff@garzik.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Hannes Reinecke <hare@suse.de>, linux-ide@vger.kernel.org
In-Reply-To: <20060602060323.GS4400@suse.de>
References: <447F23C2.8030802@goop.org> <447F3250.5070101@rtr.ca>
	 <20060601183904.GR4400@suse.de> <447F4BC2.8060808@goop.org>
	 <20060602060323.GS4400@suse.de>
Content-Type: text/plain
Date: Fri, 02 Jun 2006 14:03:24 +0800
Message-Id: <1149228204.13451.8.camel@forrest26.sh.intel.com>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.9.2 (1.5.9.2-1) 
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 02 Jun 2006 06:15:00.0146 (UTC) FILETIME=[E0D51120:01C6860B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-06-02 at 08:03 +0200, Jens Axboe wrote:
> On Thu, Jun 01 2006, Jeremy Fitzhardinge wrote:
> > Jens Axboe wrote:
> > >It's a lot more complicated than that, I'm afraid. ahci doesn't even
> > >have the resume/suspend methods defined, plus it needs more work than
> > >piix on resume.
> > >  
> > Hannes Reinecke's patch implements those functions, basically by 
> > factoring out the shutdown and init code and calling them at 
> > suspend/resume time as well.
> > 
> > Is that correct/sufficient?  Or should something else be happening?
> 
> No that's it, I know for a fact that suspend/resume works perfectly with
> the 10.1 suse kernel. You can give that a shot, if you want.

You may mean the Hannes's patch for 10.1 SUSE kernel. Hannes's patch
posted in open source community(or in linux-ide mailing list) didn't
work.

Forrest
