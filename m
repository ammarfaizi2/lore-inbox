Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267340AbTAQEIs>; Thu, 16 Jan 2003 23:08:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267334AbTAQEIr>; Thu, 16 Jan 2003 23:08:47 -0500
Received: from bitmover.com ([192.132.92.2]:37344 "EHLO mail.bitmover.com")
	by vger.kernel.org with ESMTP id <S267340AbTAQEIq>;
	Thu, 16 Jan 2003 23:08:46 -0500
Date: Thu, 16 Jan 2003 20:17:39 -0800
From: Larry McVoy <lm@bitmover.com>
To: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
Cc: Carl Gherardi <C.Gherardi@curtin.edu.au>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.5.59
Message-ID: <20030117041739.GA15753@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>,
	Carl Gherardi <C.Gherardi@curtin.edu.au>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <8B67F2E2D93ED5118D6E00508BB8D127011C3ED0@exmsb04.curtin.edu.au> <Pine.LNX.4.44.0301162211410.19302-100000@chaos.physics.uiowa.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0301162211410.19302-100000@chaos.physics.uiowa.edu>
User-Agent: Mutt/1.4i
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A little know option which makes things go faster is 

	bk -r get -qS

which gets only those files not already gotten.  Linus has asked why this 
isn't the default and the only reason I can give him is that it is an
interface change and we'll do it in bk 4.0.  It's the right answer.

> 	bk -r get -q
> 
> or just
> 
> 	bk get drivers/eisa
> 
> in this case. I guess this is becoming a FAQ.
> 
> --Kai
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
