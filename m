Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266621AbUBQXsr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Feb 2004 18:48:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266573AbUBQXsr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Feb 2004 18:48:47 -0500
Received: from fw.osdl.org ([65.172.181.6]:8646 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266695AbUBQXsp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Feb 2004 18:48:45 -0500
Date: Tue, 17 Feb 2004 15:50:36 -0800
From: Andrew Morton <akpm@osdl.org>
To: Tom Rini <trini@kernel.crashing.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH][1/6] A different KGDB stub
Message-Id: <20040217155036.33e37c67.akpm@osdl.org>
In-Reply-To: <20040217220249.GB16881@smtp.west.cox.net>
References: <20040217220249.GB16881@smtp.west.cox.net>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tom Rini <trini@kernel.crashing.org> wrote:
>
> The following is the core bits to this KGDB stub.

This still contains the kern_do_schedule() gunk.  Andi raised this issue
last week.  He identified several other significant issues as well, but
there was no followup.  Could you please dig out his email and address the
points which he raised?  (I can't find the email - perhaps Andi could
re-review this patch?)

