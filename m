Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261816AbTISUDT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Sep 2003 16:03:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261824AbTISUB5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Sep 2003 16:01:57 -0400
Received: from fw.osdl.org ([65.172.181.6]:3987 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261724AbTISUBQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Sep 2003 16:01:16 -0400
Date: Fri, 19 Sep 2003 12:42:13 -0700
From: Andrew Morton <akpm@osdl.org>
To: Omen Wild <Omen.Wild@Dartmouth.EDU>
Cc: linux-kernel@vger.kernel.org
Subject: Re: call_usermodehelper does not report exit status?
Message-Id: <20030919124213.7fc93067.akpm@osdl.org>
In-Reply-To: <20030919195132.GC2236@descolada.dartmouth.edu>
References: <20030919162422.GB2236@descolada.dartmouth.edu>
	<20030919112148.42adf179.akpm@osdl.org>
	<20030919195132.GC2236@descolada.dartmouth.edu>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Omen Wild <Omen.Wild@Dartmouth.EDU> wrote:
>
> Quoting Andrew Morton <akpm@osdl.org> on Fri, Sep 19 11:21:
> >
> > This might fix it.
> 
> Hmmm, that did not fix it for me.  No change in behavior.
> 

Curses, foiled again.

I agree that as long as we are supporting synchronous callouts we should be
correctly returning the exit code.   I'll work on it a bit.

