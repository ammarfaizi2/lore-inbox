Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316526AbSE3J0i>; Thu, 30 May 2002 05:26:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316528AbSE3J0h>; Thu, 30 May 2002 05:26:37 -0400
Received: from s217-115-138-173.colo.hosteurope.de ([217.115.138.173]:34055
	"HELO mail.cionix.de") by vger.kernel.org with SMTP
	id <S316526AbSE3J0g>; Thu, 30 May 2002 05:26:36 -0400
Message-ID: <1022750361.3cf5ee99434bf@mail.cionix.de>
Date: Thu, 30 May 2002 11:19:21 +0200
From: Jan Schreiber <jan.lists@cionix.de>
Reply-to: js@cionix.de
To: vda@port.imtp.ilyichevsk.odessa.ua
Cc: linux-kernel@vger.kernel.org
Subject: Re: Very High Load on Disk Activity in 2.4.18 (and 2.4.18-pre8)
In-Reply-To: <20020525121737Z314546-22651+55555@vger.kernel.org> <1022329607.3cef83072437b@mail.cionix.de> <200205290719.g4T7JVY25856@Port.imtp.ilyichevsk.odessa.ua>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.1
X-Originating-IP: 217.230.253.151
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

> > I'm experiencing a strange effect. As soons as there is some higher disk
> > activity (untarring the linux kernel is enough, which really should be no
> > problem) the system load gets really high (some times over 10) but the
> CPU
> > is 100% idle (reported by top).
> 
> Which processes aren't sleeping? Look for STAT values other than 'S'
> and/or type 'i' to switch top into no-idle mode.

First i would like to thank you for your answer 

When i do a simple "find / * | grep bla bla" the Load is over 3 after
10 seconds and about 10 after a minute.

I did a "top" and switched to non-idle mode. The only processes that appear
constantly when the load is such high are "kupdated" and "kreiserfsd". Any
ideas?

jan schreiber

