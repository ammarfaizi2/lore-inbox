Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289362AbSA1ULF>; Mon, 28 Jan 2002 15:11:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289351AbSA1UK4>; Mon, 28 Jan 2002 15:10:56 -0500
Received: from mx3.sac.fedex.com ([199.81.208.11]:54791 "EHLO
	mx3.sac.fedex.com") by vger.kernel.org with ESMTP
	id <S289364AbSA1UKn>; Mon, 28 Jan 2002 15:10:43 -0500
Date: Tue, 29 Jan 2002 04:11:19 +0800 (SGT)
From: Jeff Chua <jchua@fedex.com>
X-X-Sender: root@boston.corp.fedex.com
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Thomas Hood <jdthood@mail.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Stephan von Krawczynski <skraw@ithnet.com>,
        Jeff Chua <jchua@fedex.com>
Subject: Re: 2.4.18-pre7 slow ... apm problem
In-Reply-To: <E16Uzie-0003Ba-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.44.0201290351520.7623-100000@boston.corp.fedex.com>
MIME-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on ENTPM11/FEDEX(Release 5.0.8 |June 18, 2001) at 01/29/2002
 04:10:36 AM,
	Serialize by Router on ENTPM11/FEDEX(Release 5.0.8 |June 18, 2001) at 01/29/2002
 04:10:39 AM,
	Serialize complete at 01/29/2002 04:10:39 AM
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 27 Jan 2002, Stephan von Krawczynski wrote:

> > 1) keyboard rate is a bit slow on 2.4.18-pre7 compared to 2.4.18-pre6.
> What _exactly_ does this mean? Can you elaborate more on your setup and
> your problem?

Sorry, just got off a long flight from San Diego to Singapore. Anyway,
slow ... means that even without vmware, if I just hit return, the lines
would scroll for about every 10 lines and there'll be a litte pause (<0.3
sec). With pre6, there's no such behavior, and if CONFIG_APM_CPU_IDLE is
not set, the "pause" goes away.

> > 2) On vmware 3.0, ping localhost is very slow. 2.4.18-pre6 has not
> such problem.
> 1) linux with vmware and guest system linux

"host" system is linux. "guest" system is linux (actually, I tried with NT
as well, same problem).

The sympton is when I try to ping the "host" from vmware's "guest" system,
the first response came back to the guest's console. Then if I don't type
anything or don't move the mouse on the guest's console, I won't see any
further response on the guest's linux console. Even with a lot of mouse
movement or pressing the keys, the response is still very slow with "ping".

If I ping from the "host" linux console to the "guest" linux system,
responses came back, and does not hang. I'll double check this last point.
Got to recompile the kernel again.

Jeff

