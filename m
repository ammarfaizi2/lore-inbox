Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264769AbRGEWBE>; Thu, 5 Jul 2001 18:01:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264680AbRGEWAy>; Thu, 5 Jul 2001 18:00:54 -0400
Received: from hose.mail.pipex.net ([158.43.128.58]:26544 "HELO
	hose.mail.pipex.net") by vger.kernel.org with SMTP
	id <S264475AbRGEWAn>; Thu, 5 Jul 2001 18:00:43 -0400
To: linux-kernel@vger.kernel.org
From: Trevor-Hemsley@dial.pipex.com (Trevor Hemsley)
Date: Thu, 05 Jul 2001 21:42:38
Subject: Re: pcmcia lockup inserting or removing cards in 2.4.5-ac{13,22}
X-Mailer: ProNews/2 V1.51.ib104
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <20010705220051Z264475-17720+11254@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 5 Jul 2001 03:06:11, Erik Mouw <J.A.K.Mouw@ITS.TUDelft.NL> 
wrote:

> Hmm, Cardbus and USB problems... you probably have both Cardbus and
> i82365 support in your kernel configuration. 

Once I have the BIOS set to "cardbus/16 bit" instead of "auto-detect" 
I don't have a problem with having both Cardbus and i82365 support 
compiled in. If the BIOS is set to auto then the PCI tables don't have
an IRQ specified and yenta.c uses IRQ 0!

-- 
Trevor Hemsley, Brighton, UK.
Trevor-Hemsley@dial.pipex.com
