Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265501AbUF2Gvn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265501AbUF2Gvn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jun 2004 02:51:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265502AbUF2Gvn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jun 2004 02:51:43 -0400
Received: from fw.osdl.org ([65.172.181.6]:29135 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265501AbUF2Gvb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jun 2004 02:51:31 -0400
Date: Mon, 28 Jun 2004 23:50:31 -0700
From: Andrew Morton <akpm@osdl.org>
To: Peter Lundkvist <p.lundkvist@telia.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.7-mm2: random problems with mmap
Message-Id: <20040628235031.037627c5.akpm@osdl.org>
In-Reply-To: <20040629055906.GA21986@debian>
References: <20040624014655.5d2a4bfb.akpm@osdl.org>
	<20040629055906.GA21986@debian>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Lundkvist <p.lundkvist@telia.com> wrote:
>
> I have problems running cyrus lmtpd; it fails randomly after
>  fetching 30-50 mails. I have only seen this problem in
>  2.6.7-mm2 (-mm1 was ok, have not tested -mm3 yet).

The "flexible-mmap" patch was rather broken.  It was dropped for -mm3 and a
fixed version will be in -mm4.
