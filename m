Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133061AbRDRRBN>; Wed, 18 Apr 2001 13:01:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133077AbRDRRBD>; Wed, 18 Apr 2001 13:01:03 -0400
Received: from chaos.analogic.com ([204.178.40.224]:896 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S133061AbRDRRA4>; Wed, 18 Apr 2001 13:00:56 -0400
Date: Wed, 18 Apr 2001 13:00:02 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Dennis <dennis@etinc.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: SMP in 2.4
In-Reply-To: <5.0.2.1.0.20010418110702.03850d20@mail.etinc.com>
Message-ID: <Pine.LNX.3.95.1010418125641.363A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Apr 2001, Dennis wrote:

> Does 2.4 have something similar to spl levels or does it still require the 
> ridiculous MS-DOSish spin-locks to protect every bit of code?
> 
> DB

This must be a Troll. MS-DOS didn't have spin-locks and, when you
have multiple CPUs with one interrupt controller, you don't have
much choice. You either use spin-locks or you Blue-Screen.

Since Linux doesn't have a "Blue-screen of death", it needs spin-
locks.

Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (799.53 BogoMips).

"Memory is like gasoline. You use it up when you are running. Of
course you get it all back when you reboot..."; Actual explanation
obtained from the Micro$oft help desk.


