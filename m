Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265259AbTLFWKF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Dec 2003 17:10:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265262AbTLFWKF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Dec 2003 17:10:05 -0500
Received: from gaia.cela.pl ([213.134.162.11]:34062 "EHLO gaia.cela.pl")
	by vger.kernel.org with ESMTP id S265259AbTLFWKA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Dec 2003 17:10:00 -0500
Date: Sat, 6 Dec 2003 23:07:45 +0100 (CET)
From: Maciej Zenczykowski <maze@cela.pl>
To: Pat LaVarre <p.lavarre@ieee.org>
cc: valdis.kletnieks@vt.edu, <linux-fsdevel@vger.kernel.org>,
       <linux-kernel@vger.kernel.org>, <willy@debian.org>, <ezk@cs.sunysb.edu>,
       <joern@wohnheim.fh-wedel.de>, <phillip@lougher.demon.co.uk>,
       <kbiswas@neoscale.com>
Subject: Re: partially encrypted filesystem
In-Reply-To: <39B8D78E-2826-11D8-8D5E-000393A22C62@ieee.org>
Message-ID: <Pine.LNX.4.44.0312062301310.4130-100000@gaia.cela.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>  > some other method ....
>  > less likely to cause massive disk fragmentation.
> 
> Such as?

If I knew how to do this correctly I'd be earning a lot of money... :)  
Truthfully this is work for at least a good two weeks of designing, likely
much, much more... to just determine the very basics.  Even assuming you
already have good fast compressors/decompressors which run in neglible
time and achieve the best compression ratio on the market - it's still
very, very non-trivial to make a compressed random-access read-write
filesystem out of that.  Some files should be compressed max, some only
slightly, some not at all, this should all be user selectable on a per
file (or even per file section) basis and the default should allow the
file-system to learn which files to compress and how-badly... etc. etc.  
The file-system has to auto-defragment and it has to minimize 
fragmentation in the first place.

Cheers,
MaZe.


