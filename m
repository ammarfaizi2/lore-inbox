Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262084AbTIEE2l (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Sep 2003 00:28:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262102AbTIEE2l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Sep 2003 00:28:41 -0400
Received: from grouse.mail.pas.earthlink.net ([207.217.120.116]:10997 "EHLO
	grouse.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id S262084AbTIEE2l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Sep 2003 00:28:41 -0400
Date: Fri, 5 Sep 2003 00:32:30 -0400
To: akpm@osdl.org, piggin@cyberone.com.au
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test4-mm5 dbench stuck in D state
Message-ID: <20030905043230.GA24843@rushmore>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
From: rwhron@earthlink.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> revert

> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.0-test4/2.6.0-test4-mm5/broken-out/elv-insertion-fix.patch

> That patch is in Linus's tree now

Backing out elv-insertion-fix.patch does the trick.
The machine has run 9 iterations of dbench and she's
still happy.

--
Randy Hron
http://home.earthlink.net/~rwhron/kernel/bigbox.html

