Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262834AbTDNLkY (for <rfc822;willy@w.ods.org>); Mon, 14 Apr 2003 07:40:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262982AbTDNLkY (for <rfc822;linux-kernel-outgoing>);
	Mon, 14 Apr 2003 07:40:24 -0400
Received: from [196.41.29.142] ([196.41.29.142]:61177 "EHLO
	workshop.saharact.lan") by vger.kernel.org with ESMTP
	id S262834AbTDNLkX (for <rfc822;linux-kernel@vger.kernel.org>); Mon, 14 Apr 2003 07:40:23 -0400
Subject: Re: PROBLEM: mkdir on ext3 creates regular file instead of
	directory
From: Martin Schlemmer <azarah@gentoo.org>
To: Ken Moffat <ken@kenmoffat.uklinux.net>
Cc: Russell Nash <russ@nixhelp.org>, KML <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.21.0304141212350.4376-100000@ppg_penguin>
References: <Pine.LNX.4.21.0304141212350.4376-100000@ppg_penguin>
Content-Type: text/plain
Organization: 
Message-Id: <1050320861.4059.14.camel@workshop.saharact.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3- 
Date: 14 Apr 2003 13:47:41 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-04-14 at 13:23, Ken Moffat wrote:
> On Sun, 13 Apr 2003, Russell Nash wrote:
> 
> > [1.] One line summary of the problem:
> > 
> > when using 'mkdir' to create a directory on an ext3 filesystem, a 
> > regular file is created instead of the directory.
> > 
> 
> > 
> > Linux version 2.4.20-gentoo-r1 (root@voyager) (gcc version 3.2.2) #2 Sat 
> > Apr 5 20:58:27 EST 2003
> > 
> 
> > 
> > [6.] A small shell script or example program which triggers the
> >       problem (if possible)
> > 
> > cd
> > rm -rf .variable
> > mkdir .variable
> > cd .variable
> > 
> 
>  Russell, mkdir is working fine here (assorted linuxfromscratch
> boxen), with what look to be similar versions of the main software.  The
> command appears to be part of fileutils (or coreutils), maybe you'll do
> better asking on the gentoo lists.
> 

Works fine here on my 1.2 (gcc-2.95.3) and 1.4 (gcc-3.2.2).


1.2 box: 2.4.20-win4lin-r1

1.4 box:  2.4.19-gentoo-r9
          2.4.20 vanilla
          2.5.67-bk3


Regards,

-- 
Martin Schlemmer
Gentoo Linux Developer, Desktop Team
Cape Town, South Africa

