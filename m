Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750947AbWAAW5o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750947AbWAAW5o (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Jan 2006 17:57:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932101AbWAAW5o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Jan 2006 17:57:44 -0500
Received: from mail.metronet.co.uk ([213.162.97.75]:2745 "EHLO
	mail.metronet.co.uk") by vger.kernel.org with ESMTP
	id S1750947AbWAAW5o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Jan 2006 17:57:44 -0500
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
To: Keith Owens <kaos@ocs.com.au>
Subject: Re: MPlayer broken under 2.6.15-rc7-rt1?
Date: Sun, 1 Jan 2006 22:57:24 +0000
User-Agent: KMail/1.9
Cc: Lee Revell <rlrevell@joe-job.com>, Arjan van de Ven <arjan@infradead.org>,
       Bradley Reed <bradreed1@gmail.com>, linux-kernel@vger.kernel.org
References: <29832.1136151227@ocs3.ocs.com.au>
In-Reply-To: <29832.1136151227@ocs3.ocs.com.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601012257.24795.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 01 January 2006 21:33, Keith Owens wrote:
> Lee Revell (on Sun, 01 Jan 2006 13:57:14 -0500) wrote:
> >On Sun, 2006-01-01 at 14:31 +0000, Alistair John Strachan wrote:
> >> On Sunday 01 January 2006 09:14, Arjan van de Ven wrote:
> >> > On Sat, 2005-12-31 at 20:29 +0200, Bradley Reed wrote:
> >> > > I have tried MPlayer versions 1.0pre6, 1.0pre7, and cvs from today
> >> > > and they all work fine under 2.6.14 and 2.6.14-rt21/22.
> >> > >
> >> > > I booted into 2.6.15-rc7-rt1 and the same MPlayer binaries segfault
> >> > > on every video I try and play. Yes, I have nvidia modules loaded, so
> >> > > won't get much help, but thought someone might like to know.
> >> >
> >> > you know, you could have done a little bit more effort and reproduced
> >> > this without the binary crud... it's not that hard you know and it
> >> > shows that you actually care about the problem enough that you want to
> >> > make it worthwhile for people to look into it.
> >>
> >> REPORTING-BUGS should probably be fixed to make the points you
> >> repeatedly have to make. I agree 100% that people should not be
> >> reporting easily reproducible bugs with proprietary drivers loaded;
> >> what's a reboot to them?
> >>
> >> Let's add something to REPORTING-BUGS about tainted kernels and/or
> >> proprietary drivers. A quick grep of this file from 2.6.15-rc6 gives me
> >> no hits for "proprietary", "tainted" or "binary".
> >
> >Heh, wow, that's a serious omission.  It would explain why so many users
> >post tainted bug reports then act like we're fanatics for telling them
> >not to do that ;-)
>
> Historically this was covered in the kernel FAQ, see
> http://www.kernel.org/pub/linux/docs/lkml/#s1-18.

I can see no reason why it shouldn't also be in the kernel. The issue is not 
even a political one, it is a matter of debugging practicality.

-- 
Cheers,
Alistair.

'No sense being pessimistic, it probably wouldn't work anyway.'
Third year Computer Science undergraduate.
1F2 55 South Clerk Street, Edinburgh, UK.
