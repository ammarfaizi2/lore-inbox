Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262434AbUDYUgw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262434AbUDYUgw (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Apr 2004 16:36:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262981AbUDYUgw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Apr 2004 16:36:52 -0400
Received: from uni03du.unity.ncsu.edu ([152.1.13.103]:62851 "EHLO
	uni03du.unity.ncsu.edu") by vger.kernel.org with ESMTP
	id S262434AbUDYUgv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Apr 2004 16:36:51 -0400
From: jlnance@unity.ncsu.edu
Date: Sun, 25 Apr 2004 16:36:50 -0400
To: linux-kernel@vger.kernel.org
Subject: Need hack to test short socket I/O
Message-ID: <20040425203650.GA14657@ncsu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello All,
    I would like to check to make sure a program can handle I/O on sockets
which do not accept/return as much data as the program tries to
send/receive.  It is difficult to test this since it does not happen
frequently.  I would like to hack the kernel somehow so that socket I/O
happens either 1 byte at a time or perhaps (n+1)/2 bytes at a time, where
n is the number of requested bytes.  Does anyone know a simple way to do
this?

Thanks,

Jim
