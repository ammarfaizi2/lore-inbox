Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264837AbRGEWVR>; Thu, 5 Jul 2001 18:21:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264917AbRGEWVH>; Thu, 5 Jul 2001 18:21:07 -0400
Received: from cs.columbia.edu ([128.59.16.20]:34503 "EHLO cs.columbia.edu")
	by vger.kernel.org with ESMTP id <S264837AbRGEWUy> convert rfc822-to-8bit;
	Thu, 5 Jul 2001 18:20:54 -0400
Message-Id: <200107052220.SAA07341@razor.cs.columbia.edu>
X-Mailer: exmh version 2.1.1 10/15/1999
To: David Woodhouse <dwmw2@infradead.org>
cc: Hua Zhong <huaz@cs.columbia.edu>, Davide Libenzi <davidel@xmailserver.org>,
        linux-kernel@vger.kernel.org
Subject: Re: linux/macros.h(new) and linux/list.h(mod) ... 
In-Reply-To: Your message of "Thu, 05 Jul 2001 22:58:53 BST."
             <9004.994370333@redhat.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Mime-Version: 1.0
Content-Transfer-Encoding: 8BIT
Date: Thu, 05 Jul 2001 18:20:54 -0400
From: Hua Zhong <huaz@cs.columbia.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-> From David Woodhouse <dwmw2@infradead.org> :
> 
> huaz@cs.columbia.edu said:
> >  Doesn't it add more overhead?  I think using inline functions are
> > much better. 
> 
> Why should it add overhead? Even the most naïve compiler ought to generate 
> the same code, surely? I must admit I haven't looked hard at the output - 
> it didn't even occur to me that it might produce suboptimal code.

right, gcc -O2 does produce the same code (but -O does not).

> 
> >  Yes you have to define it for different types (char, short, int,
> > long,  signed/unsigned). 
> 
> Unfortunately, this being C means that you can't call them all by the same 
> name. If I have to use unsigned_long_max(x,y) I'd rather type it out myself 
> :)

Oops, I must be sleeping at that time :-)
 
> --
> dwmw2
> 
> 


