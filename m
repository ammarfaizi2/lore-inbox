Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271117AbTHCJQo (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Aug 2003 05:16:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271118AbTHCJQo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Aug 2003 05:16:44 -0400
Received: from fw.osdl.org ([65.172.181.6]:21449 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S271117AbTHCJQ0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Aug 2003 05:16:26 -0400
Date: Sun, 3 Aug 2003 02:17:27 -0700
From: Andrew Morton <akpm@osdl.org>
To: Sander van Malssen <svm@kozmix.org>
Cc: yoh@onerussian.com, linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test2-bk3 phantom I/O errors
Message-Id: <20030803021727.3b54cd17.akpm@osdl.org>
In-Reply-To: <20030803091007.GA885@kozmix.org>
References: <20030729153114.GA30071@washoe.rutgers.edu>
	<20030729135025.335de3a0.akpm@osdl.org>
	<20030730170432.GA692@kozmix.org>
	<20030730120002.29c13b0c.akpm@osdl.org>
	<20030730191115.GA733@kozmix.org>
	<20030803091007.GA885@kozmix.org>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sander van Malssen <svm@kozmix.org> wrote:
>
> Well, that's funny. If I run a pristine test2-mm3-1 kernel I don't get
>  those "Buffer I/O error on device ..." kernel messages anymore, but I do
>  get the actual I/O error itself.

The readahead problem got itself fixed.  You are seeing something
unrelated.

Please send a lot more details.

