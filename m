Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264047AbUDBN6V (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Apr 2004 08:58:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264049AbUDBN6V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Apr 2004 08:58:21 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.104]:11992 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S264047AbUDBN6A (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Apr 2004 08:58:00 -0500
Date: Sat, 3 Apr 2004 01:00:17 +0530
From: Suparna Bhattacharya <suparna@in.ibm.com>
To: linux-kernel@vger.kernel.org
Subject: Fw: AIO patches reworked against radix-tree-writeback changes
Message-ID: <20040402193017.GA4904@in.ibm.com>
Reply-To: suparna@in.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

----- Forwarded message from Suparna Bhattacharya <suparna@in.ibm.com> -----

Date: Sat, 3 Apr 2004 00:59:37 +0530
From: Suparna Bhattacharya <suparna@in.ibm.com>
To: linux-aio@kvack.org, akpm@osdl.org
Subject: AIO patches reworked against radix-tree-writeback changes
Reply-To: suparna@in.ibm.com


I just uploaded an update to the AIO patchset against the
-mm tree (2.6.5-rc3-mm4):
www.kernel.org/pub/linux/kernel/people/suparna/aio/265rc3mm4

This includes a rework of the concurrent O_SYNC speedup and 
AIO O_SYNC support code against the recent tagged radix-tree 
writeback changes in -mm, and a few associated cleanups of 
the fsaio write path. Feedback from testing of this functionality 
would be very welcome.

Also included is an aio-poll patch from Chris Mason, 
based on the retry model, and an aio-context-switch patch
again from Chris Mason that helps brings down the number
of context switches seen with pipetest to a reasonable
level.

Regards
Suparna

-- 
Suparna Bhattacharya (suparna@in.ibm.com)
Linux Technology Center
IBM Software Lab, India


----- End forwarded message -----

-- 
Suparna Bhattacharya (suparna@in.ibm.com)
Linux Technology Center
IBM Software Lab, India

