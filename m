Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313130AbSC1K7z>; Thu, 28 Mar 2002 05:59:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313131AbSC1K7q>; Thu, 28 Mar 2002 05:59:46 -0500
Received: from mail.loewe-komp.de ([62.156.155.230]:18186 "EHLO
	mail.loewe-komp.de") by vger.kernel.org with ESMTP
	id <S313130AbSC1K7a>; Thu, 28 Mar 2002 05:59:30 -0500
Message-ID: <3CA2F78C.1060604@loewe-komp.de>
Date: Thu, 28 Mar 2002 11:59:24 +0100
From: Peter =?ISO-8859-1?Q?W=E4chtler?= <pwaechtler@loewe-komp.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4) Gecko/20010923
X-Accept-Language: de, en
MIME-Version: 1.0
To: Robert Schwebel <robert@schwebel.de>
CC: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: Networking with slow CPUs
In-Reply-To: <Pine.LNX.4.33.0203271944020.16178-100000@callisto.local>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Schwebel wrote:

> Hi,
> 
> in the 2.2 series there was a switch for "CPU is too slow to handle full
> bandwidth" which has gone in 2.4. Can anybody tell me the reason for this?
> 
> Is there a possibility to "harden" a small machine (33 MHz embedded
> device) against e.g. flood pings from the outside world?
> 

AFAIK, there is a mechanism to switch off the interrupts generated
by the network card, if the load is getting too high. This way the
packets get overwritten on the nic buffers and do not even reach
the CPU.

I don't know if this is implemented (in all drivers?)

