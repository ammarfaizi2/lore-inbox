Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280426AbRJaTO3>; Wed, 31 Oct 2001 14:14:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280430AbRJaTOR>; Wed, 31 Oct 2001 14:14:17 -0500
Received: from chaos.analogic.com ([204.178.40.224]:15233 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S280426AbRJaTOH>; Wed, 31 Oct 2001 14:14:07 -0500
Date: Wed, 31 Oct 2001 14:14:40 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Gerhard Mack <gmack@innerfire.net>
cc: Andreas Dilger <adilger@turbolabs.com>,
        Tim Schmielau <tim@physik3.uni-rostock.de>,
        vda <vda@port.imtp.ilyichevsk.odessa.ua>, linux-kernel@vger.kernel.org
Subject: Re: [Patch] Re: Nasty suprise with uptime
In-Reply-To: <Pine.LNX.4.10.10110311056430.6571-100000@innerfire.net>
Message-ID: <Pine.LNX.3.95.1011031141239.20901A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 31 Oct 2001, Gerhard Mack wrote:

> Why exactly do we use the jiffie count for calculating uptime?  Why not
> just record the startup time and compare when needed?
> 
> 
> 	Gerhard
> 
Because you get it for free. The counter is necessary for time-outs
so you need it. If it starts at zero, you get uptime in HZ.

Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (799.53 BogoMips).

    I was going to compile a list of innovations that could be
    attributed to Microsoft. Once I realized that Ctrl-Alt-Del
    was handled in the BIOS, I found that there aren't any.


