Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313932AbSDPWm2>; Tue, 16 Apr 2002 18:42:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313933AbSDPWm1>; Tue, 16 Apr 2002 18:42:27 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:26122 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S313932AbSDPWm1>; Tue, 16 Apr 2002 18:42:27 -0400
Subject: Re: Faster reboots (and a better way of taking crashdumps?)
To: pavel@suse.cz (Pavel Machek)
Date: Tue, 16 Apr 2002 23:59:46 +0100 (BST)
Cc: ebiederm@xmission.com (Eric W. Biederman), andyp@osdl.org (Andy Pfiffer),
        suparna@in.ibm.com, Martin.Bligh@us.ibm.com (Martin J. Bligh),
        linux-kernel@vger.kernel.org (linux-kernel@vger.kernel.org)
In-Reply-To: <20020416100246.A37@toy.ucw.cz> from "Pavel Machek" at Apr 16, 2002 10:02:47 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16xbvO-00011o-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > I totally agree.  Walking the driver tree is exactly what I want.
> > Disabling bus masters is just a quick hack to rule out a DMA killing
> > your linux booting linux.
> 
> Is there easy way to disable all busmasters? It might help suspend-to-disk
> and suspend-to-ram to work well until  proper support is done...

Well there is an impolite way - just flip all the master bits off. How
the device reacts is a more complex question. Really you want to ask each
device to shut up
