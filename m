Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265269AbUF3CEZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265269AbUF3CEZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jun 2004 22:04:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265270AbUF3CEZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jun 2004 22:04:25 -0400
Received: from web41506.mail.yahoo.com ([66.218.93.89]:24507 "HELO
	web41506.mail.yahoo.com") by vger.kernel.org with SMTP
	id S265269AbUF3CEY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jun 2004 22:04:24 -0400
Message-ID: <20040630020422.94235.qmail@web41506.mail.yahoo.com>
Date: Tue, 29 Jun 2004 19:04:22 -0700 (PDT)
From: Brian Gunlogson <bmg300@yahoo.com>
Subject: Re: Kernel VM bug? (more info)
To: William Lee Irwin III <wli@holomorphy.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20040628025832.GM21066@holomorphy.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I got more info, hope this helps. Sometimes the kernel panics at vmscan:388. That is in kernel
2.4.26, function shrink_cache() on a source code line that says BUG_ON(!PageLRU(page));

Brian


		
__________________________________
Do you Yahoo!?
Yahoo! Mail - 50x more storage than other providers!
http://promotions.yahoo.com/new_mail
