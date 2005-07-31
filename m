Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261602AbVGaEZw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261602AbVGaEZw (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Jul 2005 00:25:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261606AbVGaEZw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Jul 2005 00:25:52 -0400
Received: from smtp.enter.net ([216.193.128.24]:23557 "EHLO smtp.enter.net")
	by vger.kernel.org with ESMTP id S261602AbVGaEZu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Jul 2005 00:25:50 -0400
From: "D. ShadowWolf" <dhazelton@enter.net>
To: linux-kernel@vger.kernel.org
Subject: Re: inter_module_get and __symbol_get
Date: Sun, 31 Jul 2005 00:27:18 -0400
User-Agent: KMail/1.7.2
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200507310027.18484.dhazelton@enter.net>
X-Virus-Checker-Version: Enter.Net Virus Scanner 1.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On this topic I have to weigh in that I just subscribed to the kernel list 
because I have had to undo a modification made to the kernel around version 
2.6.10 that stopped the export of 'inter_module_get'.  To me it appears that 
some kernel developers forget that there are those of us out there who do not 
have broadband connections and are shafted with low-end hardware. In this 
case I am currently stuck using a Lucent Winmodem to connect to the internet.
The need to undo that patch arose when I upgraded to 2.6.12.3 and found that 
the drivers provided by the linmodem project were dependant on that function. 
If the new system has been targeted at only GPL symbols, then I am certain it 
is definately not something good for the kernel.

I enjoy GPL'd software as much as the next guy, but forgetting that there are 
people in the world dependant on third-party drivers that may or may not have 
a non-GPL license attached to them shows short-sightedness on the part of the 
people involved. 

I have my own issues with the modem I'm currently using, and with the fact 
that Lucent sits behind a wall of NDA's and other legal documents and refuses 
to release the entire source of the driver, instead making us rely on a 
driver that has a precompiled binary as part of it's source. I'm certain 
there are people that could reverse engineer the binary (I could do it 
myself), but with the current state of the law in the US and abroad doing so 
could  cause major legal troubles.

Well... enough rambling. I've used too much bandwidth as it is.

DRH
