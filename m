Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262033AbTLYSpz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Dec 2003 13:45:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262092AbTLYSpz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Dec 2003 13:45:55 -0500
Received: from phoenix.infradead.org ([213.86.99.234]:44555 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S262033AbTLYSpy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Dec 2003 13:45:54 -0500
Date: Thu, 25 Dec 2003 18:45:53 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Andreas Jellinghaus <aj@dungeon.inka.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] add sysfs mem device support  [2/4]
Message-ID: <20031225184553.A25397@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Andreas Jellinghaus <aj@dungeon.inka.de>,
	linux-kernel@vger.kernel.org
References: <20031223002126.GA4805@kroah.com> <20031223002439.GB4805@kroah.com> <20031223002609.GC4805@kroah.com> <20031223131523.B6864@infradead.org> <1072193516.3472.3.camel@fur> <20031223163904.A8589@infradead.org> <pan.2003.12.25.17.47.43.603779@dungeon.inka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <pan.2003.12.25.17.47.43.603779@dungeon.inka.de>; from aj@dungeon.inka.de on Thu, Dec 25, 2003 at 06:48:51PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 25, 2003 at 06:48:51PM +0100, Andreas Jellinghaus wrote:
> On Tue, 23 Dec 2003 16:47:44 +0000, Christoph Hellwig wrote:
> > I disagree. For fully static devices like the mem devices the udev
> > indirection is completely superflous.
> 
> If sysfs does not contain data on mem devices, we will need makedev.
> 
> devfs did replace makedev. until udev can create all devices,
> it would need to re-introduce makedev.

So what?

