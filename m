Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319036AbSHMUmJ>; Tue, 13 Aug 2002 16:42:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319037AbSHMUmJ>; Tue, 13 Aug 2002 16:42:09 -0400
Received: from khms.westfalen.de ([62.153.201.243]:1703 "EHLO
	khms.westfalen.de") by vger.kernel.org with ESMTP
	id <S319036AbSHMUmI>; Tue, 13 Aug 2002 16:42:08 -0400
Date: 13 Aug 2002 22:35:00 +0200
From: kaih@khms.westfalen.de (Kai Henningsen)
To: linux-kernel@vger.kernel.org
Message-ID: <8UmO4N5mw-B@khms.westfalen.de>
In-Reply-To: <Pine.LNX.4.44.0208131918360.4369-100000@localhost.localdomain>
Subject: Re: [patch] clone_startup(), 2.5.31-A0
X-Mailer: CrossPoint v3.12d.kh10 R/C435
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Organization: Organisation? Me?! Are you kidding?
References: <20020813160924.GA3821@codepoet.org> <Pine.LNX.4.44.0208131918360.4369-100000@localhost.localdomain>
X-No-Junk-Mail: I do not want to get *any* junk mail.
Comment: Unsolicited commercial mail will incur an US$100 handling fee per received mail.
X-Fix-Your-Modem: +++ATS2=255&WO1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

mingo@elte.hu (Ingo Molnar)  wrote on 13.08.02 in <Pine.LNX.4.44.0208131918360.4369-100000@localhost.localdomain>:

> On Tue, 13 Aug 2002, Erik Andersen wrote:
>
> > > First the name souns horrible.  What about spawn_thread or create_thread
> > > instead?  it's not our good old clone and not a lookalike, it's some
> > > pthreadish monster..
> >
> > How about "clone2"?
>
> ni fact it was sys_clone2() first time around, but Ulrich Drepper
> requested another name for it because in glibc it collided with ia64 where
> clone2() is something different. So whatever name there is going to be, it
> should not be sys_clone2().

clone_and_start() or clone_and_go() or something along those lines,  
perhaps?

MfG Kai
