Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264798AbSK0VMU>; Wed, 27 Nov 2002 16:12:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264822AbSK0VMU>; Wed, 27 Nov 2002 16:12:20 -0500
Received: from phoenix.infradead.org ([195.224.96.167]:55047 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S264798AbSK0VMT>; Wed, 27 Nov 2002 16:12:19 -0500
Date: Wed, 27 Nov 2002 21:19:36 +0000
From: Christoph Hellwig <hch@infradead.org>
To: "Adam J. Richter" <adam@yggdrasil.com>
Cc: hch@infradead.org, axboe@suse.de, linux-kernel@vger.kernel.org
Subject: Re: Patch/resubmit(2.5.49): Use struct io_restrictions in blkdev.h
Message-ID: <20021127211936.A5784@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	"Adam J. Richter" <adam@yggdrasil.com>, axboe@suse.de,
	linux-kernel@vger.kernel.org
References: <200211272059.MAA07630@baldur.yggdrasil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200211272059.MAA07630@baldur.yggdrasil.com>; from adam@yggdrasil.com on Wed, Nov 27, 2002 at 12:59:46PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 27, 2002 at 12:59:46PM -0800, Adam J. Richter wrote:
> >On Wed, Nov 27, 2002 at 11:49:40AM -0800, Adam J. Richter wrote:
> >> 	Here is an updated version of the patch.  The struct
> >> io_restrictions declaration is in <linux/device-mapper.h> so that the
> >> device-mapper user level utilities compile properly (device-mapper.h
> >> is written to support inclusion by user level programs).
> 
> >They shouldn't include it anyway.  Please put it into a proper place.
> 
> 	I don't know what you mean by "shouldn't" or "proper" in this
> context.  If you'd state technical advantages or disadvanges, others
> could determine these labels for themselves.
> 
> 	Anyhow, what would be a "proper" place as you see it?

blkdev.h

