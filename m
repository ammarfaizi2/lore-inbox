Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264313AbUAVCgr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jan 2004 21:36:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266088AbUAVCgr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jan 2004 21:36:47 -0500
Received: from mail.shareable.org ([81.29.64.88]:8343 "EHLO mail.shareable.org")
	by vger.kernel.org with ESMTP id S264313AbUAVCgq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jan 2004 21:36:46 -0500
Date: Thu, 22 Jan 2004 02:36:09 +0000
From: Jamie Lokier <jamie@shareable.org>
To: Matthias Schniedermeyer <ms@citd.de>
Cc: Bart Samwel <bart@samwel.tk>, Timothy Miller <miller@techsource.com>,
       Valdis.Kletnieks@vt.edu,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [OT] Redundancy eliminating file systems, breaking MD5, donating money to OSDL
Message-ID: <20040122023609.GB4392@mail.shareable.org>
References: <4008480F.70206@techsource.com> <200401162037.i0GKbgWY005453@turing-police.cc.vt.edu> <4008509B.2060707@techsource.com> <200401171415.31645.bart@samwel.tk> <20040120192114.GA30755@citd.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040120192114.GA30755@citd.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthias Schniedermeyer wrote:
> *2: I had a direcory of about 1,5 Million images and "md5sum"med them to
> eliminate doubles. The Log-file, at one point, had the same md5sum as
> one of the pictures.

Something similar happened to me once.  Two different files with the
same result from md5sum.

When I ran md5sum again, it still reported the same results.

Then when I flushed the page cache and ran it again, it reported
different results.

I concluded it was a rare page cache corruption heisenbug.  Scary.

-- Jamie
