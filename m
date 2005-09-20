Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965068AbVITTDj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965068AbVITTDj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Sep 2005 15:03:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965083AbVITTDj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Sep 2005 15:03:39 -0400
Received: from mail-in-07.arcor-online.net ([151.189.21.47]:54249 "EHLO
	mail-in-07.arcor-online.net") by vger.kernel.org with ESMTP
	id S965068AbVITTDi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Sep 2005 15:03:38 -0400
Date: Tue, 20 Sep 2005 21:03:33 +0200 (CEST)
From: Bodo Eggert <7eggert@gmx.de>
To: Valdis.Kletnieks@vt.edu
cc: 7eggert@gmx.de, Keith Owens <kaos@ocs.com.au>,
       Ben Dooks <ben-linux@fluff.org>, linux-kernel@vger.kernel.org,
       patch-out@fluff.rog
Subject: Re: [PATCH] scripts - use $OBJDUMP to get correct objdump (cross
 compile)
In-Reply-To: <200509201843.j8KIhadu020970@turing-police.cc.vt.edu>
Message-ID: <Pine.LNX.4.58.0509202100460.4568@be1.lrz>
References: <4OB3R-5gu-13@gated-at.bofh.it> <4OLPC-3NQ-19@gated-at.bofh.it>
            <E1EHlOt-00012f-Au@be1.lrz> <200509201843.j8KIhadu020970@turing-police.cc.vt.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-be10.7eggert.dyndns.org-MailScanner-Information: See www.mailscanner.info for information
X-be10.7eggert.dyndns.org-MailScanner: Found to be clean
X-be10.7eggert.dyndns.org-MailScanner-From: 7eggert@web.de
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Sep 2005 Valdis.Kletnieks@vt.edu wrote:
> On Tue, 20 Sep 2005 18:55:22 +0200, Bodo Eggert said:

> > Having a space as the option delimiter will break if the path to objdump
> > contains a space. Therefore you'll need to use an array.
> 
> No. You need to draw the line somewhere.  You let them have a space in the
> path, the next thing you know the'll be back asking why a UTF-8 encoded
> non-breaking-white-space in the path doesn't work. :)

Anything not containing '\0' SHOULD work on posix systems. Anything else 
is a programming error.

-- 
I always tell customers/clients the same thing:
   "Good, Fast, Cheap.  You can pick two."
	-- randem in <slrna09rui.g43.root@jade.randemmedia.com>
