Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261748AbULUMlr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261748AbULUMlr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Dec 2004 07:41:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261749AbULUMlr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Dec 2004 07:41:47 -0500
Received: from egg.hpc2n.umu.se ([130.239.45.244]:43700 "EHLO egg.hpc2n.umu.se")
	by vger.kernel.org with ESMTP id S261748AbULUMlJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Dec 2004 07:41:09 -0500
Date: Tue, 21 Dec 2004 13:41:04 +0100
To: linux-kernel@vger.kernel.org
Subject: Question regarding stack creation
Message-ID: <20041221124104.GH4401@hpc2n.umu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040722i
From: Ake.Sandgren@hpc2n.umu.se (Ake)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!
Are all stacks created with alloc_thread_info?
(Except init_stack and the hard/softirq_stacks)
This is on i386 and 2.6.10-rc1

I am currently having the problem that sometimes when the kernel trips
into kgdb the stackpointer is pointing to memory that wasn't aquired
with alloc_thread_info.

-- 
Ake Sandgren, HPC2N, Umea University, S-90187 Umea, Sweden
Internet: ake@hpc2n.umu.se	Phone: +46 90 7866134 Fax: +46 90 7866126
Mobile: +46 70 7716134 WWW: http://www.hpc2n.umu.se
