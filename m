Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313060AbSILIMO>; Thu, 12 Sep 2002 04:12:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313070AbSILIMN>; Thu, 12 Sep 2002 04:12:13 -0400
Received: from pc1-cwma1-5-cust128.swa.cable.ntl.com ([80.5.120.128]:30446
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S313060AbSILIMN>; Thu, 12 Sep 2002 04:12:13 -0400
Subject: Re: Linux 2.4.20pre5-ac5
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Tony Spinillo <tspinillo@yahoo.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020912000240.69060.qmail@web14004.mail.yahoo.com>
References: <20020912000240.69060.qmail@web14004.mail.yahoo.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-7) 
Date: 12 Sep 2002 09:17:42 +0100
Message-Id: <1031818662.2902.43.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-09-12 at 01:02, Tony Spinillo wrote:
> I just fired it up an an Asus P4B533-V (845G-Award Medallion Bios
> v6.0) 
> board. Seemed to work well  :) . Full DMA on the DVD drive.
>  
> I took a gamble to see if my old "non-appearing" drives
> problem was fixed, and tried it on the Gigabyte 845IGX
> (845G-Award Modular Bios V6.0PG),  I was not
> as lucky. I think my next board will be an Asus. ;)

Can you try one thing for me on the problem board. Build the PIIX driver
modular, and build with ide task file disabled

Next boot the system (single user read only if you want)- you should get
the drives in basic PIO mode. Then modprobe piix and see if it finds the
drives that way around

