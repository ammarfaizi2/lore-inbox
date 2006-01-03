Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751140AbWACATS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751140AbWACATS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jan 2006 19:19:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751141AbWACATS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jan 2006 19:19:18 -0500
Received: from smtp3.brturbo.com.br ([200.199.201.164]:50329 "EHLO
	smtp3.brturbo.com.br") by vger.kernel.org with ESMTP
	id S1751140AbWACATR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jan 2006 19:19:17 -0500
Subject: Re: Re; system keeps freezing once every 24 hours / random apps
	crashing
From: Mauro Carvalho Chehab <mchehab@brturbo.com.br>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Peter Missel <peter.missel@onlinehome.de>, video4linux-list@redhat.com,
       Mark v Wolher <trilight@ns666.com>, Jiri Slaby <xslaby@fi.muni.cz>,
       Sami Farin <7atbggg02@sneakemail.com>, jesper.juhl@gmail.com,
       Linux Kernel <linux-kernel@vger.kernel.org>, s0348365@sms.ed.ac.uk,
       rlrevell@joe-job.com, arjan@infradead.org
In-Reply-To: <1136240983.8570.4.camel@localhost.localdomain>
References: <200512310027.47757.s0348365@sms.ed.ac.uk>
	 <20060101191221.7E34322AEAC@anxur.fi.muni.cz> <43B82F87.5010804@ns666.com>
	 <200601020020.12190.peter.missel@onlinehome.de>
	 <1136240983.8570.4.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1
Date: Mon, 02 Jan 2006 22:19:00 -0200
Message-Id: <1136247540.19197.6.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1-1mdk 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Seg, 2006-01-02 às 22:29 +0000, Alan Cox escreveu:
> On Llu, 2006-01-02 at 00:20 +0100, Peter Missel wrote:

> Grab display also stresses the main memory bus and bus arbitration logic
> which caused problems on some older chipsets many of which handled
> overlay mode fine. 

	One common pci quirk is to increase latency timer. You may try to
increase it using an userspace tool (like powertweak or sysctl). 
	Please try to increase latency and give us some feedback. BTTV driver
is capable of using linux/drivers/pci/quirks.c info and honor it.

Cheers, 
Mauro.

