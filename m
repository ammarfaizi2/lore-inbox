Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754737AbWKMOSD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754737AbWKMOSD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 09:18:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754738AbWKMOSD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 09:18:03 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:27336 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1754737AbWKMOSA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 09:18:00 -0500
Date: Mon, 13 Nov 2006 14:17:58 +0000 (GMT)
From: James Simmons <jsimmons@infradead.org>
To: Franck Bui-Huu <vagabon.xyz@gmail.com>
cc: Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Linux-fbdev-devel] fbmem: is bootup logo broken for monochrome
 LCD ?
In-Reply-To: <cda58cb80611130153n60579de0w2ebb59b050595b3b@mail.gmail.com>
Message-ID: <Pine.LNX.4.64.0611131415270.25397@pentafluge.infradead.org>
References: <45535C08.5020607@innova-card.com> 
 <Pine.LNX.4.64.0611122138030.9472@pentafluge.infradead.org>
 <cda58cb80611130153n60579de0w2ebb59b050595b3b@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>> There are quite a few bugs in the code. I have a patch I have been working
>> on for some time. The patch does the following:
>> 
>
> I'd like to give your patch a try but have some trouble to apply it
> cleanly. Care to resend it ?

Which tree are you working off ?> The patch is against linus git tree.

>> I.
>>         Merge slow_imageblit and color_imageblit into one function.
>> II.
>>         The same code works on both big endian and little endian machines
>
> Does this suppose to fix this issue I encountered:
>
> http://marc.theaimsgroup.com/?l=linux-kernel&m=116315548626875&w=2

This should fix the problems you reported. I tested this patch on a big 
endian and little endian framebuffer on a little endian machine.

