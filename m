Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317215AbSFBShr>; Sun, 2 Jun 2002 14:37:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317216AbSFBShq>; Sun, 2 Jun 2002 14:37:46 -0400
Received: from holomorphy.com ([66.224.33.161]:51617 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S317215AbSFBShq>;
	Sun, 2 Jun 2002 14:37:46 -0400
Date: Sun, 2 Jun 2002 11:37:21 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Kilobug <kilobug@freesurf.fr>
Cc: lkm <linux-kernel@vger.kernel.org>
Subject: Re: Very big shm area
Message-ID: <20020602183721.GG14918@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Kilobug <kilobug@freesurf.fr>, lkm <linux-kernel@vger.kernel.org>
In-Reply-To: <3CFA5411.3030600@freesurf.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 02, 2002 at 07:21:21PM +0200, Kilobug wrote:
> Hello,
> 	I wanted to know if it is possible to have a very big system V 
> 	shared memory segment (say about 1Gb) ?
> 	I've quickly looked into the source code of shm.c and shm.h in ipc/ 
> 	and I've read the following:
> /*
>  * SHMMAX, SHMMNI and SHMALL are upper limits are defaults which can
>  * be increased by sysctl
>  */
> But how far is it possible to increase them ? And which sysctl must be 
> done ?
> Thank you for answering,

ls /proc/sys/kernel/sh* and the names shouldn't be too tough from there.
I'd be concerned about exercising this code on a virgin 2.4.17 as ISTR
bugfixes for sysv ipc/shm cropping up in later kernel versions, though
I can't say I've tracked this area very closely. Hopefully someone who
does can chime in here and enlighten us both.


Cheers,
Bill
