Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287949AbSABUle>; Wed, 2 Jan 2002 15:41:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287967AbSABUlY>; Wed, 2 Jan 2002 15:41:24 -0500
Received: from svr3.applink.net ([206.50.88.3]:23559 "EHLO svr3.applink.net")
	by vger.kernel.org with ESMTP id <S287952AbSABUjm>;
	Wed, 2 Jan 2002 15:39:42 -0500
Message-Id: <200201022039.g02KdPSr022018@svr3.applink.net>
Content-Type: text/plain; charset=US-ASCII
From: Timothy Covell <timothy.covell@ashavan.org>
Reply-To: timothy.covell@ashavan.org
To: Kilobug <kilobug@freesurf.fr>, timothy.covell@ashavan.org
Subject: Re: system.map
Date: Wed, 2 Jan 2002 14:35:43 -0600
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020102191157.49760.qmail@web21204.mail.yahoo.com> <200201022006.g02K6vSr021827@svr3.applink.net> <3C336B65.2020905@freesurf.fr>
In-Reply-To: <3C336B65.2020905@freesurf.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 02 January 2002 14:19, Kilobug wrote:
> > 5. sync;sync;shutdown -r now
>
> Is there any particular reason for this double sync ? One isn't enough ?
> (And is sync even needed with shutdown, all should be synced when
> filesystems are unmounted or remounted read-only, am I wrong ? )

The double sync is tradition.  SysV init scripts should sync things,
but "sync;sync;reboot" or "sync;sync;halt" are not so nice in how
they go down; so it's a case of being extra careful.  I don't use
linux all the time, and some of the other unices are less tolerant.
(For example, on a sun box, I would prefer a double sync before I
"<stop>-a".)

-- 
timothy.covell@ashavan.org.
