Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261825AbTLWQZY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Dec 2003 11:25:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261837AbTLWQZY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Dec 2003 11:25:24 -0500
Received: from users.linvision.com ([62.58.92.114]:43155 "HELO bitwizard.nl")
	by vger.kernel.org with SMTP id S261825AbTLWQZR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Dec 2003 11:25:17 -0500
Date: Tue, 23 Dec 2003 17:25:15 +0100
From: Erik Mouw <erik@harddisk-recovery.com>
To: Ben Srour <srour@cs.wisc.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: compiling modules after 2.4.* --> 2.6.0 upgrade
Message-ID: <20031223162515.GD26750@bitwizard.nl>
References: <200312230757.40960.andrew@walrond.org> <Pine.LNX.4.44.0312230211500.28609-100000@data.upl.cs.wisc.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0312230211500.28609-100000@data.upl.cs.wisc.edu>
User-Agent: Mutt/1.3.28i
Organization: Harddisk-recovery.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 23, 2003 at 02:20:06AM -0600, Ben Srour wrote:
> I'm attempting to port a module I wrote for the 2.4 series to 2.6 but I
> get the following error when I try and insmod:
> 
> 	root@dimension# /usr/sbin/insmod gpstest.o
> 	insmod: error inserting 'gpstest.o': -1 Invalid module format
> 	root@dimension#

You want the .ko file, not the .o file. See also:

- http://www.linux.org.uk/~davej/docs/post-halloween-2.6.txt
- http://lwn.net/Articles/driver-porting/


Erik

-- 
+-- Erik Mouw -- www.harddisk-recovery.com -- +31 70 370 12 90 --
| Lab address: Delftechpark 26, 2628 XH, Delft, The Netherlands
