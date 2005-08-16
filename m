Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965194AbVHPKY0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965194AbVHPKY0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Aug 2005 06:24:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965195AbVHPKY0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Aug 2005 06:24:26 -0400
Received: from sv1.valinux.co.jp ([210.128.90.2]:53215 "EHLO sv1.valinux.co.jp")
	by vger.kernel.org with ESMTP id S965194AbVHPKY0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Aug 2005 06:24:26 -0400
Date: Tue, 16 Aug 2005 19:19:23 +0900 (JST)
Message-Id: <20050816.191923.133525108.taka@valinux.co.jp>
To: hyoshiok@miraclelinux.com
Cc: arjan@infradead.org, lkml.hyoshiok@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [RFC] [PATCH] cache pollution aware __copy_from_user_ll()
From: Hirokazu Takahashi <taka@valinux.co.jp>
In-Reply-To: <20050816.191617.1025215458.hyoshiok@miraclelinux.com>
References: <20050816.135425.719901536.hyoshiok@miraclelinux.com>
	<1124171015.3215.0.camel@laptopd505.fenrus.org>
	<20050816.191617.1025215458.hyoshiok@miraclelinux.com>
X-Mailer: Mew version 2.2 on Emacs 20.7 / Mule 4.0 (HANANOEN)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

> > > My code does nothing do it.
> > > 
> > > I need a volunteer to implement it.
> > 
> > it's actually not too hard; all you need is to use SSE and not MMX; and
> > then just store sse register you're overwriting on the stack or so...
> 
> oh, really? Does the linux kernel take care of
> SSE save/restore on a task switch?

noop!
