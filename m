Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262755AbVAQJ7W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262755AbVAQJ7W (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jan 2005 04:59:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262757AbVAQJ7V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jan 2005 04:59:21 -0500
Received: from tim.rpsys.net ([194.106.48.114]:58783 "EHLO tim.rpsys.net")
	by vger.kernel.org with ESMTP id S262755AbVAQJ5F (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jan 2005 04:57:05 -0500
Message-ID: <00d501c4fc7a$76ef9940$0f01a8c0@max>
From: "Richard Purdie" <rpurdie@rpsys.net>
To: "Pierre Ossman" <drzeus-list@drzeus.cx>
Cc: "Russell King" <rmk+lkml@arm.linux.org.uk>, "Ian Molton" <spyro@f2s.com>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       "Alan Cox" <alan@lxorguk.ukuu.org.uk>
References: <021901c4f8eb$1e9cc4d0$0f01a8c0@max> <20050112214345.D17131@flint.arm.linux.org.uk> <023c01c4f8f3$1d497030$0f01a8c0@max> <20050112221753.F17131@flint.arm.linux.org.uk> <41E5B177.4060307@f2s.com> <41E7AF11.6030005@drzeus.cx> <41E7DD5E.5070901@f2s.com> <41EA5C8D.8070407@drzeus.cx> <41EA69F0.5060500@f2s.com> <41EAC3FD.1070001@drzeus.cx> <047701c4fc21$a1579b50$0f01a8c0@max> <41EB5610.1080708@drzeus.cx>
Subject: Re: MMC Driver RFC
Date: Mon, 17 Jan 2005 09:53:51 -0000
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=response
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.2527
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2527
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pierre Ossman:
> I fail to see what this delay does. A few lines further down you have a 
> mmc_delay which you have removed. That delay was added just to give slow 
> cards enough time to power up.

I hadn't realised that delay had been added. It wasn't present in the older 
code I was working against and when I upgraded, I've failed to notice it had 
been added. Adding that will solve all the problems I was seeing.

> I, personally, would really like to see SD support included in the main 
> kernel. But I can also fully understand if that's not currently possible.

I think the way forward is for someone to propose a patch. Your code sounds 
the most advanced but Ian or myself may be prepared to propose something if 
you don't want to. A decision can then be made about whether it can be 
accepted. There have been no objections raised so far - just words of 
caution.

Richard 

