Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315566AbSEHXt5>; Wed, 8 May 2002 19:49:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315567AbSEHXt4>; Wed, 8 May 2002 19:49:56 -0400
Received: from smtpzilla5.xs4all.nl ([194.109.127.141]:54802 "EHLO
	smtpzilla5.xs4all.nl") by vger.kernel.org with ESMTP
	id <S315566AbSEHXtz>; Wed, 8 May 2002 19:49:55 -0400
Date: Thu, 9 May 2002 01:49:35 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
To: george anzinger <george@mvista.com>
cc: Philippe Troin <phil@fifi.org>, vda@port.imtp.ilyichevsk.odessa.ua,
        Amol Lad <dal_loma@yahoo.com>, linux-kernel@vger.kernel.org
Subject: Re: kill task in TASK_UNINTERRUPTIBLE
In-Reply-To: <3CD9B44F.4A023A70@mvista.com>
Message-ID: <Pine.LNX.4.21.0205090140240.32715-100000@serv>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 8 May 2002, george anzinger wrote:

> > Except for processes accessing NFS files while the NFS server is down:
> > they will be stuck in TASK_UNINTERRUPTIBLE until the NFS server comes
> > back up again.
> 
> A REALLY good argument for puting timeouts on your NSF mounts!  Don't
> leave home without them.

Use "mount -o intr" and you can kill the process.

bye, Roman

