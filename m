Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261226AbVEBMYi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261226AbVEBMYi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 May 2005 08:24:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261232AbVEBMYi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 May 2005 08:24:38 -0400
Received: from tim.rpsys.net ([194.106.48.114]:64941 "EHLO tim.rpsys.net")
	by vger.kernel.org with ESMTP id S261224AbVEBMYe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 May 2005 08:24:34 -0400
Message-ID: <015d01c54f11$e5f3ddd0$0f01a8c0@max>
From: "Richard Purdie" <rpurdie@rpsys.net>
To: "Bartlomiej Zolnierkiewicz" <bzolnier@gmail.com>
Cc: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       "Dominik Brodowski" <linux@brodo.de>, "Andrew Morton" <akpm@osdl.org>,
       <linux-ide@vger.kernel.org>
References: <03be01c54e77$83d86980$0f01a8c0@max> <58cb370e0505011141a2b3c58@mail.gmail.com>
Subject: Re: IDE problems in 2.6.12-rc1-bk1 onwards (was Re: 2.6.12-rc3-mm1)
Date: Mon, 2 May 2005 13:24:29 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.2527
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2527
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bartlomiej Zolnierkiewicz:
> Both problems should be fixed by "convert IDE device drivers to
> driver-model" patch but I need to resync it against latest kernels.

Thanks for the tip. I found that patch and applied the parts for the drivers 
I use. This cured the oops and also allowed "hot unplugging" to finally work 
under 2.6 for CF cards! Is there a timeline for when this goes into mainline 
and/or -mm?

I can still get an oops from the vfs layer if I try to access a card just 
after I remove it suggesting there are some timeout issues somewhere but 
this is a *massive* improvement on where things were before! I'm really 
pleased to see this :)

Thanks,

Richard 

