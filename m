Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266094AbRGMDrq>; Thu, 12 Jul 2001 23:47:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266767AbRGMDrh>; Thu, 12 Jul 2001 23:47:37 -0400
Received: from mauve.demon.co.uk ([158.152.209.66]:62654 "EHLO
	mauve.demon.co.uk") by vger.kernel.org with ESMTP
	id <S266094AbRGMDrW>; Thu, 12 Jul 2001 23:47:22 -0400
From: Ian Stirling <root@mauve.demon.co.uk>
Message-Id: <200107130346.EAA19304@mauve.demon.co.uk>
Subject: Re: Switching Kernels without Rebooting?
To: linux-kernel@vger.kernel.org
Date: Fri, 13 Jul 2001 04:45:58 +0100 (BST)
In-Reply-To: <20010713011144.KYIT26599.femail1.sdc1.sfba.home.com@localhost> from "tas@mindspring.com" at Jul 12, 2001 06:11:20 PM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
>  > I've just suspended to disk after the list line, pulled the power 
> supplies,
>  > taken the RAM chip out, shorted the pins to make really sure, then 
> powered
>  > back up.
> 
> FYI: Taking the memory module out and shorting its pins together is a 
> great way to unnecessarily risk zapping your RAM with ESD, and a 
> terrible way to ensure that its contents are erased.  When the DRAM is 
> not being accessed (by definition true when you remove power), the gate 
> capacitors that form the DRAM array are floating unconnected and cannot 
> be intentionally discharged.  You just have to wait for good old leakage 
> to kill the bits.  A minute should be more than enough.

I know, I observed antistatic precautions, and did wait a couple of minutes
(while making a coffe).
