Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268348AbUIQAOg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268348AbUIQAOg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Sep 2004 20:14:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268404AbUIQAOg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Sep 2004 20:14:36 -0400
Received: from fw.osdl.org ([65.172.181.6]:41860 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S268348AbUIQAOb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Sep 2004 20:14:31 -0400
Date: Thu, 16 Sep 2004 17:18:17 -0700
From: Andrew Morton <akpm@osdl.org>
To: Stelian Pop <stelian@popies.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC, 2.6] a simple FIFO implementation
Message-Id: <20040916171817.78ab4430.akpm@osdl.org>
In-Reply-To: <20040916180908.GB9886@deep-space-9.dsnet>
References: <20040913135253.GA3118@crusoe.alcove-fr>
	<20040915153013.32e797c8.akpm@osdl.org>
	<20040916064320.GA9886@deep-space-9.dsnet>
	<20040916000438.46d91e94.akpm@osdl.org>
	<20040916104535.GA3146@crusoe.alcove-fr>
	<20040916100050.17a9b341.akpm@osdl.org>
	<20040916180908.GB9886@deep-space-9.dsnet>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stelian Pop <stelian@popies.net> wrote:
>
> > I've always done it the other way: you put stuff onto the head and take
> > stuff off the tail.  Now I have a horid feeling that I've always been
> > arse-about.  hrm.  
> 
> Maybe I should use 'start' and 'end' as indices after all, they
> are less subject to confusion.

`in' and `out' would be more meaningful, yes?  I'll edit the diff.
