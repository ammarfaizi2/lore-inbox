Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278368AbRJOVjv>; Mon, 15 Oct 2001 17:39:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278360AbRJOVjl>; Mon, 15 Oct 2001 17:39:41 -0400
Received: from mk-smarthost-1.mail.uk.worldonline.com ([212.74.112.71]:62212
	"EHLO mk-smarthost-1.mail.uk.worldonline.com") by vger.kernel.org
	with ESMTP id <S278368AbRJOVjb>; Mon, 15 Oct 2001 17:39:31 -0400
X-Mailer: exmh version 2.1.1 10/15/1999 (debian)
To: "John Nilsson" <pzycrow@hotmail.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: IDE Controller for toshiba laptops? 
In-Reply-To: Message from "John Nilsson" <pzycrow@hotmail.com> 
   of "Mon, 15 Oct 2001 22:04:09 +0200." <F226kyCKDkb9pPFR6sK00006c06@hotmail.com> 
In-Reply-To: <F226kyCKDkb9pPFR6sK00006c06@hotmail.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 15 Oct 2001 22:37:37 +0100
From: Jonathan Buzzard <jonathan@buzzard.org.uk>
Message-Id: <E15tFQX-0000DU-00@happy.buzzard.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



pzycrow@hotmail.com said:
> Is anyone working on a driver for the ide-conttoller on the toshiba
> laptops? 

This does not make any sense. There is no concept of a Toshiba
specific IDE controller. For example my laptop a Tecra 780DVD
from lspci I get

00:05.1 IDE interface: Intel Corporation 82371AB PIIX4 IDE (rev 01)

Typically all the laptops supported by the Toshiba SMM mode driver
are all Intel based controllers, or if the laptop is really old are
generic basic IDE controllers.

The laptops not supported by the Toshiba SMM mode driver are all
Texas Instruments chipset IDE controllers as far as I am aware.

What makes you suspect that there is such a thing as a Toshiba
IDE controller?

JAB.

-- 
Jonathan A. Buzzard                 Email: jonathan@buzzard.org.uk
Northumberland, United Kingdom.       Tel: +44(0)1661-832195


