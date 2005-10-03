Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932088AbVJCFck@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932088AbVJCFck (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Oct 2005 01:32:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932091AbVJCFck
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Oct 2005 01:32:40 -0400
Received: from sv1.valinux.co.jp ([210.128.90.2]:43907 "EHLO sv1.valinux.co.jp")
	by vger.kernel.org with ESMTP id S932088AbVJCFck (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Oct 2005 01:32:40 -0400
Date: Mon, 03 Oct 2005 14:26:49 +0900 (JST)
Message-Id: <20051003.142649.56153089.taka@valinux.co.jp>
To: pj@sgi.com
Cc: magnus.damm@gmail.com, haveblue@us.ibm.com, magnus@valinux.co.jp,
       linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/07][RFC] i386: NUMA emulation
From: Hirokazu Takahashi <taka@valinux.co.jp>
In-Reply-To: <aec7e5c30510022205o770b6335o96d9a9d9cc5d7397@mail.gmail.com>
References: <1128093825.6145.26.camel@localhost>
	<20051002202157.7b54253d.pj@sgi.com>
	<aec7e5c30510022205o770b6335o96d9a9d9cc5d7397@mail.gmail.com>
X-Mailer: Mew version 2.2 on Emacs 20.7 / Mule 4.0 (HANANOEN)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> > In theory at least, I applaud Magnus's work here.  The assymetry of the
> > SMP/NUMA define structure has always annoyed me slightly, and only been
> > explainable in my view as a consequence of the historical order of
> > development.  I had a PC with a second memory board in an ISA slot,
> > which would qualify as a one CPU, two Memory Node system.
> >
> > Or what byte us in the future (that PC was a long time ago), the kinks
> > in the current setup might be a hitch in our side as we extend to
> > increasingly interesting architectures.
> 
> Nice to hear that you like the idea.
> 
> Maybe I should have broken down my patches into three smaller sets:
> 
> 1) i386: NUMA without SMP
> 2) CPUSETS: NUMA || SMP
> 3) i386: NUMA emulation
> 
> If people like 1) then it's probably a good idea to convert other
> architectures too. Both 2) and 3) above are separate but related
> issues. And now seems like a good time to solve 2).
> 
> So, Paul, please let me know if you prefer SMP || NUMA or no
> depencencies in the Kconfig. When I know that I will create a new
> patch that hopefully can get into -mm later on.

The latter seems a good idea to me if you're going to enhance CPUSETS
acceptable for CPUMETER or something like that.

Thanks.
