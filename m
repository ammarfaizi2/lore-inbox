Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317214AbSFBS3V>; Sun, 2 Jun 2002 14:29:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317215AbSFBS3U>; Sun, 2 Jun 2002 14:29:20 -0400
Received: from adsl-66-136-199-111.dsl.austtx.swbell.net ([66.136.199.111]:28803
	"HELO digitalroadkill.net") by vger.kernel.org with SMTP
	id <S317214AbSFBS3T>; Sun, 2 Jun 2002 14:29:19 -0400
Subject: Re: Very big shm area
From: Austin Gonyou <austin@digitalroadkill.net>
To: Kilobug <kilobug@freesurf.fr>
Cc: lkm <linux-kernel@vger.kernel.org>
In-Reply-To: <3CFA5411.3030600@freesurf.fr>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: http://www.digitalroadkill.net
X-Mailer: Ximian Evolution 1.1.0.99 (Preview Release)
Date: 02 Jun 2002 13:28:48 -0500
Message-Id: <1023042528.3021.1.camel@UberGeek>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I run a Dell 6450 with 8GB ram and a 4GB SHMMAX. You can set the
parameter any time through sysctl if you have it enabled, or you can
hardcode it per the Oracle/DB2 Docs if you wish. 

Austin


On Sun, 2002-06-02 at 12:21, Kilobug wrote:
> Hello,
> 	I wanted to know if it is possible to have a very big system V shared 
> memory segment (say about 1Gb) ?
> 
> 	I've quickly looked into the source code of shm.c and shm.h in ipc/ and 
> I've read the following:
> /*
>   * SHMMAX, SHMMNI and SHMALL are upper limits are defaults which can
>   * be increased by sysctl
>   */
> 
> But how far is it possible to increase them ? And which sysctl must be 
> done ?
> 
> Thank you for answering,

