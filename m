Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932086AbWE3BaN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932086AbWE3BaN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 May 2006 21:30:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751567AbWE3BaI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 May 2006 21:30:08 -0400
Received: from smtp.osdl.org ([65.172.181.4]:28864 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751549AbWE3B3l (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 May 2006 21:29:41 -0400
Date: Mon, 29 May 2006 18:33:55 -0700
From: Andrew Morton <akpm@osdl.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, arjan@infradead.org
Subject: Re: [patch 15/61] lock validator: x86_64: use stacktrace to
 generate backtraces
Message-Id: <20060529183355.76d6b93b.akpm@osdl.org>
In-Reply-To: <20060529212418.GO3155@elte.hu>
References: <20060529212109.GA2058@elte.hu>
	<20060529212418.GO3155@elte.hu>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 May 2006 23:24:19 +0200
Ingo Molnar <mingo@elte.hu> wrote:

> this switches x86_64 to use the stacktrace infrastructure when generating
> backtrace printouts, if CONFIG_FRAME_POINTER=y. (This patch will go away
> once the dwarf2 stackframe parser in -mm goes upstream.)

yup, I dropped it.
