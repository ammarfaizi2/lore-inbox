Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287751AbSAUI00>; Mon, 21 Jan 2002 03:26:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288473AbSAUI0R>; Mon, 21 Jan 2002 03:26:17 -0500
Received: from smtp-out-7.wanadoo.fr ([193.252.19.26]:61324 "EHLO
	mel-rto7.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S287751AbSAUI0I>; Mon, 21 Jan 2002 03:26:08 -0500
Content-Type: text/plain; charset=US-ASCII
From: Duncan Sands <duncan.sands@math.u-psud.fr>
To: Dave Jones <davej@suse.de>
Subject: Re: 2.5.2-dj2 hangs loading real time clock driver
Date: Mon, 21 Jan 2002 09:25:43 +0100
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <E16RWPI-0000Ja-00@baldrick> <20020118181722.E3517@suse.de> <E16SPRf-0000ux-00@baldrick>
In-Reply-To: <E16SPRf-0000ux-00@baldrick>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16SZlw-0000MY-00@baldrick>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 20 January 2002 10:24 pm, Duncan Sands wrote:
> On Friday 18 January 2002 6:17 pm, Dave Jones wrote:
> > On Fri, Jan 18, 2002 at 11:38:00AM +0100, Duncan Sands wrote:
> >  > I decided to give 2.5.2-dj2 a whirl.  It hangs at the following point:
> >  > Setting the System Clock using the Hardware Clock as reference
> >  > Real Time Clock Driver v1.10e
> >  > (hangs)
> >
> >  Ok, I got a repeatable similar case here, which seemed to have
> >  been scheduler related. Solved by updating the scheduler to Ingo's
> >  latest and greatest.  Give -dj3 a whirl when it comes out in a few
> >  hours.
>
> I gave it a try but it didn't help.  Since I have the same problem with
> vanilla 2.5.2, it's not a problem with your patches.  I will dig deeper
> now...

It was a devfs bug.  Richard Gooch's latest patch fixed it.  Thanks
Richard!

Duncan.
