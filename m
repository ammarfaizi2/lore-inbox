Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262360AbTLWTqE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Dec 2003 14:46:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262761AbTLWTqD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Dec 2003 14:46:03 -0500
Received: from peabody.ximian.com ([141.154.95.10]:11749 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S262360AbTLWTp7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Dec 2003 14:45:59 -0500
Subject: Re: [PATCH] add sysfs mem device support  [2/4]
From: Rob Love <rml@ximian.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Christoph Hellwig <hch@infradead.org>, Greg KH <greg@kroah.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-hotplug-devel@lists.sourceforge.net
In-Reply-To: <20031223194209.GA26278@gtf.org>
References: <20031223002126.GA4805@kroah.com>
	 <20031223002439.GB4805@kroah.com> <20031223002609.GC4805@kroah.com>
	 <20031223131523.B6864@infradead.org> <20031223180127.GA14282@kroah.com>
	 <20031223191634.A8914@infradead.org> <1072207183.6015.19.camel@fur>
	 <20031223192226.A10239@infradead.org> <1072207555.6015.22.camel@fur>
	 <20031223194209.GA26278@gtf.org>
Content-Type: text/plain
Message-Id: <1072208750.6987.4.camel@fur>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-8) 
Date: Tue, 23 Dec 2003 14:45:50 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-12-23 at 14:42, Jeff Garzik wrote:

> Not precisely.  If your userspace program can obtain random numbers in
> some other way, it should...  /dev/random shouldn't be considered as the
> canonical source for random bits for the entire machine.

s/the random number generator/the kernel's random number generator
(random.c)/

E.g., my point was that the device file was the user-space
representation of the kernel rng, so associating the kernel rng
attributes with the device file made sense.  I did not mean to imply it
was the be-all and end-all of rng's on the machine.

	Rob Love


