Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030722AbWKUGsp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030722AbWKUGsp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Nov 2006 01:48:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030681AbWKUGsp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Nov 2006 01:48:45 -0500
Received: from gate.crashing.org ([63.228.1.57]:31390 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1030723AbWKUGso (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Nov 2006 01:48:44 -0500
Subject: Re: bus_id collisions
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Greg KH <greg@kroah.com>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20061121064122.GA10510@kroah.com>
References: <1164081736.8207.14.camel@localhost.localdomain>
	 <20061121064122.GA10510@kroah.com>
Content-Type: text/plain
Date: Tue, 21 Nov 2006 17:49:20 +1100
Message-Id: <1164091760.5597.18.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Oh, that's a very annoying bus id, but I guess it's legal.
> 
> I'll poke around and see if I can make it bigger.  You don't want it
> bigger for static 'struct device' types, right?

Don't bother too much if it's complicated. I'm trying other options as
well, like possibly using the Open Firmware "phandle" (sort of object
ID) which is only 32 bits, provided I can get the embedded folks to
agree to have one at all...

Cheers,
Ben.


