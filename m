Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263594AbTDTO4x (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Apr 2003 10:56:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263595AbTDTO4w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Apr 2003 10:56:52 -0400
Received: from siaag2ad.compuserve.com ([149.174.40.134]:52361 "EHLO
	siaag2ad.compuserve.com") by vger.kernel.org with ESMTP
	id S263594AbTDTO4w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Apr 2003 10:56:52 -0400
Date: Sun, 20 Apr 2003 11:06:20 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: Are linux-fs's drive-fault-tolerant by concept?
To: linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200304201108_MC3-1-3533-D395@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:


> Buy IDE disks in pairs use md1, and remember to continually send the
> hosed ones back to the vendor/shop (and if they keep appearing DOA to
> your local trading standards/fair trading type bodies).


  I buy three drives at a time so I have a matching spare, because AFAIC
you shouldn't be doing RAID on unmatched drives.

  Using RAID1 is especially important when using software instead
of hardware for fault-tolerance because the software is more likely to
have bugs just because of the 'culture' of hardware vs. software
developers, and the RAID5 algorithm is very hard to get right anyway,
especially in failure/rebuild mode.  Even on a hardware controller
RAID5 is still inherently less reliable.

 (...and what's all this about unreliable drives, anyway?  Every drive
I have bought since 1987 still works.)
------
 Chuck
