Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751112AbWB0NdT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751112AbWB0NdT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 08:33:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751151AbWB0NdT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 08:33:19 -0500
Received: from rtr.ca ([64.26.128.89]:18565 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S1751112AbWB0NdT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 08:33:19 -0500
Message-ID: <4402FF89.4070009@rtr.ca>
Date: Mon, 27 Feb 2006 08:32:57 -0500
From: Mark Lord <lkml@rtr.ca>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.1) Gecko/20060130 SeaMonkey/1.0
MIME-Version: 1.0
To: Nick Warne <nick@linicks.net>
Cc: Henrik Persson <root@fulhack.info>, Robert Hancock <hancockr@shaw.ca>,
       Jesper Juhl <jesper.juhl@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: hda: irq timeout: status=0xd0 DMA question
References: <200602261308.47513.nick@linicks.net> <200602261720.34062.nick@linicks.net> <4401EF2C.2000004@fulhack.info> <200602262110.55324.nick@linicks.net>
In-Reply-To: <200602262110.55324.nick@linicks.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Warne wrote:
 >
> As a user we know if DMA is OK on a ide device, right?  Then let user have 
> option to set it permanent, else carry on as the code does now when idex 
> needs a reset.

Does "hdparm -K1 /dev/hda" solve the problem?  That's what that option was
for originally, but I don't know if the IDE driver still uses it correctly.

Cheers
