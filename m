Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264489AbRGEV7y>; Thu, 5 Jul 2001 17:59:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264475AbRGEV7o>; Thu, 5 Jul 2001 17:59:44 -0400
Received: from t2.redhat.com ([199.183.24.243]:57078 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S264489AbRGEV7a>; Thu, 5 Jul 2001 17:59:30 -0400
X-Mailer: exmh version 2.3 01/15/2001 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <200107052154.RAA07008@razor.cs.columbia.edu> 
In-Reply-To: <200107052154.RAA07008@razor.cs.columbia.edu> 
To: Hua Zhong <huaz@cs.columbia.edu>
Cc: Davide Libenzi <davidel@xmailserver.org>, linux-kernel@vger.kernel.org
Subject: Re: linux/macros.h(new) and linux/list.h(mod) ... 
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 8bit
Date: Thu, 05 Jul 2001 22:58:53 +0100
Message-ID: <9004.994370333@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


huaz@cs.columbia.edu said:
>  Doesn't it add more overhead?  I think using inline functions are
> much better. 

Why should it add overhead? Even the most naïve compiler ought to generate 
the same code, surely? I must admit I haven't looked hard at the output - 
it didn't even occur to me that it might produce suboptimal code.

>  Yes you have to define it for different types (char, short, int,
> long,  signed/unsigned). 

Unfortunately, this being C means that you can't call them all by the same 
name. If I have to use unsigned_long_max(x,y) I'd rather type it out myself 
:)

--
dwmw2


