Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271708AbRHQRcJ>; Fri, 17 Aug 2001 13:32:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271705AbRHQRbz>; Fri, 17 Aug 2001 13:31:55 -0400
Received: from pD951C5CA.dip.t-dialin.net ([217.81.197.202]:53776 "EHLO
	main.home") by vger.kernel.org with ESMTP id <S271710AbRHQRbk>;
	Fri, 17 Aug 2001 13:31:40 -0400
Message-ID: <3B7D54FC.C9864DEC@gmx.de>
Date: Fri, 17 Aug 2001 19:31:40 +0200
From: thobi <th55@gmx.de>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.6 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: leroyljr@ccsi.com
CC: linux-kernel@vger.kernel.org
Subject: Re: Failure to Compile AIC7xxx Driver
In-Reply-To: <200108170013.f7H0DoO21290@ccsi.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

leroyljr wrote:
> 
> If nobody has brought this up yet, I want to report this issue.
> 
> Here is what happened when I tried to build the aic7xxx driver for 2.4.9:
> 
> aicasm/aicasm_scan.l: In function `yylex':
> aicasm/aicasm_scan.l:115: `T_VERSION' undeclared (first use in this function)
> aicasm/aicasm_scan.l:115: (Each undeclared identifier is reported only once
> aicasm/aicasm_scan.l:115: for each function it appears in.)
> aicasm/aicasm_scan.l:132: `T_STRING' undeclared (first use in this function)

If I remember correctly I got this one when I used bison -y instead of
yacc -
although they are supposed to do the same. 

It's just a guess - correct me if I'm telling crap

 Tobias
