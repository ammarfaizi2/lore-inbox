Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266171AbUBQN1G (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Feb 2004 08:27:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266176AbUBQN1G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Feb 2004 08:27:06 -0500
Received: from jurand.ds.pg.gda.pl ([153.19.208.2]:58313 "EHLO
	jurand.ds.pg.gda.pl") by vger.kernel.org with ESMTP id S266171AbUBQN1B
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Feb 2004 08:27:01 -0500
Date: Tue, 17 Feb 2004 14:26:54 +0100 (CET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Herbert Poetzl <herbert@13thfloor.at>
Cc: linux-kernel@vger.kernel.org, linux-gcc@vger.kernel.org,
       Ralf Baechle <ralf@linux-mips.org>
Subject: Re: Kernel Cross Compiling
In-Reply-To: <20040213205743.GA30245@MAIL.13thfloor.at>
Message-ID: <Pine.LNX.4.55.0402171421080.8356@jurand.ds.pg.gda.pl>
References: <20040213205743.GA30245@MAIL.13thfloor.at>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 Feb 2004, Herbert Poetzl wrote:

>    mips/mips64:
> 	seem to use the 'obsoleted' -mcpu= option
> 	which results in a cc1: error: invalid option 
> 	`cpu=<cpu-here>'

 FYI, this has been addressed in the MIPS CVS tree not so long ago, so
changes are not merged to the mainline yet.  Actually, even the CVS
version isn't fully complete yet -- a small update is still pending
approval.  The problem isn't related to doing a build with cross-tools --
it happens when building natively as well.

 Otherwise, cross-compilation is the usual way of doing builds for MIPS
and it works in general.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
