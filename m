Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280864AbRKBW6Z>; Fri, 2 Nov 2001 17:58:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280866AbRKBW6P>; Fri, 2 Nov 2001 17:58:15 -0500
Received: from peabody.ximian.com ([141.154.95.10]:25359 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP
	id <S280864AbRKBW5z>; Fri, 2 Nov 2001 17:57:55 -0500
Subject: Re: Seg fault when syncing Sony Clie 760 with USB cradle
From: "Peter A. Goodall" <pete@ximian.com>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20011025205538.A25032@kroah.com>
In-Reply-To: <1004062619.1406.29.camel@localhost.localdomain> 
	<20011025205538.A25032@kroah.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.16.99+cvs.2001.10.29.22.54 (Preview Release)
Date: 02 Nov 2001 17:57:44 -0500
Message-Id: <1004741864.7016.35.camel@colobus.ximian.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2001-10-25 at 23:55, Greg KH wrote:
> On Thu, Oct 25, 2001 at 10:16:59PM -0400, Peter A. Goodall wrote:
> > I am running Redhat 7.1 with the 2.4.12 kernel and using xfs.  I have
> > applied an SGI patch (linux-2.4.12-xfs-2001-10-11.patch.bz2) to run
> > xfs.  I am using coldsync 2.2.0 to sync and everytime I try to sync it I
> > get a seg fault.  This causes a kernel panic and I am no longer able to
> > use the USB port until I reboot.  Below is the end of /var/log/messages:
> 
> Does the oops happen at the end of the sync, or at the beginning?
> 
> Can you run that oops through ksymoops for me?
> 
> thanks,
> 
> greg k-h

I noticed that my last kernel was not behaving correctly.  Specifically
that nfs (unrelated) and devfs were not starting correctly.  I upgraded
to the 2.4.13 kernel and paid special attention to those two items.  Now
syncing with Coldsync no longer causes a kernel panic.  It just doesn't
work.  It can't communicate with the Clie to get the serial number and
other information.  Since I'm using devfs I can't say it is the kernel. 
I will have to test it further.

- PAG

-- 
Pete Goodall
  Support Tech
  Ximian, Inc.
  pete@ximian.com

