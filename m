Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271843AbRH3Jfv>; Thu, 30 Aug 2001 05:35:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271866AbRH3Jfl>; Thu, 30 Aug 2001 05:35:41 -0400
Received: from sj-msg-core-3.cisco.com ([171.70.157.152]:8345 "EHLO
	sj-msg-core-3.cisco.com") by vger.kernel.org with ESMTP
	id <S271843AbRH3JfW>; Thu, 30 Aug 2001 05:35:22 -0400
Message-ID: <3B8E08B8.F4856A47@cisco.com>
Date: Thu, 30 Aug 2001 15:04:48 +0530
From: Manik Raina <manik@cisco.com>
Organization: Cisco Systems
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.14-12 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: ioctl conflicts
In-Reply-To: <20010828145304Z.haba@pdc.kth.se> <3B8DEF9D.26F7544D@cisco.com> <slrn9ortim.352.kraxel@bytesex.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


If the parameters were the same, we would have the
same number. Even though they go different places,
we would have the same number mapping into different
ioctls. that doesn't look too good.

> The size of the argument has a different size, so they end up with
> different magic numbers because of that.
>
