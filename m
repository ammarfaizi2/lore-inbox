Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262569AbUCONrM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Mar 2004 08:47:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262577AbUCONrM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Mar 2004 08:47:12 -0500
Received: from math.ut.ee ([193.40.5.125]:4091 "EHLO math.ut.ee")
	by vger.kernel.org with ESMTP id S262569AbUCONqy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Mar 2004 08:46:54 -0500
Date: Mon, 15 Mar 2004 15:46:51 +0200 (EET)
From: Meelis Roos <mroos@linux.ee>
To: linux-kernel@vger.kernel.org
Subject: Sound core broken on sparc64 (2.6.4+bk)
Message-ID: <Pine.GSO.4.44.0403151545330.16052-100000@math.ut.ee>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is today's (20040315) BK snapshot. Sound core is broken on sparc64:

sound/core/memalloc.c: In function `snd_mem_proc_read':
sound/core/memalloc.c:793: error: `sbus' undeclared (first use in this function)
sound/core/memalloc.c:793: error: (Each undeclared identifier is reported only once
sound/core/memalloc.c:793: error: for each function it appears in.)
sound/core/memalloc.c:792: warning: unused variable `sdev'

-- 
Meelis Roos (mroos@linux.ee)

