Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263696AbUCVV53 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Mar 2004 16:57:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263710AbUCVV52
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Mar 2004 16:57:28 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:16590 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S263696AbUCVV5V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Mar 2004 16:57:21 -0500
Date: Mon, 22 Mar 2004 22:57:09 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: Jos Hulzink <jos@hulzink.net>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: OSS: cleanup or throw away
Message-ID: <20040322215709.GT16746@fs.tum.de>
References: <200403221955.52767.jos@hulzink.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200403221955.52767.jos@hulzink.net>
User-Agent: Mutt/1.4.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 22, 2004 at 07:55:52PM +0100, Jos Hulzink wrote:

> Hi,
> 
> While fixing some "deprecated" issues in the OSS drivers, I wondered whether 
> this makes sense, as entire OSS is marked deprecated. Will OSS make it until 
> 2.7, or will it be dropped soon ? (In other words, should I take care of the 
> OSS drivers or not bother about them)

OSS will stay in 2.6 (2.6 is a stable kernel series) but it will most
likely be removed in 2.7.

I wouldn't spend time to fix deprecated warnings in OSS code, such 
cleanups are wasted time for code that will most likely be removed in 
2.7.

> Best regards,
> 
> Jos Hulzink

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

