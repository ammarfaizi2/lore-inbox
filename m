Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261630AbTCOWST>; Sat, 15 Mar 2003 17:18:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261632AbTCOWST>; Sat, 15 Mar 2003 17:18:19 -0500
Received: from pcp02781107pcs.eatntn01.nj.comcast.net ([68.85.61.149]:29938
	"EHLO linnie.riede.org") by vger.kernel.org with ESMTP
	id <S261630AbTCOWSS>; Sat, 15 Mar 2003 17:18:18 -0500
Date: Sat, 15 Mar 2003 17:29:17 -0500
From: Willem Riede <wrlk@riede.org>
To: Zwane Mwaikambo <zwane@holomorphy.com>
Cc: dan carpenter <d_carpenter@sbcglobal.net>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Any hope for ide-scsi (error handling)?
Message-ID: <20030315222917.GK7082@linnie.riede.org>
Reply-To: wrlk@riede.org
References: <Pine.LNX.4.50.0303151343140.9158-100000@montezuma.mastecende.com> <200303151926.h2FJQLnB103490@pimout1-ext.prodigy.net> <Pine.LNX.4.50.0303151453010.9158-100000@montezuma.mastecende.com> <200303152012.h2FKCulK283698@pimout2-ext.prodigy.net> <Pine.LNX.4.50.0303151519240.9158-100000@montezuma.mastecende.com> <20030315210120.GI7082@linnie.riede.org> <Pine.LNX.4.50.0303151602200.9158-100000@montezuma.mastecende.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <Pine.LNX.4.50.0303151602200.9158-100000@montezuma.mastecende.com>; from zwane@holomorphy.com on Sat, Mar 15, 2003 at 16:11:28 -0500
X-Mailer: Balsa 1.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2003.03.15 16:11 Zwane Mwaikambo wrote:
> On Sat, 15 Mar 2003, Willem Riede wrote:
> 
> > It may not be elegant to schedule(1) with the lock taken, but it
> > does work.
> > 
> > However, my latest patch doesn't seem to be applied, since in my
> > version I have a set_current_state(TASK_INTERRUPTIBLE); before 
> > the schedule.
> 
> Yeah but what happens when a task tries to acquire ide_lock? 

It gets to wait until I'm done.

Regards, Willem Riede.
