Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310507AbSCGUeU>; Thu, 7 Mar 2002 15:34:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310512AbSCGUeK>; Thu, 7 Mar 2002 15:34:10 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:9491 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S310507AbSCGUd5>; Thu, 7 Mar 2002 15:33:57 -0500
Subject: Re: 160gb maxtor with promise ultra 100
To: h.lubitz@internet-factory.de (Holger Lubitz)
Date: Thu, 7 Mar 2002 20:48:48 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3C87C6CB.F05C3B96@internet-factory.de> from "Holger Lubitz" at Mar 07, 2002 09:00:11 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16j4oi-0003Y1-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> machine (which is the not so recent 2.4.14) the drives are misdetected
> as only 137gb (of course, no 48 bit support) but otherwise the machine
> works, even with the drives connected to the promise.
> 
> so the situation is - either i use the full 160 gb, but only mdma2 data
> transfer. or i use udma 100, but only 137 gb of the drives. i can't seem
> to have both.

Seems to be the case. Promise posted some driver updates today, which in
part appear to address precisely this issue. It just needs the IDE update
and the promise code merging then hopefully it can be in for 2.4.19
