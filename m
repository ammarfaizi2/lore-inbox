Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261977AbTDAByp>; Mon, 31 Mar 2003 20:54:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261978AbTDAByo>; Mon, 31 Mar 2003 20:54:44 -0500
Received: from dp.samba.org ([66.70.73.150]:59776 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S261977AbTDAByo>;
	Mon, 31 Mar 2003 20:54:44 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Keith Owens <kaos@ocs.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Put all functions in kallsyms 
In-reply-to: Your message of "Tue, 01 Apr 2003 10:46:54 +1000."
             <6572.1049158014@ocs3.intra.ocs.com.au> 
Date: Tue, 01 Apr 2003 11:59:27 +1000
Message-Id: <20030401020607.BA6F32C092@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <6572.1049158014@ocs3.intra.ocs.com.au> you write:
> On Mon, 31 Mar 2003 18:14:03 +1000, 
> Rusty Russell <rusty@rustcorp.com.au> wrote:
> >D: TODO: Allow multiple kallsym tables, discard init one after init.
> 
> Don't.  Almost all kernel threads have a backtrace that goes through
> __init code, even though that code no longer exists.  The symbols are
> still needed to get a decent backtrace and the overhead is minimal.

Hi Keith,

	Excellent point.  Thanks!

Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
