Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264039AbTEFTKm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 15:10:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264040AbTEFTKm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 15:10:42 -0400
Received: from traffic.dsnl.net ([213.160.215.14]:24470 "EHLO
	audrey1.deltasolutions.nl") by vger.kernel.org with ESMTP
	id S264039AbTEFTKl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 15:10:41 -0400
Subject: Re: [Mjpeg-developer] Re: [patch/2.5.69] zoran driver update
From: Ronald Bultje <R.S.Bultje@pharm.uu.nl>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Greg KH <greg@kroah.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       mjpeg-developer@lists.sourceforge.net, Gerd Knorr <kraxel@bytesex.org>,
       Frank Davis <fdavis@si.rr.com>
In-Reply-To: <1052243658.1202.48.camel@dhcp22.swansea.linux.org.uk>
References: <1052234524.2482.70.camel@shrek.bitfreak.net>
	 <20030506182257.GA2043@kroah.com>
	 <1052243658.1202.48.camel@dhcp22.swansea.linux.org.uk>
Content-Type: text/plain
Organization: Universiteit Utrecht
Message-Id: <1052248883.2132.7.camel@shrek.bitfreak.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.3.2 (1.3.2-1) (Preview Release)
Date: 06 May 2003 21:22:03 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Alan,

thanks for the comment.

On Tue, 2003-05-06 at 19:54, Alan Cox wrote:
> Someone also needs to make sure the merge keeps all the security fixes
> from the old driver.

I've diff'ed the 'old' driver versus the kernel driver (2.4.16, I
think), removing all formatting changes (someone ran indent over the
kernel driver. ;-)). The only obvious change was that semaphores were
added. The new driver has semaphores built-in, so that's taken care of.
Besides that, I don't think there were any real differences. If I missed
anything, please let me know. I'd like to add them to our CVS too, then.

Again, thanks!

Ronald

