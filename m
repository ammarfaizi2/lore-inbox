Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161053AbWGMX6l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161053AbWGMX6l (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 19:58:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161061AbWGMX6l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 19:58:41 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:62649 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1161053AbWGMX6k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 19:58:40 -0400
Subject: Kernel headers git tree
From: David Woodhouse <dwmw2@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Date: Fri, 14 Jul 2006 00:59:09 +0100
Message-Id: <1152835150.31372.23.camel@shinybook.infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.6.dwmw2.1) 
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At http://git.kernel.org/git/?p=linux/kernel/git/dwmw2/kernel-headers.git
there's a git tree which contains the sanitised exported headers for all
architectures -- basically the result of 'make headers_install'.

It tracks Linus' kernel tree, by means of some evil scripts.¹

Only commits in Linus' tree which actually affect the exported result
should have an equivalent commit in the above tree, which means that any
changes which affect userspace should be clearly visible for review.

-- 
dwmw2

¹ http://david.woodhou.se/extract-khdrs-git.sh and
  http://david.woodhou.se/extract-khdrs-stage2.sh for the stout of stomach

