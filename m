Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315213AbSFYLoM>; Tue, 25 Jun 2002 07:44:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315277AbSFYLoL>; Tue, 25 Jun 2002 07:44:11 -0400
Received: from chaos.analogic.com ([204.178.40.224]:15239 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S315213AbSFYLoK>; Tue, 25 Jun 2002 07:44:10 -0400
Date: Tue, 25 Jun 2002 07:45:35 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Brad Hards <bhards@bigpond.net.au>
cc: Christian Robert <xtian-test@sympatico.ca>, linux-kernel@vger.kernel.org
Subject: Re: gettimeofday problem
In-Reply-To: <200206251043.28051.bhards@bigpond.net.au>
Message-ID: <Pine.LNX.3.95.1020625074319.18426B-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Jun 2002, Brad Hards wrote:

> On Tue, 25 Jun 2002 10:37, Christian Robert wrote:
> >   gettimeofday (&tv, NULL);
> How about checking the return value of the function call?
> 
> Brad
> -- 
> http://conf.linux.org.au. 22-25Jan2003. Perth, Australia. Birds in Black.

I think the only possible error returned would relate to the time-zone
being invalid. The time-zone pointer being a NULL is valid so it isn't
going to return EINVAL.


Cheers,
Dick Johnson

Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).

                 Windows-2000/Professional isn't.

