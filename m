Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272413AbRIQVHz>; Mon, 17 Sep 2001 17:07:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272602AbRIQVHp>; Mon, 17 Sep 2001 17:07:45 -0400
Received: from c1313109-a.potlnd1.or.home.com ([65.0.121.190]:51974 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S272413AbRIQVHb>;
	Mon, 17 Sep 2001 17:07:31 -0400
Date: Mon, 17 Sep 2001 14:05:00 -0700
From: Greg KH <greg@kroah.com>
To: David Acklam <dackl@post.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: compiled-in (non-modular) USB initialization bug
Message-ID: <20010917140500.C32389@kroah.com>
In-Reply-To: <Pine.LNX.4.30.0109171430130.3275-100000@udcnet.dyn.dhs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.30.0109171430130.3275-100000@udcnet.dyn.dhs.org>
User-Agent: Mutt/1.3.21i
X-Operating-System: Linux 2.2.19 (i586)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 17, 2001 at 02:34:42PM -0500, David Acklam wrote:
> A few months ago I posted a bug report about the Pegasus driver not
> initializing  (or not initializing fast enough to work with NFS-Root) when
> compiled-in. I've found that this is not specific to the
> pegasus, as I have recently noticed that the kernel 'driver-initialized'
> messages for my USB mouse and keyboard (i.e. HID devices) come up AFTER
> init has been started. These drivers are also 'compiled-in'
> 
> The problem this poses is that some applications (like NFSRoot) need
> access to USB devices BEFORE the kernel mounts filesystems/starts init.

Could you send me / the list the kernel boot messages when this happens?
Along with the .config that you used?

thanks,

greg k-h
