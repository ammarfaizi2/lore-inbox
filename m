Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269190AbUIYCpU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269190AbUIYCpU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Sep 2004 22:45:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269187AbUIYCpU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Sep 2004 22:45:20 -0400
Received: from holomorphy.com ([207.189.100.168]:33764 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S269190AbUIYCpR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Sep 2004 22:45:17 -0400
Date: Fri, 24 Sep 2004 19:45:13 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [sched.h 0/8] sched.h header cleanups vs. 2.6.9-rc2-mm3
Message-ID: <20040925024513.GL9106@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I split off the most easily mergeable parts of some sched.h header
cleanups I wrote that better than halved the size of sched.h. In
particular, these are the parts that don't require large sweeps,
uninlining, or introducing new headers. Compiletested on x86-64.


-- wli
