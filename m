Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263364AbTKKF2J (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Nov 2003 00:28:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263366AbTKKF2J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Nov 2003 00:28:09 -0500
Received: from zeus.kernel.org ([204.152.189.113]:4588 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S263364AbTKKF2H (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Nov 2003 00:28:07 -0500
Subject: Re: I/O issues, iowait problems, 2.4 v 2.6
From: Paul Venezia <pvenezia@jpj.net>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20031110205443.6422259f.akpm@osdl.org>
References: <1068519213.22809.81.camel@soul.jpj.net>
	 <20031110195433.4331b75e.akpm@osdl.org>
	 <1068523328.25805.97.camel@soul.jpj.net>
	 <20031110202819.7e7433a8.akpm@osdl.org>
	 <1068524657.25804.110.camel@soul.jpj.net>
	 <20031110205443.6422259f.akpm@osdl.org>
Content-Type: text/plain
Organization: 
Message-Id: <1068527615.22800.138.camel@soul.jpj.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 11 Nov 2003 00:13:35 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-11-10 at 23:54, Andrew Morton wrote:

> But.  If the workload here was a simple dd of /dev/zero onto a regular
> file then why on earth is the pagecache size not rising? 

2.6.0-test8 on a box with an AIC7899 performs exactly as expected. I'll
pull the mirror from the MPT and see what I get. 

The box with the aic7xxx is a 1P 1Ghz. I'll compile test9-bk11 on that
one just to be sure, but it looks like it may be a driver issue. I can
replicate this on another box with a 53C1030 running a mirror, so I
don't think it's specific hardware.

-Paul 

