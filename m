Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263370AbTKKGPW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Nov 2003 01:15:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264198AbTKKGPW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Nov 2003 01:15:22 -0500
Received: from nat-68-172-17-106.ne.rr.com ([68.172.17.106]:44537 "EHLO
	trip.jpj.net") by vger.kernel.org with ESMTP id S263370AbTKKGPU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Nov 2003 01:15:20 -0500
Subject: Re: I/O issues, iowait problems, 2.4 v 2.6
From: Paul Venezia <pvenezia@jpj.net>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20031110215049.58a1c2d8.akpm@osdl.org>
References: <1068519213.22809.81.camel@soul.jpj.net>
	 <20031110195433.4331b75e.akpm@osdl.org>
	 <1068523328.25805.97.camel@soul.jpj.net>
	 <20031110202819.7e7433a8.akpm@osdl.org>
	 <1068524657.25804.110.camel@soul.jpj.net>
	 <20031110205443.6422259f.akpm@osdl.org>
	 <1068528589.22809.153.camel@soul.jpj.net>
	 <20031110215049.58a1c2d8.akpm@osdl.org>
Content-Type: text/plain
Organization: 
Message-Id: <1068530673.25805.225.camel@soul.jpj.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 11 Nov 2003 01:04:33 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-11-11 at 00:50, Andrew Morton wrote:
> 
> Could you please do:
> 
> 	mkdir /sys
> 	mount none /sys -t sysfs
> 	cd /sys/block/sdXX/queue
> 	echo 512 > nr_requests
> 
> and retry the RAID setup?

No change.

> Beyond that, dunno.  We'll need to hunt down the people who worked on that
> driver.

Okie, thanks for the help. I should be able to rerun these tests later
if the drivers get tweaked.

-Paul

