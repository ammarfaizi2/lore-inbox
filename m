Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261719AbTI3Vzd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Sep 2003 17:55:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261733AbTI3Vzd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Sep 2003 17:55:33 -0400
Received: from fw.osdl.org ([65.172.181.6]:207 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261719AbTI3Vz3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Sep 2003 17:55:29 -0400
Date: Tue, 30 Sep 2003 14:35:03 -0700
From: Andrew Morton <akpm@osdl.org>
To: Simon Kirby <sim@netnation.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6.0-test5-bk13] SIGSTOPping tar extraction process causes
 other I/O processes to block
Message-Id: <20030930143503.4b66c4c4.akpm@osdl.org>
In-Reply-To: <20030930183948.GA31055@netnation.com>
References: <20030930183948.GA31055@netnation.com>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Simon Kirby <sim@netnation.com> wrote:
>
> I was extracting a large tarball of 2 MB image files and running and
> apt-get remove at the same time, realized the disk was thrashing back
> and forth, and decided to suspend the tar process until the apt-get was
> finished.  When I suspended the tar, apt-get never finished.  Right-alt
> SysRQ (SysRQ-T) dumped the following traces for the processes in
> question:

If you still have the full sysrq trace, please send it along.  Need to know
what kjournald was up to..
