Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293289AbSBXG1p>; Sun, 24 Feb 2002 01:27:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293290AbSBXG1f>; Sun, 24 Feb 2002 01:27:35 -0500
Received: from 12-224-37-81.client.attbi.com ([12.224.37.81]:30468 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S293289AbSBXG1S>;
	Sun, 24 Feb 2002 01:27:18 -0500
Date: Sat, 23 Feb 2002 22:21:24 -0800
From: Greg KH <greg@kroah.com>
To: Dan Hopper <ku4nf@austin.rr.com>, Patrick Mochel <mochel@osdl.org>,
        Pierre Rousselet <pierre.rousselet@wanadoo.fr>,
        lkml <linux-kernel@vger.kernel.org>,
        linux-usb-devel@lists.sourceforge.net
Subject: Re: 2.5.5-pre1 rmmod usb-uhci hangs
Message-ID: <20020224062124.GB15060@kroah.com>
In-Reply-To: <fa.n7cofbv.1him3j@ifi.uio.no> <fa.dsb79pv.on84ii@ifi.uio.no> <20020224025411.GA2418@yoda.dummynet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020224025411.GA2418@yoda.dummynet>
User-Agent: Mutt/1.3.26i
X-Operating-System: Linux 2.2.20 (i586)
Reply-By: Sun, 27 Jan 2002 04:03:06 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 23, 2002 at 08:54:11PM -0600, Dan Hopper wrote:
> 
> I wonder if anyone might look at doing the same sort of fix to
> the 2.4.18 working tree?  I experience the same sort of behavior
> with usb-uhci on my KT266A board (VT82C586B USB) on 2.4.18-rc1 (and
> previous 2.4.x kernels, too).  I'd do it myself, but the patch from
> Patrick on inode.c makes me too nervous to do it, since I have
> no experience with the filesystem drivers.

These patches will not apply for the 2.4 tree, even if you tried :)

What problems are you having with 2.4.18-rc1 and previous?  Any oops
messages?

thanks,

greg k-h
