Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262120AbTDXJOZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Apr 2003 05:14:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262272AbTDXJOZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Apr 2003 05:14:25 -0400
Received: from wohnheim.fh-wedel.de ([195.37.86.122]:19335 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S262120AbTDXJOY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Apr 2003 05:14:24 -0400
Date: Thu, 24 Apr 2003 11:26:17 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: John Cherry <cherry@osdl.org>
Cc: root@chaos.analogic.com, Timothy Miller <miller@techsource.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Can one build 2.5.68 with allyesconfig?
Message-ID: <20030424092617.GC17751@wohnheim.fh-wedel.de>
References: <3EA5AABF.4090303@techsource.com> <Pine.LNX.4.53.0304221701320.17809@chaos> <1051127561.20214.20.camel@cherrypit.pdx.osdl.net> <20030423204828.GC26678@wohnheim.fh-wedel.de> <1051142471.20793.17.camel@cherrypit.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1051142471.20793.17.camel@cherrypit.pdx.osdl.net>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 April 2003 17:01:12 -0700, John Cherry wrote:
> 
> No.  I think Randy Dunlap replied earlier that he spent considerable
> time weeding out broken drivers from an allyesconfig configuration. 

Yes, it takes manual inspection of some 30 failures, each costing just
a minute or so. But the compile time between those really hurts, it
generates many context switches for my brain.

> This still did not result in a bootable image.

Which may be a good thing. 28MB would have used all my memory not too
long ago. :)

> If you want to build with allyesconfig and continue on when you run into
> errors, just use the -k (keep going) option with make.

Good idea. Maybe that can cut down the context switches.

> Feel free to hack on the compregress.sh script to produce compilation
> results that would benefit what you are doing.  It lives on the
> stability page.

Will do. Thank you!

Jörn

-- 
And spam is a useful source of entropy for /dev/random too!
-- Jasmine Strong
