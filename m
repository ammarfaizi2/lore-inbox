Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261219AbVBLXxG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261219AbVBLXxG (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Feb 2005 18:53:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261221AbVBLXxG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Feb 2005 18:53:06 -0500
Received: from gate.crashing.org ([63.228.1.57]:62679 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261219AbVBLXxC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Feb 2005 18:53:02 -0500
Subject: Re: 2.6.11-rc3-bk9 (radeon) hangs hard my laptop
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Alessandro Suardi <alessandro.suardi@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <5a4c581d050212135716fa6a17@mail.gmail.com>
References: <5a4c581d0502120649423a2504@mail.gmail.com>
	 <5a4c581d05021207593fae0c93@mail.gmail.com>
	 <5a4c581d050212135716fa6a17@mail.gmail.com>
Content-Type: text/plain
Date: Sun, 13 Feb 2005 21:52:55 +1100
Message-Id: <1108291975.6698.7.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> It's definitely the new radeon changes - replacing
>  drivers/video/aty/* and include/video/radeon.h in the
>  -bk9 tree with the ones from -bk8 causes the hang to
>  not reproduce anymore. CC'd Ben and edited subject
>  to more accurately reflect the issue.

Grrr... 

Can you try booting with radeonfb.default_dynclk=-1 and if it doesn't
help, radeonfb.default_dynclk=0 on the kernel command line ?

Also, what is the exact revision of the chip ? (send me an lspci -vv
dump).

Finally, what X version are you using ?

Ben.


