Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265134AbSK1Dwo>; Wed, 27 Nov 2002 22:52:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265135AbSK1Dwo>; Wed, 27 Nov 2002 22:52:44 -0500
Received: from air-2.osdl.org ([65.172.181.6]:13548 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S265134AbSK1Dwn>;
	Wed, 27 Nov 2002 22:52:43 -0500
Date: Wed, 27 Nov 2002 21:48:54 -0600 (CST)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: <mochel@localhost.localdomain>
To: Martin Waitz <tali@admingilde.org>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] allow to register interfaces after devices
In-Reply-To: <20021126212239.GA1118@admingilde.org>
Message-ID: <Pine.LNX.4.33.0211272147550.22289-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 26 Nov 2002, Martin Waitz wrote:

> hi :)
> 
> 
> i had a problem some of my code that registered a interface for cpu_devclass
> was being run after cpu devices got added to the class.
> 
> current code only adds those devices to the interface that are
> added after registering the interface.
> this patch changes it by walking all devices that are already registered
> to intf->devclass.

Yeah, the interface code has a lot of crap in it. Thanks for the patch; 
I'll integrate it, and be making more changes on top of it.

Thanks,

	-pat

