Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264875AbUEKQil@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264875AbUEKQil (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 May 2004 12:38:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264833AbUEKQh5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 May 2004 12:37:57 -0400
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:5504 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S264830AbUEKQdE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 May 2004 12:33:04 -0400
Date: Tue, 11 May 2004 17:39:05 +0100
From: John Bradford <john@grabjohn.com>
Message-Id: <200405111639.i4BGd5jN000129@81-2-122-30.bradfords.org.uk>
To: Valdis.Kletnieks@vt.edu
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200405111554.i4BFs4hU015073@turing-police.cc.vt.edu>
References: <fa.n6pggn5.84en31@ifi.uio.no>
 <40A0EFC0.1040609@sgi.com>
 <200405111552.i4BFqFMN000112@81-2-122-30.bradfords.org.uk>
 <200405111554.i4BFs4hU015073@turing-police.cc.vt.edu>
Subject: Re: dynamic allocation of swap disk space 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quote from Valdis.Kletnieks@vt.edu:
> 
> On Tue, 11 May 2004 16:52:15 BST, John Bradford said:
> 
> > Imagine a system with limited physical RAM, and limited swap space, running a
> > process which causes a lot of filesystem activity on the same physical disk
> > as is being used for swap.  If the total RAM, both physical and swap is almost
> > completely full, increasing the swap space may allow some data from physical
> > RAM to be swapped out, in favour of caching filesystem data from the disk.
> 
> Possible, but wouldn't that imply that the value of /proc/sys/vm/swappiness
> is very mis-set and causing a too-high estimate of the working set size?

Yes - to be honest, I was thinking of very low spec systems, where swap may
well be less than or equal to physical RAM size.

John.
