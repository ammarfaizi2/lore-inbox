Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263526AbTDCTjQ 
	(for <rfc822;willy@w.ods.org>); Thu, 3 Apr 2003 14:39:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id S263525AbTDCTjP 
	(for <rfc822;linux-kernel-outgoing>); Thu, 3 Apr 2003 14:39:15 -0500
Received: from ns1.scripps.edu ([192.42.82.59]:38328 "EHLO ns1.scripps.edu")
	by vger.kernel.org with ESMTP id S263524AbTDCTiQ 
	(for <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Apr 2003 14:38:16 -0500
Date: Thu, 3 Apr 2003 11:49:42 -0800 (PST)
From: Andy Arvai <arvai@scripps.edu>
Message-Id: <200304031949.LAA28555@astra.scripps.edu>
To: linux-raid@vger.kernel.org
Subject: Re: RAID 5 performance problems
Cc: linux-kernel@vger.kernel.org
X-Sun-Charset: US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Shouldn't /proc/mdstat have [UUUUU] instead of [_UUUU]? Perhaps
this is running in degraded mode. Also, you have 'algorithm 0',
whereas my raid5 has 'algorithm 2', which is the left-symmetric
parity algorithm.

Andy 

> cat /proc/mdstat gives: 
> 
> Personalities : [raid0] [raid5] 
> read_ahead 1024 sectors
> md0 : active raid5 hdk1[4] hdi1[3] hdg1[2] hde1[1] hdc1[0]
> 	468872704 blocks level 5, 128k chunk, algorithm 0 [5/5] [_UUUU]
> unused devices: <none>



