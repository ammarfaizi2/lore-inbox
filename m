Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277435AbRJZD4M>; Thu, 25 Oct 2001 23:56:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277509AbRJZD4C>; Thu, 25 Oct 2001 23:56:02 -0400
Received: from c1313109-a.potlnd1.or.home.com ([65.0.121.190]:31502 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S277435AbRJZDzx>;
	Thu, 25 Oct 2001 23:55:53 -0400
Date: Thu, 25 Oct 2001 20:55:38 -0700
From: Greg KH <greg@kroah.com>
To: "Peter A. Goodall" <pete@ximian.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Seg fault when syncing Sony Clie 760 with USB cradle
Message-ID: <20011025205538.A25032@kroah.com>
In-Reply-To: <1004062619.1406.29.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1004062619.1406.29.camel@localhost.localdomain>
User-Agent: Mutt/1.3.23i
X-Operating-System: Linux 2.2.19 (i586)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 25, 2001 at 10:16:59PM -0400, Peter A. Goodall wrote:
> I am running Redhat 7.1 with the 2.4.12 kernel and using xfs.  I have
> applied an SGI patch (linux-2.4.12-xfs-2001-10-11.patch.bz2) to run
> xfs.  I am using coldsync 2.2.0 to sync and everytime I try to sync it I
> get a seg fault.  This causes a kernel panic and I am no longer able to
> use the USB port until I reboot.  Below is the end of /var/log/messages:

Does the oops happen at the end of the sync, or at the beginning?

Can you run that oops through ksymoops for me?

thanks,

greg k-h
