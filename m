Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266016AbUGZVFB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266016AbUGZVFB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jul 2004 17:05:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266116AbUGZVBM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jul 2004 17:01:12 -0400
Received: from fw.osdl.org ([65.172.181.6]:39900 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265175AbUGZUkR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jul 2004 16:40:17 -0400
Date: Mon, 26 Jul 2004 13:38:46 -0700
From: Andrew Morton <akpm@osdl.org>
To: kladit@t-online.de (Klaus Dittrich)
Cc: kladit@t-online.de, linux-kernel@vger.kernel.org
Subject: Re: dentry cache leak? Re: rsync out of memory 2.6.8-rc2
Message-Id: <20040726133846.604cef91.akpm@osdl.org>
In-Reply-To: <4105633C.3080204@xeon2.local.here>
References: <20040726150615.GA1119@xeon2.local.here>
	<20040726123702.222ae654.akpm@osdl.org>
	<4105633C.3080204@xeon2.local.here>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

kladit@t-online.de (Klaus Dittrich) wrote:
>
> cat /proc/sys/vm/vfs_cache_pressure shows 100.

Drat.

>  Should I try an older or newer compiler ?

gcc-3.3 or gcc-3.4 would suit.  If that doesn't change anything, please
send me the .config.

