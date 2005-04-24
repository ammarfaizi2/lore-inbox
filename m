Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262288AbVDXIl2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262288AbVDXIl2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Apr 2005 04:41:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262289AbVDXIl1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Apr 2005 04:41:27 -0400
Received: from mail.gmx.net ([213.165.64.20]:8324 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S262288AbVDXIlO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Apr 2005 04:41:14 -0400
X-Authenticated: #14349625
Message-Id: <5.2.1.1.2.20050424101947.00beb8d0@pop.gmx.net>
X-Mailer: QUALCOMM Windows Eudora Version 5.2.1
Date: Sun, 24 Apr 2005 10:40:51 +0200
To: Jesper Juhl <juhl-lkml@dif.dk>, mbellett@cs.unibo.it
From: Mike Galbraith <efault@gmx.de>
Subject: Re: PROBLEM: Kernel BUG() in exit.c in ptrace/pthread
  interaction
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.62.0504240400040.2474@dragon.hyggekrogen.localh
 ost>
References: <20050424014834.GA31463@cs.unibo.it>
 <20050424014834.GA31463@cs.unibo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
X-Antivirus: avast! (VPS 0516-7, 04/22/2005), Outbound message
X-Antivirus-Status: Clean
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 04:02 AM 4/24/2005 +0200, Jesper Juhl wrote:
>On Sun, 24 Apr 2005 mbellett@cs.unibo.it wrote:
>
> > When you run the program in attachment, *even as an ordinary user*, the 
> kernel
> > panic. Tested kernel is a 2.6 vanilla with alleged .config. Tested with
>
>Just tried running it on my box here with a 2.6.12-rc2-mm3 kernel and it
>survived just fine.

Works fine here too running a 2.6.11.7 kernel, built with both gcc-2.95.3 
and gcc-3.4.3.  FWIW, If I had this problem, the first thing I'd try is 
building with good old 2.95.3.   My box didn't much care for gcc-3.3.x.

         -Mike 

