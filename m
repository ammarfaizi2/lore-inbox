Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964794AbWIYGkf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964794AbWIYGkf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Sep 2006 02:40:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932245AbWIYGkf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Sep 2006 02:40:35 -0400
Received: from smtp.osdl.org ([65.172.181.4]:25751 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932243AbWIYGke (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Sep 2006 02:40:34 -0400
Date: Sun, 24 Sep 2006 23:40:15 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Andi Kleen <ak@muc.de>, Chuck Ebbert <76306.1226@compuserve.com>,
       Zachary Amsden <zach@vmware.com>, Jan Beulich <jbeulich@novell.com>,
       linux-kernel@vger.kernel.org
Subject: Re: i386 pda patches
Message-Id: <20060924234015.d32db40a.akpm@osdl.org>
In-Reply-To: <4517774F.9010806@goop.org>
References: <20060924013521.13d574b1.akpm@osdl.org>
	<4517256E.10606@goop.org>
	<20060924223427.6f42e77c.akpm@osdl.org>
	<45176B53.7040608@goop.org>
	<20060924230506.572eee8e.akpm@osdl.org>
	<4517774F.9010806@goop.org>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 24 Sep 2006 23:29:35 -0700
Jeremy Fitzhardinge <jeremy@goop.org> wrote:

> Andrew Morton wrote:
> > It oopses in the same manner with 4k stacks enabled.
> >   
> 
> Hm. Looks like its the actual load_TR_desc() getting the GPF. I'm 
> updating the patches to 2.6.18-mm1, and I'll try to repro this.
> 
> Have there been any other oops reports for -mm which look like this?

I bisected it down to that particular diff.

> Is 
> there anything unusual about the config?

Nope.  I included a copy in top-of-thread.


