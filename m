Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262657AbVBYJuI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262657AbVBYJuI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Feb 2005 04:50:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262660AbVBYJuI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Feb 2005 04:50:08 -0500
Received: from fire.osdl.org ([65.172.181.4]:58558 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262657AbVBYJuE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Feb 2005 04:50:04 -0500
Date: Fri, 25 Feb 2005 01:46:26 -0800
From: Andrew Morton <akpm@osdl.org>
To: Arjan van de Ven <arjan@infradead.org>
Cc: adilger@clusterfs.com, bzolnier@gmail.com, bunk@stusta.de,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] unexport do_settimeofday
Message-Id: <20050225014626.223c3114.akpm@osdl.org>
In-Reply-To: <1109324017.6290.38.camel@laptopd505.fenrus.org>
References: <20050224233742.GR8651@stusta.de>
	<20050224212448.367af4be.akpm@osdl.org>
	<1109318525.6290.32.camel@laptopd505.fenrus.org>
	<20050225002804.4905b649.akpm@osdl.org>
	<58cb370e050225004759e1dc59@mail.gmail.com>
	<20050225092640.GS27352@schnapps.adilger.int>
	<1109324017.6290.38.camel@laptopd505.fenrus.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven <arjan@infradead.org> wrote:
>
> actually exports cause kernels to be bigger. Some of these exports
> aren't even used in the kernel entirely, others cause the kernel to be
> bigger just by being non-static and having the symbol structures there.

Yup.  IOW, this problem is so vanishingly teensy-weensy as to be almost not
a problem at all.  So we can wait 6-12 months before fixing it.

> A lot of them are "you really shouldn't" APIs.

Sure.  That's why we should remove the export.
