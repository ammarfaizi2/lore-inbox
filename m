Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262007AbUCLHuM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Mar 2004 02:50:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262008AbUCLHuM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Mar 2004 02:50:12 -0500
Received: from fw.osdl.org ([65.172.181.6]:1518 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262007AbUCLHuI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Mar 2004 02:50:08 -0500
Date: Thu, 11 Mar 2004 23:50:09 -0800
From: Andrew Morton <akpm@osdl.org>
To: Neil Brown <neilb@cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.4-mm1
Message-Id: <20040311235009.212d69f2.akpm@osdl.org>
In-Reply-To: <16465.20264.563965.518274@notabene.cse.unsw.edu.au>
References: <20040310233140.3ce99610.akpm@osdl.org>
	<16465.3163.999977.302378@notabene.cse.unsw.edu.au>
	<20040311172244.3ae0587f.akpm@osdl.org>
	<16465.20264.563965.518274@notabene.cse.unsw.edu.au>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Brown <neilb@cse.unsw.edu.au> wrote:
>
> On Thursday March 11, akpm@osdl.org wrote:
> > 
> > Tried adding earlyprintk=vga?
> > 
> > If that works, judicious addition of printks will narrow it down.
> 
> It doesn't.
> 
> I've tried compiling with SMP - no go.
> I've tried with gcc-2.95 (instead of 3.3.2).  Still no go.

Your .config works happily here.

> I thought I might try selectively removing patches, but it isn't clear
> what order the borken-out patches were applied it.
> If you have an ordered list, I can try a binary search.

See the `series' file in the broken-out directory.

> Or if you can suggest some patches that I can try backing out....

Maybe turn off -mregparm?  Or back off the 4g/4g patches?  Maybe they broke
non-4:4 code comehow.

