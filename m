Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317123AbSFBGGG>; Sun, 2 Jun 2002 02:06:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317133AbSFBGGF>; Sun, 2 Jun 2002 02:06:05 -0400
Received: from postfix2-1.free.fr ([213.228.0.9]:59617 "EHLO
	postfix2-1.free.fr") by vger.kernel.org with ESMTP
	id <S317123AbSFBGGF>; Sun, 2 Jun 2002 02:06:05 -0400
Message-Id: <200206020603.g5263u005548@colombe.home.perso>
Date: Sun, 2 Jun 2002 08:03:53 +0200 (CEST)
From: fchabaud@free.fr
Reply-To: fchabaud@free.fr
Subject: Re: Looking for suggestion - kernel panic: root fs not mounted
To: Liz.C.Lee@trw.com
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3CF9A518.FB6A3AFF@trw.com>
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le  1 Jui, Liz C. Lee a écrit :
> Hi,
> 
> I rebuilt a Red Hat 7.3 kernel.  When I tried to bring it up, the kernel
> panicked complaining root fs not mounted.
> 
> I need to know why the file system is not mounted and where to look for.
> 
> Thanks.
> 
> Liz
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

You probably forgot to include your filesystem in kernel. Or your
previous configuration used an initrd and you forgot to set it up also.

--
Florent Chabaud
http://www.ssi.gouv.fr | http://fchabaud.free.fr

