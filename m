Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311701AbSDIVax>; Tue, 9 Apr 2002 17:30:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311710AbSDIVaw>; Tue, 9 Apr 2002 17:30:52 -0400
Received: from granite.he.net ([216.218.226.66]:32015 "EHLO granite.he.net")
	by vger.kernel.org with ESMTP id <S311701AbSDIVav>;
	Tue, 9 Apr 2002 17:30:51 -0400
Date: Tue, 9 Apr 2002 14:30:49 -0700
From: Greg KH <greg@kroah.com>
To: Rob Hall <rob@compuplusonline.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.7,8-pre2 and USB
Message-ID: <20020409143049.A25192@kroah.com>
Mail-Followup-To: Greg KH <greg@kroah.com>,
	Rob Hall <rob@compuplusonline.com>,
	linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20020409133710.A21829@kroah.com> <BBENIHKKLAMLHIECFJEPMEPKCAAA.rob@compuplusonline.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
X-Operating-System: Linux 2.2.20 (i686)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 09, 2002 at 04:58:30PM -0400, Rob Hall wrote:
> I was previously running the 2.4.18 kernel... This is the first devel kernel
> I have installed since 2.3.x :) I've noticed that according to dmesg, 2.4.x
> inits USB MUCH later in the boot sequence than 2.5.7 and 8-pre2 do.

The USB core starts up much earlier, yes.
But the OHCI driver should still be initialized at the same place.

What messages do you have in your system log when the machine locks up?

And have you tried the ohci-hcd driver instead of usb-ohci?

thanks,

greg k-h
