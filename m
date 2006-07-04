Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751328AbWGDARP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751328AbWGDARP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jul 2006 20:17:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751329AbWGDARP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jul 2006 20:17:15 -0400
Received: from ns.suse.de ([195.135.220.2]:18322 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751328AbWGDARP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jul 2006 20:17:15 -0400
Date: Mon, 3 Jul 2006 17:13:41 -0700
From: Greg KH <greg@kroah.com>
To: Daniel Bonekeeper <thehazard@gmail.com>
Cc: Alon Bar-Lev <alon.barlev@gmail.com>, kernelnewbies@nl.linux.org,
       linux-kernel@vger.kernel.org
Subject: Re: Driver for Microsoft USB Fingerprint Reader
Message-ID: <20060704001341.GA923@kroah.com>
References: <9e0cf0bf0607030304n62991dafk19f09e41d69e9ab0@mail.gmail.com> <e1e1d5f40607031104o2b8003c8qfa725ae1d276b27f@mail.gmail.com> <44A95F12.8080208@gmail.com> <e1e1d5f40607031353l48826d5bi51558d9f8e12ba3@mail.gmail.com> <20060703214509.GA5629@kroah.com> <e1e1d5f40607031511l5445f338t449bf8840e8caf80@mail.gmail.com> <20060703222645.GA22855@kroah.com> <e1e1d5f40607031624w245e5f70g2ae8f5d0e9d357c4@mail.gmail.com> <20060703232927.GA19111@kroah.com> <e1e1d5f40607031704kec2ff68w324d3d8ad111c46b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e1e1d5f40607031704kec2ff68w324d3d8ad111c46b@mail.gmail.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 03, 2006 at 08:04:39PM -0400, Daniel Bonekeeper wrote:
> Ok, I'll develop this in a cleaner way. But did you get the idea ? Let
> me know if you think that this is something worthy to develop so I can
> work on it. There are some details that I need to study about the USB
> layer to get the whole picture so I can avoid redundant stuff.
> 
> I just think that it would be cool to be able to know the capabilities
> of each device connected to our system, and who's better to tell us
> that than the device drivers? =]
> This way we can know, for example, that a webcam can do 30fps at
> 640x480 and the output type of the video, independently of which
> webcam (and driver) we're using...

Take a look at the V4L2 layer :)

thanks,

greg k-h
