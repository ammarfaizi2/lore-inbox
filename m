Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263655AbUDQFfj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Apr 2004 01:35:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263674AbUDQFfj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Apr 2004 01:35:39 -0400
Received: from holomorphy.com ([207.189.100.168]:29833 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S263655AbUDQFfj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Apr 2004 01:35:39 -0400
Date: Fri, 16 Apr 2004 22:35:38 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: linux-kernel@vger.kernel.org
Subject: [0/5] stack bounds checking
Message-ID: <20040417053538.GA20534@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The stack is now shared with struct thread_info on most arches, not
task_t. This patch series attempts to sweep up the remaining arches in
need of updates. This mostly affects get_wchan() and stack usage debug.


-- wli
