Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265136AbTLWNP3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Dec 2003 08:15:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265140AbTLWNP3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Dec 2003 08:15:29 -0500
Received: from phoenix.infradead.org ([213.86.99.234]:23567 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S265136AbTLWNP0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Dec 2003 08:15:26 -0500
Date: Tue, 23 Dec 2003 13:15:23 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Greg KH <greg@kroah.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-hotplug-devel@lists.sourceforge.net
Subject: Re: [PATCH] add sysfs mem device support  [2/4]
Message-ID: <20031223131523.B6864@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Greg KH <greg@kroah.com>, Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org,
	linux-hotplug-devel@lists.sourceforge.net
References: <20031223002126.GA4805@kroah.com> <20031223002439.GB4805@kroah.com> <20031223002609.GC4805@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20031223002609.GC4805@kroah.com>; from greg@kroah.com on Mon, Dec 22, 2003 at 04:26:09PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 22, 2003 at 04:26:09PM -0800, Greg KH wrote:
> This adds /sys/class/mem which enables all mem char devices to show up
> properly in udev.
> 
> Has been posted to linux-kernel every so often since last July, and
> acked by a number of other kernel developers.

This is pointless.  The original point of sysfs and co was to present the
physical device tree, where these devices absolutely fit into.  Why are
you doing this at all?  Creating thse through udev doesn't make sense as
they need to be present anyway..

