Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263286AbTC0QP7>; Thu, 27 Mar 2003 11:15:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263290AbTC0QP6>; Thu, 27 Mar 2003 11:15:58 -0500
Received: from [170.210.46.46] ([170.210.46.46]:37125 "EHLO
	scdt.frc.utn.edu.ar") by vger.kernel.org with ESMTP
	id <S263286AbTC0QPc> convert rfc822-to-8bit; Thu, 27 Mar 2003 11:15:32 -0500
Content-Type: text/plain;
  charset="iso-8859-1"
From: Edgardo Hames <ehames@scdt.frc.utn.edu.ar>
Organization: UTN
To: root@chaos.analogic.com
Subject: Re: Error accessing memory between 0xc0000 and 0x100000
Date: Thu, 27 Mar 2003 13:25:30 -0300
User-Agent: KMail/1.4.1
Cc: linux-kernel@vger.kernel.org
References: <200303251308.36565.ehames@scdt.frc.utn.edu.ar> <Pine.LNX.4.53.0303251119420.29139@chaos>
In-Reply-To: <Pine.LNX.4.53.0303251119420.29139@chaos>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200303271325.30514.ehames@scdt.frc.utn.edu.ar>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

El Mar 25 Mar 2003 13:21, Richard B. Johnson escribió:

> On Tue, 25 Mar 2003, Edgardo Hames wrote:
> > Hi everybody. I'm trying to write a simple device driver to read and
> > write memory at addresses beween 0xc0000 and 0x100000, but when I try to
> > load the module I get the following error:
>
> Check out ioremap(). Although the addresses you show are already
> mapped, you need to access them with the "cookie" returned from
> ioremap().

I tried ioremap'ing the addresses and now it doesn't oops, but I keep reading 
255 no matter what I write to that address. I have no device at that 
addresses, but what I'm trying to do is reading and writing to that memory 
area like it was a file.

Thanks,
Edgardo
-- 
If you cannot convince them, confuse them.
Truman's Law

