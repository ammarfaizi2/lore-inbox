Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286311AbSA1VWC>; Mon, 28 Jan 2002 16:22:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286303AbSA1VVx>; Mon, 28 Jan 2002 16:21:53 -0500
Received: from mx1.sac.fedex.com ([199.81.208.10]:12302 "EHLO
	mx1.sac.fedex.com") by vger.kernel.org with ESMTP
	id <S285828AbSA1VVn>; Mon, 28 Jan 2002 16:21:43 -0500
Date: Tue, 29 Jan 2002 05:17:31 +0800 (SGT)
From: Jeff Chua <jeffchua@silk.corp.fedex.com>
X-X-Sender: root@boston.corp.fedex.com
To: Jeff Chua <jchua@fedex.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Thomas Hood <jdthood@mail.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Stephan von Krawczynski <skraw@ithnet.com>
Subject: Re: 2.4.18-pre7 slow ... apm problem
In-Reply-To: <Pine.LNX.4.44.0201290351520.7623-100000@boston.corp.fedex.com>
Message-ID: <Pine.LNX.4.44.0201290513430.548-100000@boston.corp.fedex.com>
MIME-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on ENTPM11/FEDEX(Release 5.0.8 |June 18, 2001) at 01/29/2002
 05:21:37 AM,
	Serialize by Router on ENTPM11/FEDEX(Release 5.0.8 |June 18, 2001) at 01/29/2002
 05:21:41 AM,
	Serialize complete at 01/29/2002 05:21:41 AM
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 29 Jan 2002, Jeff Chua wrote:

> > > 1) keyboard rate is a bit slow on 2.4.18-pre7 compared to 2.4.18-pre6.
> > What _exactly_ does this mean? Can you elaborate more on your setup and
> > your problem?
>
> slow ... means that even without vmware, if I just hit return, the lines
> would scroll for about every 10 lines and there'll be a litte pause (<0.3
> sec). With pre6, there's no such behavior, and if CONFIG_APM_CPU_IDLE is
> not set, the "pause" goes away.

2.0 cps on "guest" linux os just pressing "g". 30 cps on "host" linux os.

>
> > > 2) On vmware 3.0, ping localhost is very slow. 2.4.18-pre6 has not
> > such problem.
> > 1) linux with vmware and guest system linux
>
> "host" system is linux. "guest" system is linux (actually, I tried with NT
> as well, same problem).
>
> If I ping from the "host" linux console to the "guest" linux system,
> responses came back, and does not hang. I'll double check this last point.
> Got to recompile the kernel again.

slow from "guest" os to "host" os.
slow from "guest" os to guest's 127.0.0.1

fast from "host" os to "guest" os.

If I set idle_threshold to 100, problem goes away.

APM is not enabled on "guest" os.

Jeff.

