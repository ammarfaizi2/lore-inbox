Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261234AbVGYMUR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261234AbVGYMUR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Jul 2005 08:20:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261237AbVGYMUR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Jul 2005 08:20:17 -0400
Received: from outpost.ds9a.nl ([213.244.168.210]:26336 "EHLO outpost.ds9a.nl")
	by vger.kernel.org with ESMTP id S261234AbVGYMUO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Jul 2005 08:20:14 -0400
Date: Mon, 25 Jul 2005 14:20:13 +0200
From: bert hubert <bert.hubert@netherlabs.nl>
To: Sonny Rao <sonny@burdell.org>
Cc: Paul Jackson <pj@sgi.com>, rostedt@goodmis.org,
       relayfs-devel@lists.sourceforge.net, richardj_moore@uk.ibm.com,
       varap@us.ibm.com, karim@opersys.com, linux-kernel@vger.kernel.org,
       zanussi@us.ibm.com
Subject: Re: diskstat 0.1: simple tool to study io patterns via relayfs
Message-ID: <20050725122013.GA5843@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <bert.hubert@netherlabs.nl>,
	Sonny Rao <sonny@burdell.org>, Paul Jackson <pj@sgi.com>,
	rostedt@goodmis.org, relayfs-devel@lists.sourceforge.net,
	richardj_moore@uk.ibm.com, varap@us.ibm.com, karim@opersys.com,
	linux-kernel@vger.kernel.org, zanussi@us.ibm.com
References: <20050724010730.GA22104@outpost.ds9a.nl> <20050725075648.GA32238@kevlar.burdell.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050725075648.GA32238@kevlar.burdell.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 25, 2005 at 03:56:48AM -0400, Sonny Rao wrote:
> Hi, I had some trouble compiling it, I figured out that one needs
> libboost, but then I've also discovered that g++-3.4.4 and g++-4.0.1
> don't want to compile it while g++-3.3.5 works.  (FYI, all of these were
> Ubuntu versions)

Yes, you are right. I'll fix the Boost thing, but it really should compile
using all those gcc's. Would you mind sending me the errors you get with the
other compilers (privately)?

> You might want to document some of this in the README :)

This is the least of what needs fixing hehe. Thanks.

-- 
http://www.PowerDNS.com      Open source, database driven DNS Software 
http://netherlabs.nl              Open and Closed source services
