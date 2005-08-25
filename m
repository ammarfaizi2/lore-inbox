Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964795AbVHYE5t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964795AbVHYE5t (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Aug 2005 00:57:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964798AbVHYE5t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Aug 2005 00:57:49 -0400
Received: from ns.miraclelinux.com ([219.118.163.66]:47765 "EHLO
	mail01.miraclelinux.com") by vger.kernel.org with ESMTP
	id S964795AbVHYE5t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Aug 2005 00:57:49 -0400
Date: Thu, 25 Aug 2005 13:53:05 +0900 (JST)
Message-Id: <20050825.135305.607972645.hyoshiok@miraclelinux.com>
To: taka@valinux.co.jp
Cc: linux-kernel@vger.kernel.org, hyoshiok@miraclelinux.com
Subject: Re: [RFC] [PATCH] cache pollution aware __copy_from_user_ll()
From: Hiro Yoshioka <hyoshiok@miraclelinux.com>
In-Reply-To: <20050825.012242.74736989.taka@valinux.co.jp>
References: <20050823.081246.846946371.hyoshiok@miraclelinux.com>
	<20050824.231156.278740508.hyoshiok@miraclelinux.com>
	<20050825.012242.74736989.taka@valinux.co.jp>
X-Mailer: Mew version 3.3 on XEmacs 21.4.13 (Rational FORTRAN)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hirokazu Takahashi <taka@valinux.co.jp>
> > The following patch does not use MMX regsiters so that we don't have
> > to worry about save/restore the FPU/MMX states.
> > 
> > What do you think?
> 
> I think __copy_user_zeroing_intel_nocache() should be followed by sfence
> or mfence instruction to flush the data.

Thanks. I'll implement it.

Regards,
  Hiro
