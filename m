Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315282AbSFDRoe>; Tue, 4 Jun 2002 13:44:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315293AbSFDRod>; Tue, 4 Jun 2002 13:44:33 -0400
Received: from air-2.osdl.org ([65.201.151.6]:33414 "EHLO geena.pdx.osdl.net")
	by vger.kernel.org with ESMTP id <S315282AbSFDRob>;
	Tue, 4 Jun 2002 13:44:31 -0400
Date: Tue, 4 Jun 2002 10:40:31 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: <mochel@geena.pdx.osdl.net>
To: Martin Dalecki <dalecki@evision-ventures.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: device model documentation 1/3
In-Reply-To: <3CFCE09B.6090007@evision-ventures.com>
Message-ID: <Pine.LNX.4.33.0206041040090.654-100000@geena.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > 	int	(*bind)		(struct device * dev, struct device_driver * drv);
> > };
> > 
> 
> Please - Why do you call it bind? Does it have something with
> netowrking to do? Please just name it attach. This way the old UNIX
> guys among us won't have to drag a too big
> "UNIX to Linux translation dictionary" around with them.
> As an "added bonus" you will stay consistent with -
> 
> PCMCIA code base in kernel
> USB code base in kernel
> IDE code base (well recently)

Ok, I can live with that.

	-pat

