Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261366AbUKGF6Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261366AbUKGF6Y (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Nov 2004 00:58:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261542AbUKGF6Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Nov 2004 00:58:24 -0500
Received: from siaag2af.compuserve.com ([149.174.40.136]:31974 "EHLO
	siaag2af.compuserve.com") by vger.kernel.org with ESMTP
	id S261366AbUKGF6N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Nov 2004 00:58:13 -0500
Date: Sun, 7 Nov 2004 00:55:21 -0500
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: deadlock with 2.6.9
To: Chris Stromsoe <cbs@cts.ucla.edu>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200411070058_MC3-1-8E27-AAEF@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Stromsoe wrote:

> I had a third lockup, this time not related to burning a dvd.  As before, 
> the bulk of the processes that were hung were cron

 Why so many cron processes?  Is this normal on your system, or does it
look like cron keeps spawning processes because it gets no response on the
sockets?

> The box is P3 SMP

 Can you try a uniprocessor kernel?

> syslog logs to a stripe of two mirrors, built with mdadm.

 Get a real RAID controller (3Ware, not some crappy pseudo-RAID junk.)  They are
much more reliable than software RAID.


--Chuck Ebbert  07-Nov-04  00:28:44
