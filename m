Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132044AbRDDTd7>; Wed, 4 Apr 2001 15:33:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132042AbRDDTdu>; Wed, 4 Apr 2001 15:33:50 -0400
Received: from chaos.analogic.com ([204.178.40.224]:9089 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S132038AbRDDTdg>; Wed, 4 Apr 2001 15:33:36 -0400
Date: Wed, 4 Apr 2001 15:30:15 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Frank Cornelis <Frank.Cornelis@rug.ac.be>
cc: linux-kernel@vger.kernel.org
Subject: Re: linux 2.4.3 crashed my hard disk
In-Reply-To: <Pine.GSO.4.10.10104042028270.13922-100000@eduserv2.rug.ac.be>
Message-ID: <Pine.LNX.3.95.1010404145007.30656A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 Apr 2001, Frank Cornelis wrote:

> Hey,
> 
> After I did put in /etc/sysconfig/harddisks 
> 	USE_DMA=1
> my system did crash very badly, I guess after my hard disks did wake up
[SNIPPED...]


> 
> BTW: my motherboard runs at 112 Mhz, overclocked, was 100 Mhz.
> Been running this configuration over more than 2 years now without such
> major problems.
> Could this be the cause?
> 
> Frank.

Please don't ever report any errors to linux-kernel if you are running
your machine over-clocked. All you need is to fetch ONE bad instruction
and you can evaporate ALL the data on ALL your hard disks. Think what
happens if a pointer to a structure containing the not-yet-written
to disk blocks gets adjusted to point so some spent email buffer.


Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (799.53 BogoMips).

"Memory is like gasoline. You use it up when you are running. Of
course you get it all back when you reboot..."; Actual explanation
obtained from the Micro$oft help desk.


