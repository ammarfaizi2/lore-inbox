Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261859AbVGUToa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261859AbVGUToa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Jul 2005 15:44:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261865AbVGUTo3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Jul 2005 15:44:29 -0400
Received: from smtp-vbr8.xs4all.nl ([194.109.24.28]:21518 "EHLO
	smtp-vbr8.xs4all.nl") by vger.kernel.org with ESMTP id S261859AbVGUTnH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Jul 2005 15:43:07 -0400
Date: Thu, 21 Jul 2005 21:42:40 +0200
From: jurriaan <thunder7@xs4all.nl>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Jurriaan <thunder7@xs4all.nl>, linux-kernel@vger.kernel.org
Subject: Re: often ide errors on amd64 / A8N-SLI
Message-ID: <20050721194240.GA30389@amd64.of.nowhere>
Reply-To: Jurriaan <thunder7@xs4all.nl>
References: <20050721172648.GA21124@amd64.of.nowhere> <1121974214.19424.22.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1121974214.19424.22.camel@localhost.localdomain>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Date: Thu, Jul 21, 2005 at 08:30:13PM +0100
> On Iau, 2005-07-21 at 19:26 +0200, jurriaan wrote:
> > hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
> > hda: dma_intr: error=0x84 { DriveStatusError BadCRC }
> 
> There was corruption on the cable between the controller and drive. That
> usually indicates a cable or noise problem in the PC but could indicate
> mistuning of the interface. Make sure the IDE cable is 
> 
>  [controller]<---- long section ----->[slave]--short section-->[master]
> 
> as one common cause is having the cable the other way around.
  
The cable happens to run the correct way, but you've given me a valuable
hint. I was wondering why hda had errors and hdc (which is the same
drive on the second port of the controller) didn't. Perhaps I'll try
another cable.

Thanks,
Jurriaan
-- 
IF MICROSOFT BUILT CARS......
You could only have one person in the car at a time, unless you
bought "Car95" or "CarNT". But, then you would have to buy more
seats.
Debian (Unstable) GNU/Linux 2.6.13-rc3-mm1 5149 bogomips load 1.94
