Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264665AbUEOIig@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264665AbUEOIig (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 May 2004 04:38:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264675AbUEOIig
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 May 2004 04:38:36 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:48029 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S264665AbUEOIie (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 May 2004 04:38:34 -0400
Date: Sat, 15 May 2004 10:38:33 +0200
From: Jens Axboe <axboe@suse.de>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: RPC request reserved 0 but used 96
Message-ID: <20040515083831.GR17326@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Seeing lots of these on a small server that hosts nfs shares (root and
"normal").

router:~ # dmesg | tail -n5
RPC request reserved 0 but used 96
RPC request reserved 0 but used 96
RPC request reserved 0 but used 140
RPC request reserved 0 but used 140
RPC request reserved 0 but used 96

I see nfs stalls on the client, doesn't seem to be directly related to
when the above messages happen.

-- 
Jens Axboe

