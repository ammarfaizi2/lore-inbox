Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280728AbRKOEJZ>; Wed, 14 Nov 2001 23:09:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280717AbRKOEJQ>; Wed, 14 Nov 2001 23:09:16 -0500
Received: from c1313109-a.potlnd1.or.home.com ([65.0.121.190]:27653 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S280718AbRKOEJC>;
	Wed, 14 Nov 2001 23:09:02 -0500
Date: Wed, 14 Nov 2001 21:07:45 -0800
From: Greg KH <greg@kroah.com>
To: Jos Nouwen <josn@josn.myip.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: rootfs on USB storage device
Message-ID: <20011114210745.A8285@kroah.com>
In-Reply-To: <Pine.LNX.4.31.0111150349090.24081-100000@ds9.galaxy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.31.0111150349090.24081-100000@ds9.galaxy>
User-Agent: Mutt/1.3.23i
X-Operating-System: Linux 2.2.20 (i586)
Reply-By: Thu, 18 Oct 2001 04:03:20 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 15, 2001 at 04:22:33AM +0100, Jos Nouwen wrote:
> 
> Does anybody have a clue as to what the USB bus has to do with
> /dev/console?

It's a timing issue, and has nothing to do with /dev/console.  If you
sit and spin before you try to mount the root fs, the USB subsystem will
have enough time to find the drive.  There's a few patches that do this
in the lkml archives.

thanks,

greg k-h
