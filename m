Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262069AbTJBECQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Oct 2003 00:02:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263236AbTJBECQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Oct 2003 00:02:16 -0400
Received: from smtp.bitmover.com ([192.132.92.12]:26775 "EHLO
	smtp.bitmover.com") by vger.kernel.org with ESMTP id S262069AbTJBECO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Oct 2003 00:02:14 -0400
Date: Wed, 1 Oct 2003 21:02:06 -0700
From: Larry McVoy <lm@bitmover.com>
To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
       Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCHES] today's batch of "nuking kernel/ksyms.c"
Message-ID: <20031002040206.GA2382@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Linus Torvalds <torvalds@osdl.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20031002030338.GB1699@conectiva.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031002030338.GB1699@conectiva.com.br>
User-Agent: Mutt/1.4i
X-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam (whitelisted), SpamAssassin (score=0.3,
	required 7, AWL)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If this is all the same idea why are you putting it in multiple changesets?
Where I work we have a rule "one idea, one changeset", which makes it far
easier to track down problems later.

On Thu, Oct 02, 2003 at 12:03:38AM -0300, Arnaldo Carvalho de Melo wrote:
> ChangeSet@1.1396, 2003-10-02 02:39:04-03:00, acme@parisc.kerneljanitors.org
>   o kernel/ksyms.c: move relevant EXPORT_SYMBOLs to fs/fcntl.c
> ChangeSet@1.1395, 2003-10-02 02:32:40-03:00, acme@parisc.kerneljanitors.org
>   o kernel/ksyms.c: move relevant EXPORT_SYMBOLs to fs/attr.c
> ChangeSet@1.1394, 2003-10-02 02:28:31-03:00, acme@parisc.kerneljanitors.org
>   o kernel/ksyms.c: move relevant EXPORT_SYMBOLs to fs/filesystems.c
> ChangeSet@1.1393, 2003-10-02 02:14:22-03:00, acme@parisc.kerneljanitors.org
>   o kernel/ksyms.c: move relevant EXPORT_SYMBOLs to fs/fs-writeback.c
> ChangeSet@1.1392, 2003-10-02 02:10:28-03:00, acme@parisc.kerneljanitors.org
>   o kernel/ksyms.c: move relevant EXPORT_SYMBOLs to fs/partitions/check.c
> ChangeSet@1.1391, 2003-10-02 02:02:17-03:00, acme@parisc.kerneljanitors.org
>   o kernel/ksyms.c: move relevant EXPORT_SYMBOLs to fs/select.c
> ChangeSet@1.1390, 2003-10-02 01:54:54-03:00, acme@parisc.kerneljanitors.org
>   o kernel/ksyms.c: move relevant EXPORT_SYMBOLs to fs/locks.c
> ChangeSet@1.1389, 2003-10-02 01:46:05-03:00, acme@parisc.kerneljanitors.org
>   o kernel/ksyms.c: move relevant EXPORT_SYMBOLs to fs/namespace.c
> ChangeSet@1.1388, 2003-10-02 01:31:38-03:00, acme@parisc.kerneljanitors.org
>   o kernel/ksyms.c: move relevant EXPORT_SYMBOLs to fs/file_table.c
> ChangeSet@1.1387, 2003-10-02 01:26:03-03:00, acme@parisc.kerneljanitors.org
>   o kernel/ksyms.c: move relevant EXPORT_SYMBOLs to fs/open.c
> ChangeSet@1.1386, 2003-10-02 01:17:47-03:00, acme@parisc.kerneljanitors.org
>   o kernel/ksyms.c: move relevant EXPORT_SYMBOLs to fs/stat.c
> ChangeSet@1.1385, 2003-10-02 01:04:15-03:00, acme@parisc.kerneljanitors.org
>   o kernel/ksyms.c: move relevant EXPORT_SYMBOLs to fs/read_write.c
