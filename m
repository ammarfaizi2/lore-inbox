Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267859AbUHUVGu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267859AbUHUVGu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Aug 2004 17:06:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267906AbUHUVGD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Aug 2004 17:06:03 -0400
Received: from fw.osdl.org ([65.172.181.6]:29325 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267882AbUHUVAb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Aug 2004 17:00:31 -0400
Date: Sat, 21 Aug 2004 13:58:33 -0700
From: Andrew Morton <akpm@osdl.org>
To: John Levon <levon@movementarian.org>
Cc: oprofile-list@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       jbarnes@sgi.com, anton@samba.org, phil.el@wanadoo.fr
Subject: Re: [PATCH] improve OProfile on many-way systems
Message-Id: <20040821135833.6b1774a8.akpm@osdl.org>
In-Reply-To: <20040821192630.GA9501@compsoc.man.ac.uk>
References: <20040821192630.GA9501@compsoc.man.ac.uk>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Levon <levon@movementarian.org> wrote:
>
> Anton prompted me to get this patch merged.  It changes the core buffer
>  sync algorithm of OProfile to avoid global locks wherever possible.
>  Anton tested an earlier version of this patch with some success. I've
>  lightly tested this applied against 2.6.8.1-mm3 on my two-way machine.

OK.  Oprofile isn't the most commonly tested part of the kernel.  Given
that you've "lightly tested" it, how do we know when it has had sufficient
testing for its swim upstream?

Does Philippe have some test suite, perhaps?
