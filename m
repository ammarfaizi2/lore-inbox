Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161064AbWGUMNe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161064AbWGUMNe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jul 2006 08:13:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161061AbWGUMNd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jul 2006 08:13:33 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:34341 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1161060AbWGUMNc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jul 2006 08:13:32 -0400
Date: Fri, 21 Jul 2006 14:13:06 +0200
From: Jens Axboe <axboe@suse.de>
To: Jeff Garzik <jeff@garzik.org>
Cc: James Bottomley <James.Bottomley@SteelEye.com>,
       Ed Lin <ed.lin@promise.com>,
       "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
       hch <hch@infradead.org>, linux-kernel <linux-kernel@vger.kernel.org>,
       akpm <akpm@osdl.org>, promise_linux <promise_linux@promise.com>
Subject: Re: [PATCH] Promise 'stex' driver
Message-ID: <20060721121306.GA25045@suse.de>
References: <1153439728.4754.19.camel@mulgrave> <44C01CD7.4030308@garzik.org> <20060721010724.GB24176@suse.de> <44C02D1E.4090206@garzik.org> <20060721013822.GA25504@suse.de> <44C037B3.4080707@garzik.org> <20060721023647.GA29220@suse.de> <44C0436E.306@garzik.org> <20060721031855.GA31187@suse.de> <44C04F6F.2000906@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44C04F6F.2000906@garzik.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 20 2006, Jeff Garzik wrote:
> Jens Axboe wrote:
> >On Thu, Jul 20 2006, Jeff Garzik wrote:
> >>Jens Axboe wrote:
> >>>If I thought that it would ever be updated to use block tagging, I would
> >>>not care at all. The motivation to add it from the Promise end would be
> >>>zero, as it doesn't really bring any immediate improvements for them. So
> >>>it would have to be done by someone else, which means me or you. I don't
> >>>have the hardware to actually test it, so unless you do and would want
> >>>to do it, chances are looking slim :-)
> >>>
> >>>It's a bit of a chicken and egg problem, unfortunately. The block layer
> >>>tagging _should_ be _the_ way to do it, and as such could be labelled a
> >>>requirement. I know that's a bit harsh for the Promise folks, but
> >>>unfortunately someone has to pay the price...
> >>I think it's highly rude to presume that someone who has so-far been 
> >>responsive, and responsible, will suddenly not be so.  That is not the 
> >>way to encourage vendors to join the Linux process.
> >>
> >>They set up an alias for Linux maintainer stuff and have been acting 
> >>like a maintainer that will stick around.  Why punish them for good 
> >>behavior?
> >>
> >
> >I'm not trying to be rude to annyone, sorry if that is the impression
> >you got. I'm just looking at things realistically - the fact is that
> >moving to block layer tagging is not something that will benefit
> >Promise, so it'd be fairly low on their agenda of things to do. I don't
> >mean that in any rude sense, I can completely understand that position.
> >Why would you want to change something that works?  Hence it's
> >reasonable to assume that eg you or I would eventually have to convert
> >it.
> 
> Did you read the patch that started this thread?  Promise has already 
> demonstrated they are willing to add changes requested by the community, 
> on top of an already-working driver.

Alright, then lets just get it merged and hope it works out.

-- 
Jens Axboe

