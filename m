Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965192AbVHPKVG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965192AbVHPKVG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Aug 2005 06:21:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965194AbVHPKVG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Aug 2005 06:21:06 -0400
Received: from ns.miraclelinux.com ([219.118.163.66]:22899 "EHLO
	mail01.miraclelinux.com") by vger.kernel.org with ESMTP
	id S965192AbVHPKVF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Aug 2005 06:21:05 -0400
Date: Tue, 16 Aug 2005 19:16:17 +0900 (JST)
Message-Id: <20050816.191617.1025215458.hyoshiok@miraclelinux.com>
To: arjan@infradead.org
Cc: taka@valinux.co.jp, lkml.hyoshiok@gmail.com, linux-kernel@vger.kernel.org,
       hyoshiok@miraclelinux.com
Subject: Re: [RFC] [PATCH] cache pollution aware __copy_from_user_ll()
From: Hiro Yoshioka <hyoshiok@miraclelinux.com>
In-Reply-To: <1124171015.3215.0.camel@laptopd505.fenrus.org>
References: <20050816.131729.15816429.taka@valinux.co.jp>
	<20050816.135425.719901536.hyoshiok@miraclelinux.com>
	<1124171015.3215.0.camel@laptopd505.fenrus.org>
X-Mailer: Mew version 3.3 on XEmacs 21.4.13 (Rational FORTRAN)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arjan van de Ven <arjan@infradead.org>
> > My code does nothing do it.
> > 
> > I need a volunteer to implement it.
> 
> it's actually not too hard; all you need is to use SSE and not MMX; and
> then just store sse register you're overwriting on the stack or so...

oh, really? Does the linux kernel take care of
SSE save/restore on a task switch?

Regards,
  Hiro
