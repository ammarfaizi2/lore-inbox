Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261673AbVASKcd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261673AbVASKcd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jan 2005 05:32:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261684AbVASKcd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jan 2005 05:32:33 -0500
Received: from verein.lst.de ([213.95.11.210]:8915 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S261673AbVASKcY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jan 2005 05:32:24 -0500
Date: Wed, 19 Jan 2005 11:32:18 +0100
From: Christoph Hellwig <hch@lst.de>
To: Thomas Viehmann <tv@beamnet.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: permissions of /proc/tty/driver
Message-ID: <20050119103218.GC9793@lst.de>
References: <41E80535.1060309@beamnet.de> <20050116120436.GA13906@lst.de> <41EA688A.6050305@beamnet.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41EA688A.6050305@beamnet.de>
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 16, 2005 at 02:13:46PM +0100, Thomas Viehmann wrote:
> Hi.
> 
> Christoph Hellwig wrote:
> >Counter-question:  What information is available in
> >/proc/tty/driver/usbserial but not in sysfs?
> 
> Thanks for this hint, is there a way of finding vendor and product ids 
> of all ttyUSB devices better than
> looking for /sys/bus/usb/devices/*-*/*-*:*/ttyUSB* and then ckecking the 
> obvious files in the grandparent directory?

I think that's the obvious way.  Using libsysfs will make your life much
easier when doing that, though.

