Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264153AbUDBTE3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Apr 2004 14:04:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264154AbUDBTE3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Apr 2004 14:04:29 -0500
Received: from fw.osdl.org ([65.172.181.6]:59788 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264153AbUDBTE1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Apr 2004 14:04:27 -0500
Message-Id: <200404021904.i32J4M215682@mail.osdl.org>
Date: Fri, 2 Apr 2004 11:04:19 -0800 (PST)
From: markw@osdl.org
Subject: Re: 2.6.5-rc3-mm4
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org
In-Reply-To: <20040401020512.0db54102.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,

I reran DBT-2 to with ext2 and ext3 (in case you were still interested)
on my 4-way Xeon system with 60+ drives:
	http://developer.osdl.org/markw/fs/dbt2_project_results.html

Aside from the from the drop you're already aware of since 2.6.3, it
looks like DBT-2 takes another smaller hit after 2.6.5-rc3-mm2.  Here's
a brief summary from the link above:

Linux 2.6.5-rc3-mm4  Metric (bigger is better)
ext2                 1570
ext3                 1528

Linux 2.6.5-rc3-mm3  Metric (bigger is better)
ext2                 1555
ext3                 1552

Linux 2.6.5-rc3-mm2  Metric (bigger is better)
ext2                 1637
ext3                 1605

Linux 2.6.3          Metric (bigger is better)
ext2                 2292
ext3                 2080


Mark
