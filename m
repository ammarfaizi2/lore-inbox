Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751104AbWHYLkO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751104AbWHYLkO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Aug 2006 07:40:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751453AbWHYLkO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Aug 2006 07:40:14 -0400
Received: from boxa.alphawave.net ([207.218.5.130]:38840 "EHLO
	box.alphawave.net") by vger.kernel.org with ESMTP id S1751104AbWHYLkN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Aug 2006 07:40:13 -0400
To: linux-kernel@vger.kernel.org
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Serial custom speed deprecated?
In-Reply-To: <6NvSc-1go-31@gated-at.bofh.it>
References: <6N8LR-22A-5@gated-at.bofh.it> <6Njxz-797-13@gated-at.bofh.it> <6NqfR-5Ld-49@gated-at.bofh.it> <6NrbQ-7Ab-27@gated-at.bofh.it> <6NsB4-2GL-37@gated-at.bofh.it> <6NvSc-1go-31@gated-at.bofh.it>
Date: Fri, 25 Aug 2006 12:40:07 +0100
Message-Id: <20060825114008.4637214C238@irishsea.home.craig-wood.com>
From: nick@craig-wood.com (Nick Craig-Wood)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
>  Ar Iau, 2006-08-24 am 20:51 +0200, ysgrifennodd Krzysztof Halasa:
> > Not sure if we want int, uint, or long long for speed values :-)
> 
>  You want speed_t according to POSIX.

To get non-integral baud rates (of which there are a few but no longer
in common use) you'd probably want to supply a two integers which you
then divide.

This matches most hardware quite well, and for most cases you'd just
supply the divisor as 1.

-- 
Nick Craig-Wood <nick@craig-wood.com> -- http://www.craig-wood.com/nick
