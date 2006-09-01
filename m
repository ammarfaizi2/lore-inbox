Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751408AbWIAMsz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751408AbWIAMsz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Sep 2006 08:48:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751289AbWIAMsz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Sep 2006 08:48:55 -0400
Received: from mailer.gwdg.de ([134.76.10.26]:43144 "EHLO mailer.gwdg.de")
	by vger.kernel.org with ESMTP id S1751408AbWIAMsy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Sep 2006 08:48:54 -0400
Date: Fri, 1 Sep 2006 14:44:51 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Josef Sipek <jsipek@cs.sunysb.edu>
cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       hch@infradead.org, akpm@osdl.org, viro@ftp.linux.org.uk
Subject: Re: [PATCH 02/22][RFC] Unionfs: Kconfig and Makefile
In-Reply-To: <20060901013917.GC5788@fsl.cs.sunysb.edu>
Message-ID: <Pine.LNX.4.61.0609011444050.15283@yvahk01.tjqt.qr>
References: <20060901013512.GA5788@fsl.cs.sunysb.edu> <20060901013917.GC5788@fsl.cs.sunysb.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>+config UNION_FS
>+	tristate "Stackable namespace unification file system"
>+	depends on EXPERIMENTAL
>+	help
>+	  Unionfs is a stackable unification file system, which appears to
>+	  merge the contents of several directories (branches), while keeping
>+	  their physical content separate.

Is there any CodingStyle for Kconfig files? Like what indentation to use (4 vs
8) (tab vs space) and/or whether to use "help" or "---help---"



Jan Engelhardt
-- 
