Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264709AbRGEWDe>; Thu, 5 Jul 2001 18:03:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264680AbRGEWDY>; Thu, 5 Jul 2001 18:03:24 -0400
Received: from sncgw.nai.com ([161.69.248.229]:64741 "EHLO mcafee-labs.nai.com")
	by vger.kernel.org with ESMTP id <S264779AbRGEWDL>;
	Thu, 5 Jul 2001 18:03:11 -0400
Message-ID: <XFMail.20010705150624.davidel@xmailserver.org>
X-Mailer: XFMail 1.4.7 on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
In-Reply-To: <200107052154.RAA07008@razor.cs.columbia.edu>
Date: Thu, 05 Jul 2001 15:06:24 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
To: Hua Zhong <huaz@cs.columbia.edu>
Subject: Re: linux/macros.h(new) and linux/list.h(mod) ...
Cc: linux-kernel@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 05-Jul-2001 Hua Zhong wrote:
> 
> Doesn't it add more overhead?  I think using inline functions are much
> better. 
>  Yes you have to define it for different types (char, short, int, long, 
> signed/unsigned).

Yes it does.
Personally I know that min, max, etc... are macros and I never use unary
operators inside.
Maybe a "unsafe" __max() and a "safe" max() could coexist.




- Davide

