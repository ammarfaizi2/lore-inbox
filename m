Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262174AbTLWQkd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Dec 2003 11:40:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262164AbTLWQkZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Dec 2003 11:40:25 -0500
Received: from phoenix.infradead.org ([213.86.99.234]:40976 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S262131AbTLWQjH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Dec 2003 11:39:07 -0500
Date: Tue, 23 Dec 2003 16:39:04 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Rob Love <rml@ximian.com>
Cc: Christoph Hellwig <hch@infradead.org>, Greg KH <greg@kroah.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-hotplug-devel@lists.sourceforge.net
Subject: Re: [PATCH] add sysfs mem device support  [2/4]
Message-ID: <20031223163904.A8589@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Rob Love <rml@ximian.com>, Greg KH <greg@kroah.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	linux-hotplug-devel@lists.sourceforge.net
References: <20031223002126.GA4805@kroah.com> <20031223002439.GB4805@kroah.com> <20031223002609.GC4805@kroah.com> <20031223131523.B6864@infradead.org> <1072193516.3472.3.camel@fur>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1072193516.3472.3.camel@fur>; from rml@ximian.com on Tue, Dec 23, 2003 at 10:31:56AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 23, 2003 at 10:31:56AM -0500, Rob Love wrote:
> Creating them via udev is the point.
> 
> Remember, the ultimate goal is to have udev in initramfs during early
> boot, and all of these vital devices will be created.

I disagree. For fully static devices like the mem devices the udev indirection
is completely superflous.

