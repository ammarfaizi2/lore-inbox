Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263204AbTDNOXl (for <rfc822;willy@w.ods.org>); Mon, 14 Apr 2003 10:23:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263296AbTDNOXk (for <rfc822;linux-kernel-outgoing>);
	Mon, 14 Apr 2003 10:23:40 -0400
Received: from [196.41.29.142] ([196.41.29.142]:43258 "EHLO
	workshop.saharact.lan") by vger.kernel.org with ESMTP
	id S263204AbTDNOXk (for <rfc822;linux-kernel@vger.kernel.org>); Mon, 14 Apr 2003 10:23:40 -0400
Subject: Re: Oops: ptrace fix buggy
From: Martin Schlemmer <azarah@gentoo.org>
To: =?ISO-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
Cc: James Bourne <jbourne@hardrock.org>, Ken Brownfield <brownfld@irridia.com>,
       Marc-Christian Petersen <m.c.p@wolk-project.de>,
       KML <linux-kernel@vger.kernel.org>
In-Reply-To: <20030414134603.GB10347@wohnheim.fh-wedel.de>
References: <200304121154.32997.m.c.p@wolk-project.de>
	 <Pine.LNX.4.44.0304140713510.22450-100000@cafe.hardrock.org>
	 <20030414134603.GB10347@wohnheim.fh-wedel.de>
Content-Type: text/plain; charset=ISO-8859-1
Organization: 
Message-Id: <1050330667.4059.27.camel@workshop.saharact.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3- 
Date: 14 Apr 2003 16:31:08 +0200
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-04-14 at 15:46, Jörn Engel wrote:

> Privately, I have introduced a variable FIXLEVEL for this. The
> resulting kernel version is 2.4.20.2 instead of 2.4.20-uv2, which imo
> is more suiting for a fixed stable kernel.
> 

This is not a good idea ... especially if its a box that you
compile a lot of software on.  Reason is that everything expects
it to be MAJ.MIN.MIC  ... If you add now another version, then
things start to break.  A good example is mozilla ...


-- 
Martin Schlemmer


