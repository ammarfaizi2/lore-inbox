Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261889AbTIPOfz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Sep 2003 10:35:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261901AbTIPOfz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Sep 2003 10:35:55 -0400
Received: from math.ut.ee ([193.40.5.125]:9418 "EHLO math.ut.ee")
	by vger.kernel.org with ESMTP id S261889AbTIPOfv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Sep 2003 10:35:51 -0400
Date: Tue, 16 Sep 2003 17:35:49 +0300 (EEST)
From: Meelis Roos <mroos@linux.ee>
To: linux-kernel@vger.kernel.org
Subject: df hangs on nfs automounter in 2.6.0-current
Message-ID: <Pine.GSO.4.44.0309161732480.19310-100000@math.ut.ee>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Current 2.6.0 (2.6.0-test5+BK as of 16.09) hangs on df when
the am_utils automounter is in use. It displays hda* partitions and next
by mountpoint list is amd but then df hangs, wchan is rpc_execu*

dmesg only tells
nfs warning: mount version older than kernel
like it always does with current 2.6 kernels for me.

x86, debian unstable.

-- 
Meelis Roos (mroos@linux.ee)

