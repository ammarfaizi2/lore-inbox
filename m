Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261982AbSIYN6S>; Wed, 25 Sep 2002 09:58:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261983AbSIYN6S>; Wed, 25 Sep 2002 09:58:18 -0400
Received: from dp.samba.org ([66.70.73.150]:29410 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S261982AbSIYN6S>;
	Wed, 25 Sep 2002 09:58:18 -0400
Date: Wed, 25 Sep 2002 23:59:53 +1000
From: Anton Blanchard <anton@samba.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: paulus@samba.org, jdike@karaya.com, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] sigcontext_struct -> sigcontext
Message-ID: <20020925135953.GE2858@krispykreme>
References: <20020925170742.410f3887.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020925170742.410f3887.sfr@canb.auug.org.au>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> PPC and PPC64 are the only two architectures that define a struct
> sigcontext_struct - all the others use struct sigcontext (UML seems to
> have been infected :-)). This patch just renames sigcontext_struct to
> sigcontext.  It also renames sigcontext32_struct to sigcontext.

Thanks Stephen,

I have merged the ppc64 bits.

Anton
