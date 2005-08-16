Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750717AbVHPX0p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750717AbVHPX0p (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Aug 2005 19:26:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750733AbVHPX0p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Aug 2005 19:26:45 -0400
Received: from ns.miraclelinux.com ([219.118.163.66]:40861 "EHLO
	mail01.miraclelinux.com") by vger.kernel.org with ESMTP
	id S1750717AbVHPX0o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Aug 2005 19:26:44 -0400
Date: Wed, 17 Aug 2005 08:21:53 +0900 (JST)
Message-Id: <20050817.082153.719902707.hyoshiok@miraclelinux.com>
To: 76306.1226@compuserve.com
Cc: lkml.hyoshiok@gmail.com, taka@valinux.co.jp, arjan@infradead.org,
       linux-kernel@vger.kernel.org, hyoshiok@miraclelinux.com
Subject: Re: [RFC] [PATCH] cache pollution aware __copy_from_user_ll()
From: Hiro Yoshioka <hyoshiok@miraclelinux.com>
In-Reply-To: <200508161412_MC3-1-A759-465F@compuserve.com>
References: <200508161412_MC3-1-A759-465F@compuserve.com>
X-Mailer: Mew version 3.3 on XEmacs 21.4.13 (Rational FORTRAN)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chuck,

From: Chuck Ebbert <76306.1226@compuserve.com>
> On Tue, 16 Aug 2005 at 19:16:17 +0900 (JST), Hiro Yoshioka wrote:
> > oh, really? Does the linux kernel take care of
> > SSE save/restore on a task switch?
> 
>  Check out XMMS_SAVE and XMMS_RESTORE in include/asm-i386/xor.h

Thanks for your suggestion. But it seems to me it won't help
when we have a page fault or other exeptions.

Regards,
  Hiro
