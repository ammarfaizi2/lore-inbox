Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317786AbSHHS33>; Thu, 8 Aug 2002 14:29:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317861AbSHHS33>; Thu, 8 Aug 2002 14:29:29 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:31983 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S317786AbSHHS31>; Thu, 8 Aug 2002 14:29:27 -0400
Subject: Re: Layered Driver Support in Linux ?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Tom Sanders <developer_linux@yahoo.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020808181602.27210.qmail@web12902.mail.yahoo.com>
References: <20020808181602.27210.qmail@web12902.mail.yahoo.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 08 Aug 2002 20:53:12 +0100
Message-Id: <1028836392.28883.67.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-08-08 at 19:16, Tom Sanders wrote:
> Does Linux support layered drivers ?
> 
> I want to write a driver that will take requests from
> the applications and will pass them on to underlying
> SD disk driver. For this I need to map open, close,
> read, write, ioctl etc entry points to corresponding
> functions of the underlying driver.

Two examples we have are

loop	-	maps a file as a device
md	-	a software implemented raid layer

