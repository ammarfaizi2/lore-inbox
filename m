Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263343AbTDWJ3B (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Apr 2003 05:29:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263348AbTDWJ3B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Apr 2003 05:29:01 -0400
Received: from siaab1ab.compuserve.com ([149.174.40.2]:20615 "EHLO
	siaab1ab.compuserve.com") by vger.kernel.org with ESMTP
	id S263343AbTDWJ3A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Apr 2003 05:29:00 -0400
Date: Wed, 23 Apr 2003 05:36:22 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: [2.5] Why does nbd register 128 disks when it loads?
To: linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200304230540_MC3-1-3599-7FD1@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


 Using 2.5.68-ce2, nbd built-in but never used:

# find /sys -type d | wc -l
    423
# find /sys -type d | grep nbd | wc -l
    256
# find /sys -type d | grep nbd | grep iosched | wc -l
    128


------
 Chuck
