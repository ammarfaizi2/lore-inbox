Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263020AbTDZUYN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Apr 2003 16:24:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263024AbTDZUYL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Apr 2003 16:24:11 -0400
Received: from wohnheim.fh-wedel.de ([195.37.86.122]:7577 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S263020AbTDZUYK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Apr 2003 16:24:10 -0400
Date: Sat, 26 Apr 2003 22:36:23 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Thunder Anklin <thunder@keepsake.ch>
Cc: "Randy.Dunlap" <randy.dunlap@verizon.net>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: missing #includes?
Message-ID: <20030426203623.GB3456@wohnheim.fh-wedel.de>
References: <20030425235119.6f337e70.randy.dunlap@verizon.net> <20030426201706.GE69349@hawkeye.luckynet.adm>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20030426201706.GE69349@hawkeye.luckynet.adm>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 26 April 2003 22:17:07 +0200, Thunder Anklin wrote:
> On Fri, Apr 25, 2003 at 11:51:19PM -0700, Randy.Dunlap wrote:
> > What's the preferred thing to do here?  I would like to see explicit
> > #includes when symbols are used.  Is that what others expect also?
> 
> It's perlable. I might do this if you want.

If you just take the current script, there is little point in a
translation. But if you could merge it sanely with
scripts/checkincludes.pl, that might be nice.

Now, how does one check all c files for all implicitly included
symbols without writing a complete c parser or generating tons of
false positives? Maybe you can play some trick with "gcc -C -E".

Jörn

-- 
To announce that there must be no criticism of the President, or that we
are to stand by the President, right or wrong, is not only unpatriotic
and servile, but is morally treasonable to the American public.
-- Theodore Roosevelt, Kansas City Star, 1918

