Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261554AbUCOLU5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Mar 2004 06:20:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261943AbUCOLU5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Mar 2004 06:20:57 -0500
Received: from svr44.ehostpros.com ([66.98.192.92]:45772 "EHLO
	svr44.ehostpros.com") by vger.kernel.org with ESMTP id S261554AbUCOLUz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Mar 2004 06:20:55 -0500
From: "Amit S. Kale" <amitkale@emsyssoft.com>
Organization: EmSysSoft
To: George Anzinger <george@mvista.com>
Subject: Re: [Kgdb-bugreport] [PATCH][2/3] Update CVS KGDB's have kgdb_{schedule,process}_breakpoint
Date: Mon, 15 Mar 2004 16:50:34 +0530
User-Agent: KMail/1.5
Cc: Tom Rini <trini@kernel.crashing.org>,
       kernel list <linux-kernel@vger.kernel.org>,
       Pavel Machek <pavel@suse.cz>, kgdb-bugreport@lists.sourceforge.net
References: <20040225213626.GF1052@smtp.west.cox.net> <200403121014.08221.amitkale@emsyssoft.com> <40516EDA.5060006@mvista.com>
In-Reply-To: <40516EDA.5060006@mvista.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200403151650.34115.amitkale@emsyssoft.com>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - svr44.ehostpros.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - emsyssoft.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 12 Mar 2004 1:33 pm, George Anzinger wrote:
> Amit S. Kale wrote:
> > On Friday 12 Mar 2004 2:58 am, George Anzinger wrote:
> >>Amit S. Kale wrote:
> >>~
> >>
> >>>>context any
> >>>>
> >>>>p fun()
> >>>
> >>>p fun() will push arguments on stack over the place where irq occured,
> >>>which is exactly how it'll run.
> >>
> >>Is this capability in kgdb lite?  It was one of the last things I added
> >> to -mm version.
> >
> > No! It's not present in kgdb heavy also. All you can do is set $pc,
> > continue.
>
> Possibly I can help here.  I did it for the mm version.  It does require a
> couple of asm bits and it sort of messes up the set/fetch memory, but it
> does do the job.

I have seen that. It's too messy!

-Amit
