Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267050AbTAPMzq>; Thu, 16 Jan 2003 07:55:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267052AbTAPMzq>; Thu, 16 Jan 2003 07:55:46 -0500
Received: from chaos.analogic.com ([204.178.40.224]:3209 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S267050AbTAPMzo>; Thu, 16 Jan 2003 07:55:44 -0500
Date: Thu, 16 Jan 2003 08:06:06 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Gabriel Gomiz <gomita@bblanca.com.ar>
cc: linux-kernel@vger.kernel.org
Subject: Re: NCR 7452/3 POS - Retail CMOS NVRAM Driver
In-Reply-To: <3E25F898.2010704@bblanca.com.ar>
Message-ID: <Pine.LNX.3.95.1030116080150.3536A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Jan 2003, Gabriel Gomiz wrote:

> I say Hi to the greatests hackers!
> 
> 
> The memory chips that NCR uses are:
> 1) NEC D43256BGU - NCR POS Model 7452-1011
>     The chip is 256KB, but NCR says they use only 128KB
> 2) NEC D431000AGW - NCR POS Model 7453-1011
>     The chip is 1MB, but NCR says they use only 128KB
> 
Look in the ethernet drivers for the "bit-banging" routines
used to access NVRAM in the devices. You need to shift bits
in and out of these devices. They are SERIAL ERPROMS. You
can get data sheets by using your favorite search engine
(as I just did).



Cheers,
Dick Johnson
Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).
Why is the government concerned about the lunatic fringe? Think about it.


