Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279904AbRKVQAj>; Thu, 22 Nov 2001 11:00:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279912AbRKVQAa>; Thu, 22 Nov 2001 11:00:30 -0500
Received: from tux.rsn.bth.se ([194.47.143.135]:18837 "EHLO tux.rsn.bth.se")
	by vger.kernel.org with ESMTP id <S279904AbRKVQAK> convert rfc822-to-8bit;
	Thu, 22 Nov 2001 11:00:10 -0500
Date: Thu, 22 Nov 2001 16:59:55 +0100 (CET)
From: Martin Josefsson <gandalf@marcelothewonderpenguin.com>
To: =?ISO-8859-1?Q?Peter_Kjellstr=F6m?= <cap@nsc.liu.se>
cc: linux-kernel@vger.kernel.org
Subject: Re: anyone got the same problem with DIGITAL 21143 network card ?
In-Reply-To: <Pine.LNX.4.21.0111221620010.25529-100000@mammut.nsc.liu.se>
Message-ID: <Pine.LNX.4.21.0111221650020.17639-100000@tux.rsn.bth.se>
X-message-flag: Get yourself a real mail client! http://www.washington.edu/pine/
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Nov 2001, Peter Kjellström wrote:

Hi Peter.

> I too have the same problem with atleast 2.4.9 and later (I think
> it broke somewhere around 2.4.4). However, in my case there is a fix (not
> a practical one though). Simply pull the ethernet cable out and plug it
> back in again and it starts working.

I've used 2.4.10-ac12 with a D-Link DFE570TX NIC (quad DECchip 21143
tulip) without any problems. Maybe the tulipdriver in -ac is somewhat
diffrent.


> My card is a dlink 500TX detected (2.4.1) like this:
> 
> 
>  Linux Tulip driver version 0.9.13a (January 20, 2001)
>  PCI: Found IRQ 5 for device 00:09.0
>  eth0: Digital DS21143 Tulip rev 65 at 0xbc00, 00:80:C8:F7:14:BA, IRQ 5.

My cards are also DS21143 Tulip rev 65, they are located behind a DECchip
21152 pci-pci bridge but I don't think it matters.

(it's Intel who produces the chips these days but I don't think they have
changed the design)

I've used the vanilla driver in 2.4.10-ac12 and the tulip-ss010402-poll
and tulip-NAPI-011015 drivers and they all work fine with my NIC.

/Martin

Never argue with an idiot. They drag you down to their level, then beat you with experience.

