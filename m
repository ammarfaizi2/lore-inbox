Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264309AbTDOFwr (for <rfc822;willy@w.ods.org>); Tue, 15 Apr 2003 01:52:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264311AbTDOFwr (for <rfc822;linux-kernel-outgoing>);
	Tue, 15 Apr 2003 01:52:47 -0400
Received: from [196.41.29.142] ([196.41.29.142]:41724 "EHLO
	workshop.saharact.lan") by vger.kernel.org with ESMTP
	id S264309AbTDOFwq (for <rfc822;linux-kernel@vger.kernel.org>); Tue, 15 Apr 2003 01:52:46 -0400
Subject: Re: Oops: ptrace fix buggy
From: Martin Schlemmer <azarah@gentoo.org>
To: =?ISO-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
Cc: James Bourne <jbourne@hardrock.org>, Ken Brownfield <brownfld@irridia.com>,
       Marc-Christian Petersen <m.c.p@wolk-project.de>,
       KML <linux-kernel@vger.kernel.org>
In-Reply-To: <20030414185806.GA12740@wohnheim.fh-wedel.de>
References: <200304121154.32997.m.c.p@wolk-project.de>
	 <Pine.LNX.4.44.0304140713510.22450-100000@cafe.hardrock.org>
	 <20030414134603.GB10347@wohnheim.fh-wedel.de>
	 <1050330667.4059.27.camel@workshop.saharact.lan>
	 <20030414144709.GE10347@wohnheim.fh-wedel.de>
	 <1050343825.4757.17.camel@nosferatu.lan>
	 <20030414185806.GA12740@wohnheim.fh-wedel.de>
Content-Type: text/plain; charset=ISO-8859-1
Organization: 
Message-Id: <1050386416.4061.31.camel@workshop.saharact.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3- 
Date: 15 Apr 2003 08:00:17 +0200
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-04-14 at 20:58, Jörn Engel wrote:

> So basically, neither the existing EXTRAVERSION nor my new FIXLEVEL
> are checked. Any code could potentially break with -ac1 to -ac2 or
> with .1 to .2.
> 
> Did anyone experience such problems with -ac already? There are far
> more changes in -ac than there are in your patch.
> 

No, -ac[12] do not break.  Its only when you have something like
2.4.20.1 (ie. three '.' s).  


-- 
Martin Schlemmer


