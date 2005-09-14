Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932313AbVINSAE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932313AbVINSAE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 14:00:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932417AbVINSAE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 14:00:04 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:14019
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S932313AbVINSAC (ORCPT <rfc822;Linux-Kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 14:00:02 -0400
Date: Wed, 14 Sep 2005 10:59:46 -0700 (PDT)
Message-Id: <20050914.105946.131926485.davem@davemloft.net>
To: nickpiggin@yahoo.com.au
Cc: zippel@linux-m68k.org, Linux-Kernel@vger.kernel.org, dipankar@in.ibm.com
Subject: Re: [PATCH 5/5] remove HAVE_ARCH_CMPXCHG
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <432854B6.1020408@yahoo.com.au>
References: <43283B66.8080005@yahoo.com.au>
	<Pine.LNX.4.61.0509141829050.3743@scrub.home>
	<432854B6.1020408@yahoo.com.au>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nick Piggin <nickpiggin@yahoo.com.au>
Date: Thu, 15 Sep 2005 02:49:58 +1000

> I think it already is. At least, I did grep for it and didn't
> see anything.

Things in this class, such as DRM, just happen to only get enabled on
platforms that have a cmpxchg() available, they don't actually check.

That being said, I agree that Kconfig is the place to do this and
then DRM's Kconfig can get the correct dependency.
