Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262776AbTJTWRE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Oct 2003 18:17:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262801AbTJTWRE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Oct 2003 18:17:04 -0400
Received: from [65.172.181.6] ([65.172.181.6]:44956 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262776AbTJTWRC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Oct 2003 18:17:02 -0400
Date: Mon, 20 Oct 2003 15:17:13 -0700
From: Andrew Morton <akpm@osdl.org>
To: Thomas Schlichter <schlicht@uni-mannheim.de>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.6.0-test8-mm1
Message-Id: <20031020151713.149bba88.akpm@osdl.org>
In-Reply-To: <200310210001.08761.schlicht@uni-mannheim.de>
References: <20031020020558.16d2a776.akpm@osdl.org>
	<200310201811.18310.schlicht@uni-mannheim.de>
	<20031020144836.331c4062.akpm@osdl.org>
	<200310210001.08761.schlicht@uni-mannheim.de>
X-Mailer: Sylpheed version 0.9.6 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Schlichter <schlicht@uni-mannheim.de> wrote:
>
> On Monday 20 October 2003 23:48, Andrew Morton wrote:
> > A colleague here has discovered that this crash is repeatable, but goes
> > away when the radeon driver is disabled.
> >
> > Are you using that driver?
> 
> No, I'm not... I use the vesafb driver. Do you think disabling this could cure 
> the Oops?

It might.  Could you test it please?

There's nothing in -mm which touches the inode list management code, so a
random scribble or misbehaving driver is likely.

> Btw. a similar Oops at the same place occours when the uhci-hcd module is 
> unloaded...

How similar?


