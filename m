Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319265AbSHNSjM>; Wed, 14 Aug 2002 14:39:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319266AbSHNSjM>; Wed, 14 Aug 2002 14:39:12 -0400
Received: from chaos.analogic.com ([204.178.40.224]:1152 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S319265AbSHNSjM>; Wed, 14 Aug 2002 14:39:12 -0400
Date: Wed, 14 Aug 2002 14:43:01 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: jt@hpl.hp.com
cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: Problem : can't make pipe non-blocking on 2.5.X
In-Reply-To: <20020814181902.GA24047@bougret.hpl.hp.com>
Message-ID: <Pine.LNX.3.95.1020814143548.137A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Aug 2002, Jean Tourrilhes wrote:

> 
>   pipe(trigger_pipe);
> 
    if((flags = fcntl(trigger_pipe[0], F_GETFL)) != -1);
       flags &= ~O_NDELAY;
    fcntl(trigger_pipe[0], F_SETFL, flags);
 

Cheers,
Dick Johnson
Penguin : Linux version 2.4.19 on an i686 machine (797.90 BogoMips).
The US military has given us many words, FUBAR, SNAFU, now ENRON.
Yes, top management were graduates of West Point and Annapolis.

