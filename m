Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261280AbTEFONZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 10:13:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263735AbTEFOM3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 10:12:29 -0400
Received: from zeus.kernel.org ([204.152.189.113]:7824 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S261280AbTEFOLS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 10:11:18 -0400
Subject: Re: [PATCH] asm-generic magic
From: "David S. Miller" <davem@redhat.com>
To: george anzinger <george@mvista.com>
Cc: Andrew Morton <akpm@zip.com.au>, kbuild-devel@lists.sourceforge.net,
       mec@shout.net,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <3EB75924.1080304@mvista.com>
References: <3EB75924.1080304@mvista.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1052205991.983.13.camel@rth.ninka.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 06 May 2003 00:26:31 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-05-05 at 23:41, george anzinger wrote:
> That is, if the file exists in .../include/asm/ use that one, if not 
> and it exist in .../include/asm-generic/ use the generic one.

This is not at all how this stuff is supposed to work.

You must include them from the asm-${ARCH}/foo.h file.

Please, don't create this setup.

-- 
David S. Miller <davem@redhat.com>
