Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316750AbSHOK5F>; Thu, 15 Aug 2002 06:57:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316753AbSHOK5F>; Thu, 15 Aug 2002 06:57:05 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:22011 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S316750AbSHOK5E>; Thu, 15 Aug 2002 06:57:04 -0400
Subject: Re: promise ultra 133 tx2 lets system standby during use...?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Thomas Munck Steenholdt <tmus@get2net.dk>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200208151021.g7FALJf08062@eday-fe5.tele2.ee>
References: <200208151021.g7FALJf08062@eday-fe5.tele2.ee>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 15 Aug 2002 11:59:25 +0100
Message-Id: <1029409165.29816.3.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-08-15 at 11:21, Thomas Munck Steenholdt wrote:
> I've been having a lot of problems with my Ultra 133 TX2 controller,
> that if I boot my system a just doesn't touch it for a while, the system
> suspends to complete standby, even though the ext3 data is committed
> every 5 secs. causing disk activity and thus should disallow standby
> behaviour (at least that's the way it works on my onboard controller).

Lots of BIOSes are not bright enough to monitor a second IDE controller.
You should be able to frob in the APM/ACPI bios and add its IRQ line to
the monitor list

