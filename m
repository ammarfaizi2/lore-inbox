Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264147AbTKSW2a (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Nov 2003 17:28:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264153AbTKSW2a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Nov 2003 17:28:30 -0500
Received: from linux-bt.org ([217.160.111.169]:36564 "EHLO mail.holtmann.net")
	by vger.kernel.org with ESMTP id S264147AbTKSW23 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Nov 2003 17:28:29 -0500
Subject: Re: test9 and bluetooth - got it :)
From: Marcel Holtmann <marcel@holtmann.org>
To: Fabio Coatti <cova@ferrara.linux.it>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Arnaldo Carvalho de Melo <acme@conectiva.com.br>
In-Reply-To: <200311192219.02964.cova@ferrara.linux.it>
References: <200311021853.47300.cova@ferrara.linux.it>
	 <200311190052.45803.cova@ferrara.linux.it>
	 <1069239043.4883.125.camel@pegasus>
	 <200311192219.02964.cova@ferrara.linux.it>
Content-Type: text/plain
Message-Id: <1069280879.9473.179.camel@pegasus>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Wed, 19 Nov 2003 23:27:59 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Fabio,

> > another thing to try is to disable the SCO support of the HCI USB driver
> > and in this case it don't uses ISOC transfers.
> 
> Tried it, and it worked. I've plugged and unplugged the usb dongle several 
> times in a row without any crash.
> It seems that you have got the issue.
> 
> I'll keep SCO support disabled for now; I can test whatever you want if you 
> need me to.

I don't wrote the SCO part of the HCI USB driver and I never worked with
USB ISOC transfers. At the moment we don't know if the problem is part
of the USB subsystem or if it is the driver itself, but I suspect it is
the driver. However I am the wrong person to ask for a fix :(

Regards

Marcel


