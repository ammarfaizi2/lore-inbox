Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261362AbVBGGin@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261362AbVBGGin (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Feb 2005 01:38:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261364AbVBGGin
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Feb 2005 01:38:43 -0500
Received: from canuck.infradead.org ([205.233.218.70]:47876 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S261362AbVBGGim (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Feb 2005 01:38:42 -0500
Subject: Re: How to read file in kernel module?
From: Arjan van de Ven <arjan@infradead.org>
To: linux lover <linux_lover2004@yahoo.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20050207061718.47940.qmail@web52203.mail.yahoo.com>
References: <20050207061718.47940.qmail@web52203.mail.yahoo.com>
Content-Type: text/plain
Date: Mon, 07 Feb 2005 07:38:36 +0100
Message-Id: <1107758316.3886.58.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.3 (/)
X-Spam-Report: SpamAssassin version 2.63 on canuck.infradead.org summary:
	Content analysis details:   (0.3 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.3 RCVD_NUMERIC_HELO      Received: contains a numeric HELO
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2005-02-06 at 22:17 -0800, linux lover wrote:
> Hello,
>         I have written one /proc file creation kernel
> module. This module creates /proc/file and defied
> operations on it. Also i have written user program
> that will read & write to /proc files from user space.
> Now what i want is to use same bufproc_read &
> bufproc_write  functions defined in /proc file
> handling kernel module to be used in another kernel
> module to read that /proc/file in kernel module.The
> second kernel module only used to read /proc file in
> kernel. I am not understanding how can i open that
> /proc/file in second kenrel module to read in kernel?
> regards,

the answer really is that you should not read files from kernel
modules; /proc or otherwise.


