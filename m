Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317552AbSHCMbp>; Sat, 3 Aug 2002 08:31:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317559AbSHCMbo>; Sat, 3 Aug 2002 08:31:44 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:26609 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S317552AbSHCMbo>; Sat, 3 Aug 2002 08:31:44 -0400
Subject: Re: modem support under Linux
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Robert Love <rml@tech9.net>
Cc: Hell.Surfers@cwctv.net, linux-kernel@vger.kernel.org
In-Reply-To: <1028332468.14922.905.camel@sinai>
References: <003813645230282DTVMAIL2@smtp.cwctv.net> 
	<1028332468.14922.905.camel@sinai>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 03 Aug 2002 14:52:58 +0100
Message-Id: <1028382778.31718.45.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2002-08-03 at 00:54, Robert Love wrote:
> In the kernel, modems are handled by the serial driver (drivers/serial/)
> or some PCI/winmodem cruft that emulates a serial driver.

One or two people did it like that. That doesn't mean its the right
approach. You can run the modem stack in user space which is easier to
debug and nicer to work with and use ptys to provide the virtual serial
driver

