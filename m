Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261755AbTIPCjE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Sep 2003 22:39:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261761AbTIPCjE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Sep 2003 22:39:04 -0400
Received: from cmu-24-35-14-252.mivlmd.cablespeed.com ([24.35.14.252]:60044
	"EHLO localhost.localdomain") by vger.kernel.org with ESMTP
	id S261755AbTIPCjB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Sep 2003 22:39:01 -0400
Date: Mon, 15 Sep 2003 22:38:38 -0400 (EDT)
From: Thomas Molina <tmolina@cablespeed.com>
X-X-Sender: tmolina@localhost.localdomain
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: 2.7 block ramblings (was Re: DMA for ide-scsi?)
In-Reply-To: <1063565701.2149.14.camel@dhcp23.swansea.linux.org.uk>
Message-ID: <Pine.LNX.4.44.0309152229390.5337-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 14 Sep 2003, Alan Cox wrote:

> On Sul, 2003-09-14 at 18:01, Andries Brouwer wrote:
> > I do not understand your complaint.
> 
> I sort of do - several vendor installers use fixed labels so
> two installs on the same box get very confused. I've seen
> novices tie themselves in knots with it before. That isn't
> a problem with LABEL=, its an implementation issue with the
> vendors install tools, and Red Hat certainly is one of the
> parties that made this mistake.

LABEL= is the wrong solution to the right problem, IMHO.  It only seems to 
make sense if you are a distributor trying to make a one size mostly fits 
all.  If you tinker with your system it only seems to get in the way.  

It seems to me that if you are in the position of tinkering, and 
installing an OS you ought to have an understanding of root and boot 
disks, and what is in your system.  If you don't understand things well 
enough to specify the proper boot disk and root disk you shouldn't be 
tinkering and it won't matter how each is specified.



