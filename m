Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264274AbTDWUgo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Apr 2003 16:36:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264275AbTDWUgo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Apr 2003 16:36:44 -0400
Received: from wohnheim.fh-wedel.de ([195.37.86.122]:25769 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S264274AbTDWUgm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Apr 2003 16:36:42 -0400
Date: Wed, 23 Apr 2003 22:48:28 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: John Cherry <cherry@osdl.org>
Cc: root@chaos.analogic.com, Timothy Miller <miller@techsource.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Can one build 2.5.68 with allyesconfig?
Message-ID: <20030423204828.GC26678@wohnheim.fh-wedel.de>
References: <3EA5AABF.4090303@techsource.com> <Pine.LNX.4.53.0304221701320.17809@chaos> <1051127561.20214.20.camel@cherrypit.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1051127561.20214.20.camel@cherrypit.pdx.osdl.net>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 April 2003 12:52:41 -0700, John Cherry wrote:
> 
> As mentioned in other mail, compile statistics for the latest 2.5
> kernels are at: http://www.osdl.org/archive/cherry/stability/
> 
> However, these statistics are based on defconfig and allmodconfig builds
> (not allyesconfig).  The allmodconfig build contains the riscom8 errors
> that you have observed as well as most other warnings/errors you would
> find in an allyesconfig build.

Do you have any form of automation when dealing with breaking drivers?
If I could reduce the necessary time for creating a working
allyesconfig, that would be quite nice.

Allyesconfig has a couple of advantages. The analysis of object files
is must simpler with just vmlinux to worry about. And some errors
don't show up until link time, not sure if you can catch all of them
with allmodconfig.

Jörn

-- 
If you're willing to restrict the flexibility of your approach,
you can almost always do something better.
-- John Carmack
