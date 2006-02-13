Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964871AbWBMW0t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964871AbWBMW0t (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 17:26:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964870AbWBMW0t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 17:26:49 -0500
Received: from ogre.sisk.pl ([217.79.144.158]:10370 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S964871AbWBMW0s (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 17:26:48 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Flames over -- Re: Which is simpler?
Date: Mon, 13 Feb 2006 23:27:09 +0100
User-Agent: KMail/1.9.1
Cc: Phillip Susi <psusi@cfl.rr.com>, Kyle Moffett <mrmacman_g4@mac.com>,
       Alon Bar-Lev <alon.barlev@gmail.com>,
       Kernel development list <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44L0.0602131601220.4754-100000@iolanthe.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.0602131601220.4754-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602132327.10475.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Monday 13 February 2006 22:24, Alan Stern wrote:
> On Mon, 13 Feb 2006, Phillip Susi wrote:
}-- snip --{
> You are complaining because you don't like the way USB was designed.  
> That's fine, but it leaves you advocating a non-standardized position.
> 
> Can you suggest a _reliable_ way to tell if the USB device present at a 
> port after resuming is the same device as was there before suspending?

It seems to follow from your discussion that if I have a mounted filesystem
on a USB device and I suspend to disk, I can lose data unless the filesystem
has been mounted with "sync".

If this is the case, there should be a big fat warning in the swsusp
documentation, but there's nothing like that in there (at lease I can't find
it easily).

[If this is not the case, I've missed something and sorry for the noise.]

Greetings,
Rafael
