Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265139AbTLWNTl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Dec 2003 08:19:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265137AbTLWNTb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Dec 2003 08:19:31 -0500
Received: from phoenix.infradead.org ([213.86.99.234]:26895 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S265140AbTLWNSB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Dec 2003 08:18:01 -0500
Date: Tue, 23 Dec 2003 13:17:59 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Greg KH <greg@kroah.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-hotplug-devel@lists.sourceforge.net
Subject: Re: [PATCH] add sysfs vc device support  [4/4]
Message-ID: <20031223131759.D6864@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Greg KH <greg@kroah.com>, Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org,
	linux-hotplug-devel@lists.sourceforge.net
References: <20031223002126.GA4805@kroah.com> <20031223002439.GB4805@kroah.com> <20031223002609.GC4805@kroah.com> <20031223002800.GD4805@kroah.com> <20031223002851.GE4805@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20031223002851.GE4805@kroah.com>; from greg@kroah.com on Mon, Dec 22, 2003 at 04:28:51PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 22, 2003 at 04:28:51PM -0800, Greg KH wrote:
> This adds /sys/class/vc which enables all vc char devices to show up
> properly in udev.
> 
> Has been posted to lkml a few times in the past and tested by a wide
> range of people.

Same thing agin.  This is virtual console code and shouldn't be
in sysfs.

Also pasting the same code n times into different subsystems isn't
exactly a good sign of code reuse..
