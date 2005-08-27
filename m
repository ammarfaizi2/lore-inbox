Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751434AbVH0P5o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751434AbVH0P5o (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Aug 2005 11:57:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751475AbVH0P5o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Aug 2005 11:57:44 -0400
Received: from wproxy.gmail.com ([64.233.184.206]:63241 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751434AbVH0P5n convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Aug 2005 11:57:43 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=E5s5H6rEhqVcM5Ia29Yz17gBZQerxwmIblA5uPGCiebwaZt3tiZSPjBbL7f2ct1ylbuHVqu0Dn+vOKxEKOi2ob6cexUxufc3Df5k55ARZoNKEdvutrSdKuGbUEOnNc8mllM1YcuflJPHiXmB15O47i09btBGNBIZVlJjlF4QrjQ=
Message-ID: <6b5347dc050827085727df49c8@mail.gmail.com>
Date: Sat, 27 Aug 2005 23:57:42 +0800
From: "Sat." <walking.to.remember@gmail.com>
To: Christopher Friesen <cfriesen@nortel.com>
Subject: Re: when or where can the case occur in "linux kernel development " about "kernel preemption"?
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <430F45F8.8020505@nortel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <6b5347dc05082609206ff7a305@mail.gmail.com>
	 <430F45F8.8020505@nortel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2005/8/27, Christopher Friesen <cfriesen@nortel.com>:
> Sat. wrote:
> > the case about kernel preemption as follow :
> >
> > the book said "when a process that has a higher priority than the
> > currenty running process is awakened ".
> >
> > but I can think about when such case can occur , could you give me an example ?
> 
> There may be others, but one common case is when a hardware interrupt
> causes the higher priority process to become runnable.  Some examples of
> this would be a network packet arriving, or the expiry of a hardware timer.
> 
> Chris
> 

unfortunately, I cannot agree with you , normally ,when the kernel
runs in interrupt context , the schedule() should not be invoked 
------my views .

then,could anyone  give me a definite example about network like above
or anything else to eluminate  this , ok?

thanks !

-- 
Sat.
