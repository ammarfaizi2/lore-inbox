Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316897AbSHONZR>; Thu, 15 Aug 2002 09:25:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316898AbSHONZR>; Thu, 15 Aug 2002 09:25:17 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:52731 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S316897AbSHONZQ>; Thu, 15 Aug 2002 09:25:16 -0400
Subject: Re: promise ultra 133 tx2 lets system standby during use...?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Thomas Munck Steenholdt <tmus@get2net.dk>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200208151227.g7FCR8P03099@eday-fe9.tele2.ee>
References: <200208151227.g7FCR8P03099@eday-fe9.tele2.ee>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 15 Aug 2002 14:27:39 +0100
Message-Id: <1029418059.29816.30.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-08-15 at 13:27, Thomas Munck Steenholdt wrote:
> OK, I'll try the apm=off first to see if that resolves my problem...
> are there any examples/places to look if i decided to update the
> APM monitor list from linux? Anywhere I could get an idea of how that
> could be done?
> I don't know the chipset atm.

lspci will tell you the chipset identifiers. Generally the first few
listed devices are the chipset itself (00:00.0 is the north bridge, then
the other stuff follows).

