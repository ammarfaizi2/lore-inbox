Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262464AbSKCUzj>; Sun, 3 Nov 2002 15:55:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262469AbSKCUzj>; Sun, 3 Nov 2002 15:55:39 -0500
Received: from pcp01181799pcs.strl1201.mi.comcast.net ([68.60.201.119]:45810
	"EHLO mythical") by vger.kernel.org with ESMTP id <S262464AbSKCUzi>;
	Sun, 3 Nov 2002 15:55:38 -0500
Date: Sun, 3 Nov 2002 16:02:10 -0500
From: Ryan Anderson <ryan@michonline.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Filesystem Capabilities in 2.6?
Message-ID: <20021103210210.GX1781@mythical.michonline.com>
Mail-Followup-To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0211022004510.2503-100000@home.transmeta.com> <1036327900.29711.18.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1036327900.29711.18.camel@irongate.swansea.linux.org.uk>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 03, 2002 at 12:51:40PM +0000, Alan Cox wrote:
> On Sun, 2002-11-03 at 04:20, Linus Torvalds wrote:
> >  - do a complete "find" over the whole system to show that there is not a 
> >    single suid binary anywhere.
> 
> Thats a hard problem. Since your scan is non atomic and because you have
> directory notifications a running processes can have the setuid apps can
> move the setuid bits around the file system to hide from you. 

I'm fairly certain that Linus was imagining a pre-compromise
vulnerability assessment scan, not a post-compromise "figure out where
the new holes are" scan, honestly.  (You don't even need to have
directory notifications, if you've got a process that is tormenting you
like that, find can just be setup to not report certain things, etc
etc.)

-- 

Ryan Anderson
  sometimes Pug Majere
