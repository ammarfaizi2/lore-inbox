Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262421AbRFNJZJ>; Thu, 14 Jun 2001 05:25:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262432AbRFNJY7>; Thu, 14 Jun 2001 05:24:59 -0400
Received: from green.csi.cam.ac.uk ([131.111.8.57]:6835 "EHLO
	green.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S262421AbRFNJYz>; Thu, 14 Jun 2001 05:24:55 -0400
Date: Thu, 14 Jun 2001 10:24:47 +0100 (BST)
From: James Sutherland <jas88@cam.ac.uk>
X-X-Sender: <jas88@green.csi.cam.ac.uk>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Rainer Mager <rmager@vgkk.com>, <linux-kernel@vger.kernel.org>
Subject: Re: obsolete code must die
In-Reply-To: <E15ARz4-0004Jm-00@the-village.bc.nu>
Message-ID: <Pine.SOL.4.33.0106141023030.15074-100000@green.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Jun 2001, Alan Cox wrote:

> > Would it make sense to create some sort of 'make config' script that
> > determines what you want in your kernel and then downloads only those
> > components? After all, with the constant release of new hardware, isn't a
> > 50MB kernel release not too far away? 100MB?
>
> This should be a FAQ entry.
>
> For folks doing kernel development a split tree is a nightmare to
> manage so we dont bother. Nothing stops a third party splitting and
> maintaining the tools to download just the needed bits for those who
> want to do it that way

I vaguely remember a distro shipping a kernel source tree without the
non-i386 arch directories. Looked like a good idea at first - saved a fair
chunk of disk space, and didn't break anything. Then you try applying a
patch, and get a truckload of errors... Easier just to keep the whole
thing together, IMO.


James.

