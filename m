Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263177AbTDGBZm (for <rfc822;willy@w.ods.org>); Sun, 6 Apr 2003 21:25:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263179AbTDGBZm (for <rfc822;linux-kernel-outgoing>); Sun, 6 Apr 2003 21:25:42 -0400
Received: from siaag2ab.compuserve.com ([149.174.40.132]:16040 "EHLO
	siaag2ab.compuserve.com") by vger.kernel.org with ESMTP
	id S263177AbTDGBZl (for <rfc822;linux-kernel@vger.kernel.org>); Sun, 6 Apr 2003 21:25:41 -0400
Date: Sun, 6 Apr 2003 21:34:08 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Wanted: a limit on kernel log buffer size
To: linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200304062137_MC3-1-3346-A97E@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 Some people (who will mercifully go unnamed) just will _not_
read the documentation, and set the kernel log buffer shift
to 31 on a 256MB machine.  This attempt to allocate 2GB of memory
for the buffer results in an unbootable kernel.

 Suggestions?

--
 Chuck
 I am not a number!
