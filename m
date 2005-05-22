Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261792AbVEVMPj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261792AbVEVMPj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 May 2005 08:15:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261795AbVEVMPj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 May 2005 08:15:39 -0400
Received: from rproxy.gmail.com ([64.233.170.207]:24452 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261794AbVEVMPd convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 May 2005 08:15:33 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=YC61w0ap/WAA6QUnMnuh25yYulTM6BeSPZlAVzUYpcw6lmwvcdaZ9XX8huPDZyaegJ9/j41JGhL4DJ1rFRa2zG4qpzMAkk8kEm9sXFSs8DSCglZlLrLkThg7P1I2EQnt9J3N6Id0X5MIlvv0nOq11sWHxnk2nD4bzWJJKtxOLcw=
Message-ID: <25381867050522051524ea93ec@mail.gmail.com>
Date: Sun, 22 May 2005 08:15:33 -0400
From: Yani Ioannou <yani.ioannou@gmail.com>
Reply-To: Yani Ioannou <yani.ioannou@gmail.com>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Subject: Re: [lm-sensors] [PATCH 2.6.12-rc4 15/15] drivers/i2c/chips/adm1026.c: use dynamic sysfs callbacks
Cc: Jean Delvare <khali@linux-fr.org>, Greg KH <greg@kroah.com>,
       LKML <linux-kernel@vger.kernel.org>,
       LM Sensors <lm-sensors@lm-sensors.org>
In-Reply-To: <200505220204.52907.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050519213551.GA806@kroah.com>
	 <200505212058.14851.dtor_core@ameritech.net>
	 <20050522085026.40e73d49.khali@linux-fr.org>
	 <200505220204.52907.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/22/05, Dmitry Torokhov <dtor_core@ameritech.net> wrote:
> On Sunday 22 May 2005 01:50, Jean Delvare wrote:
> > Hi Dmitry,
> >
> > > I really think that as far as I2C subsystem goes instead of creating
> > > arrays of attributes we should move in direction of drivers
> > > registering individual sensor class devices. So for example it87 would
> > > register 3 fans, 3 temp, sensors and 8 voltage sensors...

Well lets see some code ;-), but yeah I have to agree with Jean here,
I don't see a nice way to standardize this across all hwmon drivers,
things just differ too much.

> > First, it's a matter of hardware monitoring drivers, not i2c subsystem
> > (both are tightly binded at the moment but I'd like this to change).

How is that change going anyway? I could really do with something
finalized, but the last I heard about it was Mark Hoffman's patch and
that didn't seem to go anywhere.

Yani
