Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751010AbWCaRVo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751010AbWCaRVo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Mar 2006 12:21:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751022AbWCaRVo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Mar 2006 12:21:44 -0500
Received: from xenotime.net ([66.160.160.81]:945 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751008AbWCaRVo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Mar 2006 12:21:44 -0500
Date: Fri, 31 Mar 2006 09:21:43 -0800 (PST)
From: "Randy.Dunlap" <rdunlap@xenotime.net>
X-X-Sender: rddunlap@shark.he.net
To: linux-kernel@vger.kernel.org
Subject: about __ARCH_WANT_SYS_GETHOSTNAME
Message-ID: <Pine.LNX.4.58.0603310911260.6105@shark.he.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

What was/is the purpose of __ARCH_WANT_SYS_GETHOSTNAME?
and why do a few arches not #define it?

If it is not #defined, should those arches supply their own
sys_gethostname() function?

21 arches #define __ARCH_WANT_SYS_GETHOSTNAME.
A few don't:  frv, ia64, & xtensa.
But all arches (except for um) #define __NR_gethostname.

Is __ARCH_WANT_SYS_GETHOSTNAME just crufty and doesn't matter
any more?

Thanks,
-- 
~Randy
