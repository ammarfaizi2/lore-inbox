Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261229AbVBMB00@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261229AbVBMB00 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Feb 2005 20:26:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261230AbVBMB00
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Feb 2005 20:26:26 -0500
Received: from gate.crashing.org ([63.228.1.57]:42968 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261229AbVBMB0X (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Feb 2005 20:26:23 -0500
Subject: Re: 2.6.11-rc3-bk9 (radeon) hangs hard my laptop
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Alessandro Suardi <alessandro.suardi@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <5a4c581d0502121705276972a@mail.gmail.com>
References: <5a4c581d0502120649423a2504@mail.gmail.com>
	 <5a4c581d05021207593fae0c93@mail.gmail.com>
	 <5a4c581d050212135716fa6a17@mail.gmail.com>
	 <1108291975.6698.7.camel@gaston>
	 <5a4c581d05021216095ec00bf9@mail.gmail.com>
	 <1108293146.6700.10.camel@gaston>
	 <5a4c581d0502121705276972a@mail.gmail.com>
Content-Type: text/plain
Date: Sun, 13 Feb 2005 23:26:11 +1100
Message-Id: <1108297571.6700.20.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2005-02-13 at 02:05 +0100, Alessandro Suardi wrote:

> Commenting out pllCLK_PWRMGT_CNTL alone -> still hangs
> Commenting out pllCLK_PIN_CNTL in addition -> works
>  
> Do you want me to build a kernel with only the pllCLK_PIN_CNTL
>  instruction commented out or is this enough info ?

You mean you commented out the OUTPLL call ? Ok, what if
you only change pllCLK_PIN_CNTL? Also, try not changing it, but
commenting out some other bits ? (I'm especially the bits that touch
SCLK_CNTL). Sorry for all those tests, but I need to point more
precisely where the problem comes from...

Ben.


