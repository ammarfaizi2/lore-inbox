Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030222AbWBMWv2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030222AbWBMWv2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 17:51:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030227AbWBMWv2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 17:51:28 -0500
Received: from mail.fieldses.org ([66.93.2.214]:39885 "EHLO
	pickle.fieldses.org") by vger.kernel.org with ESMTP
	id S1030222AbWBMWv1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 17:51:27 -0500
Date: Mon, 13 Feb 2006 17:51:18 -0500
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Phillip Susi <psusi@cfl.rr.com>, Kyle Moffett <mrmacman_g4@mac.com>,
       Alon Bar-Lev <alon.barlev@gmail.com>,
       Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: Flames over -- Re: Which is simpler?
Message-ID: <20060213225118.GM10956@fieldses.org>
References: <43F0EE30.2090409@cfl.rr.com> <Pine.LNX.4.44L0.0602131601220.4754-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0602131601220.4754-100000@iolanthe.rowland.org>
User-Agent: Mutt/1.5.11+cvs20060126
From: "J. Bruce Fields" <bfields@fieldses.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 13, 2006 at 04:24:30PM -0500, Alan Stern wrote:
> Can you suggest a _reliable_ way to tell if the USB device present at a 
> port after resuming is the same device as was there before suspending?

That's not really enough, is it?  What if you suspend, unplug your usb
flash drive, plug it into your camera, take a few pictures, plug it back
into the camera, then resume?

If you don't throw away the old mount, that sounds equivalent to
allowing writes to /dev/hda1 while it has a local filesystem mounted on
it.  There may be limits to what you can do to prevent that in this
case, but it seems best to err on the side of caution.

--b.
