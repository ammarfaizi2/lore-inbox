Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261698AbTHTB0B (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Aug 2003 21:26:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261700AbTHTB0B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Aug 2003 21:26:01 -0400
Received: from fw.osdl.org ([65.172.181.6]:24016 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261698AbTHTBZ7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Aug 2003 21:25:59 -0400
Date: Tue, 19 Aug 2003 18:27:38 -0700
From: Andrew Morton <akpm@osdl.org>
To: Enrico Demarin <enricod@videotron.ca>
Cc: linux-kernel@vger.kernel.org
Subject: Re: SMP oops on Xseries235
Message-Id: <20030819182738.65296132.akpm@osdl.org>
In-Reply-To: <004c01c36684$791bb100$0440a8c0@SC2003002>
References: <004c01c36684$791bb100$0440a8c0@SC2003002>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Enrico Demarin <enricod@videotron.ca> wrote:
>
>  Assertion failure in journal_stop() at transaction.c:1416:
>  "journal_current_handle() == handle"
>  kernel BUG at transaction.c:1416!

Please decode this trace with ksymoops.

