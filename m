Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265629AbUABX7q (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jan 2004 18:59:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265684AbUABX7q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jan 2004 18:59:46 -0500
Received: from mta06-svc.ntlworld.com ([62.253.162.46]:22395 "EHLO
	mta06-svc.ntlworld.com") by vger.kernel.org with ESMTP
	id S265629AbUABX7p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jan 2004 18:59:45 -0500
Date: Fri, 2 Jan 2004 23:59:53 +0000
From: DaMouse Networks <damouse@ntlworld.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [BUG] 2.6.1-rc1-mm1 with r8169 driver
Message-Id: <20040102235953.65b8d506@EozVul.WORKGROUP>
Organization: DaMouse Networks
X-Mailer: Sylpheed version 0.9.8claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I made a "failed" file, heres what i put in it for debugging :)

If i don't state errors then it patched/compiled/loaded as near cleanly as you can with a few steps of version between what your using.
r8169-dma-api-rx-buffers.patch - froze on ifconfig
r8169-dma-api-rx-buffers-ahum.patch - joined with above
r8169-rx_copybreak.patch - 3 HUNK failure on patch maybe due to first two failures

got kpanics on mac-phy patch after this and decided to send you this sooner
