Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264323AbTDWXtW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Apr 2003 19:49:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264324AbTDWXtW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Apr 2003 19:49:22 -0400
Received: from air-2.osdl.org ([65.172.181.6]:4271 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264323AbTDWXtU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Apr 2003 19:49:20 -0400
Subject: Re: Can one build 2.5.68 with allyesconfig?
From: John Cherry <cherry@osdl.org>
To: =?ISO-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
Cc: root@chaos.analogic.com, Timothy Miller <miller@techsource.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030423204828.GC26678@wohnheim.fh-wedel.de>
References: <3EA5AABF.4090303@techsource.com>
	 <Pine.LNX.4.53.0304221701320.17809@chaos>
	 <1051127561.20214.20.camel@cherrypit.pdx.osdl.net>
	 <20030423204828.GC26678@wohnheim.fh-wedel.de>
Content-Type: text/plain; charset=ISO-8859-1
Organization: 
Message-Id: <1051142471.20793.17.camel@cherrypit.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 23 Apr 2003 17:01:12 -0700
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-04-23 at 13:48, Jörn Engel wrote:
> On Wed, 23 April 2003 12:52:41 -0700, John Cherry wrote:
> > 
> > As mentioned in other mail, compile statistics for the latest 2.5
> > kernels are at: http://www.osdl.org/archive/cherry/stability/
> > 
> > However, these statistics are based on defconfig and allmodconfig builds
> > (not allyesconfig).  The allmodconfig build contains the riscom8 errors
> > that you have observed as well as most other warnings/errors you would
> > find in an allyesconfig build.
> 
> Do you have any form of automation when dealing with breaking drivers?
> If I could reduce the necessary time for creating a working
> allyesconfig, that would be quite nice.

No.  I think Randy Dunlap replied earlier that he spent considerable
time weeding out broken drivers from an allyesconfig configuration. 
This still did not result in a bootable image.

If you want to build with allyesconfig and continue on when you run into
errors, just use the -k (keep going) option with make.

> 
> Allyesconfig has a couple of advantages. The analysis of object files
> is must simpler with just vmlinux to worry about. And some errors
> don't show up until link time, not sure if you can catch all of them
> with allmodconfig.

Agreed.

Feel free to hack on the compregress.sh script to produce compilation
results that would benefit what you are doing.  It lives on the
stability page.

John

