Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273406AbRINO5B>; Fri, 14 Sep 2001 10:57:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273408AbRINO4w>; Fri, 14 Sep 2001 10:56:52 -0400
Received: from mailout03.sul.t-online.com ([194.25.134.81]:60680 "EHLO
	mailout03.sul.t-online.de") by vger.kernel.org with ESMTP
	id <S273407AbRINO4l>; Fri, 14 Sep 2001 10:56:41 -0400
Date: 14 Sep 2001 10:07:00 +0200
From: kaih@khms.westfalen.de (Kai Henningsen)
To: linux-kernel@vger.kernel.org
Message-ID: <88q7QEGHw-B@khms.westfalen.de>
In-Reply-To: <Pine.LNX.3.96.1010914014353.8683A-100000@mandrakesoft.mandrakesoft.com>
Subject: Re: [PATCH] Endian-ness bugs in yellowfin.c
X-Mailer: CrossPoint v3.12d.kh7 R/C435
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Organization: Organisation? Me?! Are you kidding?
In-Reply-To: <20010914001540.B2951@boardwalk> <Pine.LNX.3.96.1010914014353.8683A-100000@mandrakesoft.mandrakesoft.com>
X-No-Junk-Mail: I do not want to get *any* junk mail.
Comment: Unsolicited commercial mail will incur an US$100 handling fee per received mail.
X-Fix-Your-Modem: +++ATS2=255&WO1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

jgarzik@mandrakesoft.com (Jeff Garzik)  wrote on 14.09.01 in <Pine.LNX.3.96.1010914014353.8683A-100000@mandrakesoft.mandrakesoft.com>:

> On Fri, 14 Sep 2001, Val Henson wrote:
> > You misunderstood what I meant.  This is the first case of one driver
> > supporting two different cards, one 10/100 and one 10/100/1000.  All
> > the gigabit cards are 10/100/1000 as far as I know.  I still think the
> > driver should be listed in both the 100 Mbit and 1000 Mbit Ethernet
> > menu sections, unless someone comes up with a better idea.
>
> Please do not add duplicate items...  put drivers that can do gigabit
> under gigabit.  Eventually as we get more of them we can come up
> with better Config.in categories.  Besides being an ugly solution,
> duplicating items has the potential to push edge cases in the various
> Config.in parsers.

Actually, I'd say that practically *all* the categories used for ethernet  
cards are confusing. I certainly often end up backtracking several times  
when configuring a new machine.

Just throwing the lot out and using a flat list would be better than the  
current state.

Bad category strategies:

* Brand name. Drivers serve different brands.
* Bus type. Drivers serve cards on different bus types.
* Speed. Drivers serve cards capable of different speeds.

I really don't know what's left.

Unless, of course, mentioning one driver several places becomes possible.  
Then all these arguments become irrelevant.

MfG Kai
