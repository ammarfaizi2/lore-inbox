Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750994AbVHQIrH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750994AbVHQIrH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Aug 2005 04:47:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750998AbVHQIrH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Aug 2005 04:47:07 -0400
Received: from ns.miraclelinux.com ([219.118.163.66]:59113 "EHLO
	mail01.miraclelinux.com") by vger.kernel.org with ESMTP
	id S1750994AbVHQIrG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Aug 2005 04:47:06 -0400
Date: Wed, 17 Aug 2005 17:42:22 +0900 (JST)
Message-Id: <20050817.174222.1025215937.hyoshiok@miraclelinux.com>
To: taka@valinux.co.jp
Cc: lkml.hyoshiok@gmail.com, linux-kernel@vger.kernel.org,
       hyoshiok@miraclelinux.com
Subject: Re: math_state_restore() question
From: Hiro Yoshioka <hyoshiok@miraclelinux.com>
In-Reply-To: <20050817.170700.34136678.taka@valinux.co.jp>
References: <98df96d305081700581ebdd5ed@mail.gmail.com>
	<20050817.170700.34136678.taka@valinux.co.jp>
X-Mailer: Mew version 3.3 on XEmacs 21.4.13 (Rational FORTRAN)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Just take a look at __switch_to(), where __unlazy_fpu() is called.

Thanks. Does an exception handler (like page_fault, etc) come 
from __switch_to()?

Regards,
  Hiro
