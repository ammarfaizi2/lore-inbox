Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264228AbTDJWJ2 (for <rfc822;willy@w.ods.org>); Thu, 10 Apr 2003 18:09:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264229AbTDJWJ1 (for <rfc822;linux-kernel-outgoing>);
	Thu, 10 Apr 2003 18:09:27 -0400
Received: from [195.39.17.254] ([195.39.17.254]:8964 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id S264228AbTDJWJ0 (for <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Apr 2003 18:09:26 -0400
Date: Fri, 11 Apr 2003 11:58:52 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: 64-bit kdev_t - just for playing
Message-ID: <20030411095852.GA5064@zaurus.ucw.cz>
References: <200303311541.50200.pbadari@us.ibm.com> <Pine.LNX.4.44.0304031256550.5042-100000@serv> <20030403133725.GA14027@win.tue.nl> <Pine.LNX.4.44.0304031548090.12110-100000@serv> <b6s3tm_i2d_1@cesium.transmeta.com> <Pine.LNX.4.44.0304071742490.12110-100000@serv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0304071742490.12110-100000@serv>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> so it's easy to map to a fixed number. SCSI already has to use dynamic 
> numbers, because it wouldn't otherwise fit into a 16bit dev_t and with SAN 
> even 64bit will not be enough. This makes SCSI very annoying, when at the 
> next boot everything has a new name, because a disk was added/removed.

Ugh? 64bits not enough? I don't think so.
You could do 20/44 bits split for example...
Or allocate 60000 majors just for disks.
But I do not think you have 2^32 disks
in any SAN.

-- 
				Pavel
Written on sharp zaurus, because my Velo1 broke. If you have Velo you don't need...

