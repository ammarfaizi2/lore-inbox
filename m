Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965281AbWIJGSa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965281AbWIJGSa (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Sep 2006 02:18:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965282AbWIJGSa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Sep 2006 02:18:30 -0400
Received: from colin.muc.de ([193.149.48.1]:39175 "EHLO mail.muc.de")
	by vger.kernel.org with ESMTP id S965281AbWIJGSa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Sep 2006 02:18:30 -0400
Date: 10 Sep 2006 08:18:28 +0200
Date: Sun, 10 Sep 2006 08:18:28 +0200
From: Andi Kleen <ak@muc.de>
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] i386-pda updates
Message-ID: <20060910061828.GB12564@muc.de>
References: <45027822.2010906@goop.org> <20060909155257.GA50136@muc.de> <45034E97.9090109@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45034E97.9090109@goop.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 09, 2006 at 04:30:31PM -0700, Jeremy Fitzhardinge wrote:
> Andi Kleen wrote:
> >>@@ -20,7 +22,14 @@ extern struct i386_pda _proxy_pda;
> >>#define pda_to_op(op,field,val)					 \
> >>	do {								\
> >>		typedef typeof(_proxy_pda.field) T__;			\
> >>+		if (0) { T__ tmp__; tmp__ = (val); }			\
> >>    
> >
> >Merged into original patch
> >  
> BTW, do you mean you already had this in i386, or that you folded it 
> into the existing patch?  I don't think I had sent out my version of 
> this before.

I folded it into the existing patch.

-Andi
