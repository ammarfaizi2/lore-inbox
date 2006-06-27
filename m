Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932065AbWF0FfU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932065AbWF0FfU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 01:35:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932078AbWF0FfU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 01:35:20 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:3160 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S932065AbWF0FfS convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 01:35:18 -0400
Date: Tue, 27 Jun 2006 07:36:24 +0200
From: Jens Axboe <axboe@suse.de>
To: Nigel Cunningham <nigel@suspend2.net>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, linux-kernel@vger.kernel.org
Subject: Re: [Suspend2][ 0/9] Extents support.
Message-ID: <20060627053623.GG22071@suse.de>
References: <20060626165404.11065.91833.stgit@nigel.suspend2.net> <200606262320.01535.rjw@sisk.pl> <200606271428.11654.nigel@suspend2.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <200606271428.11654.nigel@suspend2.net>
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 27 2006, Nigel Cunningham wrote:
> Hi.
> 
> On Tuesday 27 June 2006 07:20, Rafael J. Wysocki wrote:
> > On Monday 26 June 2006 18:54, Nigel Cunningham wrote:
> > > Add Suspend2 extent support. Extents are used for storing the lists
> > > of blocks to which the image will be written, and are stored in the
> > > image header for use at resume time.
> >
> > Could you please put all of the changes in kernel/power/extents.c into one
> > patch?  It's quite difficult to review them now, at least for me.
> 
> I spent a long time splitting them up because I was asked in previous 
> iterations to break them into manageable chunks. How about if I were to email 
> you the individual files off line, so as to not send the same amount again?

Managable chunks means logical changes go together, one function per
diff is really extreme and unreviewable. Support for extents is one
logical change, so it's one patch. Unless of course you have to do some
preparatory patches, then you'd do those separately.

I must admit I thought you were kidding when I read through this extents
patch series, having a single patch just adding includes!

-- 
Jens Axboe

