Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288130AbSAQCzM>; Wed, 16 Jan 2002 21:55:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288128AbSAQCyx>; Wed, 16 Jan 2002 21:54:53 -0500
Received: from femail29.sdc1.sfba.home.com ([24.254.60.19]:34295 "EHLO
	femail29.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S288130AbSAQCyd>; Wed, 16 Jan 2002 21:54:33 -0500
Content-Type: text/plain; charset=US-ASCII
From: Rob Landley <landley@trommello.org>
To: Bill Davidsen <davidsen@tmr.com>,
        Hans-Christian Armingeon <linux.johnny@gmx.net>
Subject: Re: KDE hang with 2.4.18-pre3-ac2
Date: Wed, 16 Jan 2002 13:52:29 -0500
X-Mailer: KMail [version 1.3.1]
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.3.96.1020116121752.28369J-100000@gatekeeper.tmr.com>
In-Reply-To: <Pine.LNX.3.96.1020116121752.28369J-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020117025432.INGX20810.femail29.sdc1.sfba.home.com@there>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 16 January 2002 12:20 pm, Bill Davidsen wrote:
> On Wed, 16 Jan 2002, Hans-Christian Armingeon wrote:
> > I've got the same problems with SuSE7.3 and kde2.2.2.
> > With kernel 2.4.17, the X locks up, when I push the power button, the box
> > tries to shut doen [I can hear a beep], but nothing else happens. After
> > two or three sysrq keys specally sigterm to all processes, the system
> > locks hard [reset cycle needed]. I am trying 2.4.18-pre4 now.
>
> Totally other problem. When my KDE won't launch tasks from the bar, it
> will still work just fine otherwise, shutdown cleanly, etc. System is not
> in any way hung, just that clicking the browser or terminal button doesn't
> start a process, and if I bring up a menu from the bar, and try to start
> something like moon phase, it also doesn't start.

Question: did you change your computer's hostname just before this happened?  
(That can trigger this behavior.  When you change your box's hostname, you 
have to exit and restart X.  If you ask me, it's a design flaw in X, which 
thinks it's doing stuff through the network even when it isn't.  KDE isn't 
helping by cacheing stuff, but it's going for performance...)

Rob
