Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261274AbRFRQG3>; Mon, 18 Jun 2001 12:06:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261296AbRFRQGU>; Mon, 18 Jun 2001 12:06:20 -0400
Received: from ohiper1-48.apex.net ([209.250.47.63]:33289 "EHLO
	hapablap.dyn.dhs.org") by vger.kernel.org with ESMTP
	id <S261274AbRFRQGM>; Mon, 18 Jun 2001 12:06:12 -0400
Date: Mon, 18 Jun 2001 11:04:57 -0500
From: Steven Walter <srwalter@yahoo.com>
To: Geoffrey Gallaway <geoffeg@sin.sloth.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Error in documentation?
Message-ID: <20010618110457.A21328@hapablap.dyn.dhs.org>
In-Reply-To: <20010618111510.A27662@sin.sloth.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010618111510.A27662@sin.sloth.org>; from geoffeg@sin.sloth.org on Mon, Jun 18, 2001 at 11:15:11AM -0400
X-Uptime: 9:58am  up 1 day, 16:24,  0 users,  load average: 1.41, 1.23, 1.29
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It does appear that the documentation regarding this is out of date.
However, you can still install modules to a given location by:

INSTALL_MOD_PATH="/path/to/modules" make modules_install

Had to dig through the Makefile for that, though it may actually be
documented somewhere.

On Mon, Jun 18, 2001 at 11:15:11AM -0400, Geoffrey Gallaway wrote:
> linux/Documentation/modules.txt says that I should find my modules in
> "linux/modules" after running "make modules". However, this is
> apparently not true as I see no modules directory. 
> 
> I am trying to compile a kernel with lots of modules for a machine
> without a network connection. To move the kernel, I simply copy it to
> floppy and move it over to the other machine. However, for the modules,
> is my only choice appears to be "make modules-install" then tar up
> /lib/modules/kernel-release/ and then remove the directory. Is there a 
> cleaner way to handle this?
-- 
-Steven
In a time of universal deceit, telling the truth is a revolutionary act.
			-- George Orwell
