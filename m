Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262097AbTEMQhW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 12:37:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261956AbTEMQgW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 12:36:22 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:26363 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S261950AbTEMQgN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 12:36:13 -0400
Date: Tue, 13 May 2003 09:48:46 -0700
From: Greg KH <greg@kroah.com>
To: "Bryan O'Sullivan" <bos@serpentine.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: USB mouse freezes under X - 2.5.69 and 2.5.69-mm*
Message-ID: <20030513164846.GB10010@kroah.com>
References: <1052843843.1148.7.camel@serpentine.internal.keyresearch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1052843843.1148.7.camel@serpentine.internal.keyresearch.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 13, 2003 at 09:37:23AM -0700, Bryan O'Sullivan wrote:
> Hi, Greg -
> 
> I just booted into vanilla 2.5.69, and confirmed that my mouse still
> freezes under X.  I have something vaguely like a reproduction recipe:
> drag a window around vigorously on the screen for a bit, and the mouse
> will seize up.
> 
> I've attached the usual files, in case they're useful to you in figuring
> out what might be wrong.  My userspace is Red Hat 9, barely modified.

Hm, I don't know what to say.  It works here for me :)

Anyway, try enabling USB_DEBUG and see if anything interesting happens
in the logs when the mouse dies.

Also, can you create a bug entry in bugzilla.kernel.org for this, so I
can assign it to the USB mouse author/maintainer?  :)

And no, this isn't a "hold 2.6 issue" by any means.  Lots of odd
driver/device interactions never get figured out, especially for cheap
USB hardware...

thanks,

greg k-h
