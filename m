Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965104AbVHPE7S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965104AbVHPE7S (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Aug 2005 00:59:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932602AbVHPE7S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Aug 2005 00:59:18 -0400
Received: from ns.miraclelinux.com ([219.118.163.66]:45633 "EHLO
	mail01.miraclelinux.com") by vger.kernel.org with ESMTP
	id S932603AbVHPE7R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Aug 2005 00:59:17 -0400
Date: Tue, 16 Aug 2005 13:54:25 +0900 (JST)
Message-Id: <20050816.135425.719901536.hyoshiok@miraclelinux.com>
To: taka@valinux.co.jp
Cc: lkml.hyoshiok@gmail.com, arjan@infradead.org, linux-kernel@vger.kernel.org,
       hyoshiok@miraclelinux.com
Subject: Re: [RFC] [PATCH] cache pollution aware __copy_from_user_ll()
From: Hiro Yoshioka <hyoshiok@miraclelinux.com>
In-Reply-To: <20050816.131729.15816429.taka@valinux.co.jp>
References: <98df96d3050815163331d6cce1@mail.gmail.com>
	<20050816.123042.424254477.hyoshiok@miraclelinux.com>
	<20050816.131729.15816429.taka@valinux.co.jp>
X-Mailer: Mew version 3.3 on XEmacs 21.4.13 (Rational FORTRAN)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Takahashi san,

I appreciate your comments.

> Hi,
> 
> BTW, what are you going to do with the page-faults which may happen
> during __copy_user_zeroing_nocache()? The current process may be blocked
> in the handler for a while and get FPU registers polluted.
> kernel_fpu_begin() won't help the case. This is another issue, though.

My code does nothing do it.

I need a volunteer to implement it.

Regards,
  Hiro
