Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262049AbUCWFws (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Mar 2004 00:52:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262052AbUCWFws
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Mar 2004 00:52:48 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:30483 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S262049AbUCWFwr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Mar 2004 00:52:47 -0500
Date: Tue, 23 Mar 2004 06:52:43 +0100
From: Willy Tarreau <willy@w.ods.org>
To: Sanjoy Mahajan <sanjoy@mrao.cam.ac.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Thinkpad 560X w/ 160MB memory (2.4.24 kernel): many segfaults
Message-ID: <20040323055243.GA1276@alpha.home.local>
References: <E1B5Y00-0006HW-00@coll.ra.phy.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1B5Y00-0006HW-00@coll.ra.phy.cam.ac.uk>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Mar 22, 2004 at 10:34:24PM +0000, Sanjoy Mahajan wrote:
> To check that it wasn't the memory module itself, I ran the BIOS
> memory test (which passed) and also memtest86+ (no errors on 4 passes,
> which was more than 2 hours of testing).

I've had similar problems as you describe on completely different machines
due to a RAM compatibility problem. It was OK for memtest86, but burnBX
(from cpuburn) could detect the problem within 8 seconds. It seems to me
that this RAM had problems with its I/O in general, possibly with back-to-back
timings, etc... memtest86 is very good at detecting defective memory cells,
but not as good at detecting I/O problems it seems.

Cheers,
Willy

