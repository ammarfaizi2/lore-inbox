Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263478AbTDCUQz 
	(for <rfc822;willy@w.ods.org>); Thu, 3 Apr 2003 15:16:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id S263472AbTDCUQn 
	(for <rfc822;linux-kernel-outgoing>); Thu, 3 Apr 2003 15:16:43 -0500
Received: from windsormachine.com ([206.48.122.28]:31493 "EHLO
	router.windsormachine.com") by vger.kernel.org with ESMTP
	id S263418AbTDCUOS 
	(for <rfc822;linux-kernel@vger.kernel.org>); Thu, 3 Apr 2003 15:14:18 -0500
Date: Thu, 3 Apr 2003 15:25:43 -0500 (EST)
From: Mike Dresser <mdresser_l@windsormachine.com>
To: Andy Arvai <arvai@scripps.edu>
cc: <linux-raid@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: RAID 5 performance problems
In-Reply-To: <200304031949.LAA28555@astra.scripps.edu>
Message-ID: <Pine.LNX.4.33.0304031525060.27745-100000@router.windsormachine.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Apr 2003, Andy Arvai wrote:

> Shouldn't /proc/mdstat have [UUUUU] instead of [_UUUU]? Perhaps
> this is running in degraded mode. Also, you have 'algorithm 0',
> whereas my raid5 has 'algorithm 2', which is the left-symmetric
> parity algorithm.

he's running it in degraded mode intentionally, the setup is so broken
that the performance loss is masked by the rest of the system.


