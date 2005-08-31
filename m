Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932299AbVHaAMW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932299AbVHaAMW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Aug 2005 20:12:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932301AbVHaAMW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Aug 2005 20:12:22 -0400
Received: from rproxy.gmail.com ([64.233.170.207]:10467 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932299AbVHaAMW convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Aug 2005 20:12:22 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=GXruYW6tipd+V58DUj30dd23evjR7Fmn6GcSvG/nmBGAmFaXwYgDUeRYD7h0RpEPyG64s/M3BpCyzETAUVRTx71Wkdk3+YzN9ufu0dWrQ5A8qUJQvWmYgi1beTTGieMd4fu2YA/l/bI7X4fBtnkHvCXTGxyY5pYSK+dticHjnp8=
Message-ID: <2538186705083017121bf2d3d4@mail.gmail.com>
Date: Tue, 30 Aug 2005 20:12:19 -0400
From: Yani Ioannou <yani.ioannou@gmail.com>
To: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
Subject: Re: [patch] IBM HDAPS accelerometer driver.
Cc: Pavel Machek <pavel@ucw.cz>,
       Oliver Neukum <neukum@fachschaft.cup.uni-muenchen.de>,
       Robert Love <rml@novell.com>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.62.0508301928260.17275@artax.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <1125069494.18155.27.camel@betsy>
	 <20050827124148.GE1109@openzaurus.ucw.cz>
	 <Pine.LNX.4.62.0508280453320.13233@artax.karlin.mff.cuni.cz>
	 <20050828080959.GB2039@elf.ucw.cz>
	 <Pine.LNX.4.62.0508282109040.1489@artax.karlin.mff.cuni.cz>
	 <20050829083552.GD28077@elf.ucw.cz>
	 <Pine.LNX.4.58.0508291057400.27754@fachschaft.cup.uni-muenchen.de>
	 <20050829091038.GA30073@elf.ucw.cz>
	 <Pine.LNX.4.62.0508301928260.17275@artax.karlin.mff.cuni.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please refer to my IDE freeze patch last week:

http://lkml.org/lkml/2005/8/25/140

It provides userspace with a method to freeze the queue and park the
head (through sysfs), along with a timeout to unfreeze, and works
quite well. It is in the process of being moved to the block layer
however so that implementation for libata will be simpler.

Yani
