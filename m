Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261902AbVD1EO7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261902AbVD1EO7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Apr 2005 00:14:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261903AbVD1EO7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Apr 2005 00:14:59 -0400
Received: from mail.kroah.org ([69.55.234.183]:48036 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261902AbVD1EO5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Apr 2005 00:14:57 -0400
Date: Wed, 27 Apr 2005 21:14:28 -0700
From: Greg KH <greg@kroah.com>
To: Joe <joecool1029@gmail.com>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: Device Node Issues with recent mm's and udev
Message-ID: <20050428041428.GB9723@kroah.com>
References: <d4757e6005042716523af66bae@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d4757e6005042716523af66bae@mail.gmail.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 27, 2005 at 07:52:39PM -0400, Joe wrote:
> This issue started to appear in around the 2.6.11-mm series.. it
> continues even now with 2.6.12-rc2-mm3.
> 
> Attempting to copy an image to a device with a tool like dd, results
> in the device node being overwritten with the data, but the data is
> never sent to the destination drive for instance.
> 
> To try to put it more plainly, I have a firmware image I am copying to
> an ipod.  Normally the image sends with no issues and the ipod has the
> new firmware.

Is the device "disappearing" and then the udev deletes the device node,
and then dd starts dumping data to a file instead?

Anything in your kernel log when this happens?

Does this happen with 2.6.12-rc3?

thanks,

greg k-h
