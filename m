Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262134AbUKVPPl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262134AbUKVPPl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 10:15:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262127AbUKVPPU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 10:15:20 -0500
Received: from siaag2ae.compuserve.com ([149.174.40.135]:22725 "EHLO
	siaag2ae.compuserve.com") by vger.kernel.org with ESMTP
	id S262144AbUKVPMl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 10:12:41 -0500
Date: Mon, 22 Nov 2004 10:10:59 -0500
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: sys_ioperm() allows port offsets > 0x3ff
To: linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200411221012_MC3-1-8F2C-FF44@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Is $SUBJECT a bug?  I can see the IO bitmap size was increased in June.

The latest ltp test suite expects offsets > 0x3ff to fail.


--Chuck Ebbert  20-Nov-04  23:52:44
