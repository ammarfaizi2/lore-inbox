Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262569AbTLWUdK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Dec 2003 15:33:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262603AbTLWUdK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Dec 2003 15:33:10 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:62867 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262569AbTLWUdI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Dec 2003 15:33:08 -0500
Date: Tue, 23 Dec 2003 20:33:07 +0000
From: viro@parcelfarce.linux.theplanet.co.uk
To: Stephan Maciej <stephanm@muc.de>
Cc: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org,
       linux-hotplug-devel@lists.sourceforge.net
Subject: Re: [PATCH] add sysfs mem device support  [2/4]
Message-ID: <20031223203307.GD4176@parcelfarce.linux.theplanet.co.uk>
References: <20031223002126.GA4805@kroah.com> <1072193516.3472.3.camel@fur> <20031223163904.A8589@infradead.org> <200312232100.04739.stephanm@muc.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200312232100.04739.stephanm@muc.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 23, 2003 at 09:00:04PM +0100, Stephan Maciej wrote:
> On Tuesday 23 December 2003 17:39, Christoph Hellwig wrote:
> > I disagree. For fully static devices like the mem devices the udev
> > indirection is completely superflous.
> 
> It can be considered superfluous, but OTOH I think when creating a clean 
> interface it's desirable to keep the number of exceptional items as small as 
> possible, IOW zero.

Trying to get rid of them for the sake of getting rid of them can very well
make interface (a) not clean and (b) harder to cleanup up later.
