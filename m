Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267934AbUJJAmU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267934AbUJJAmU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Oct 2004 20:42:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267935AbUJJAmU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Oct 2004 20:42:20 -0400
Received: from sa8.bezeqint.net ([192.115.104.22]:10644 "EHLO sa8.bezeqint.net")
	by vger.kernel.org with ESMTP id S267934AbUJJAmM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Oct 2004 20:42:12 -0400
Date: Sun, 10 Oct 2004 02:43:16 +0200
From: Micha Feigin <michf@post.tau.ac.il>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [ANNOUNCE] Linux 2.6 Real Time Kernel
Message-ID: <20041010004316.GK3165@luna.mooo.com>
Mail-Followup-To: linux-kernel <linux-kernel@vger.kernel.org>
References: <41677E4D.1030403@mvista.com> <yw1xk6u0hw2m.fsf@mru.ath.cx> <1097356829.1363.7.camel@krustophenia.net> <yw1xis9ja82z.fsf@mru.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yw1xis9ja82z.fsf@mru.ath.cx>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 09, 2004 at 11:35:16PM +0200, M?ns Rullg?rd wrote:
> Lee Revell <rlrevell@joe-job.com> writes:
> 
> > On Sat, 2004-10-09 at 09:15, M?ns Rullg?rd wrote:
> >> I got this thing to build by adding a few EXPORT_SYMBOL, patch below.
> >> Now it seems to be running quite well.  I am, however, getting
> >> occasional "bad: scheduling while atomic!" messages, all alike:
> >> 
> >
> > I am getting the same message.   Also, leaving all the default debug
> > options on, I got this debug output, but it did not coincide with the
> > "bad" messages.
> >
> > Mtx: dd84e644 [773] pri (0) inherit from [3] pri(92)
> > Mtx dd84e644 task [773] pri (92) restored pri(0). Next owner [3] pri (92)
> > Mtx: dd84e644 [773] pri (0) inherit from [3] pri(92)
> > Mtx dd84e644 task [773] pri (92) restored pri(0). Next owner [3] pri (92)
> > Mtx: dd84e644 [773] pri (0) inherit from [3] pri(92)
> > Mtx dd84e644 task [773] pri (92) restored pri(0). Next owner [3] pri (92)
> 
> Well, those don't give me any clues.
> 
> I had the system running that kernel for a bit over an hour and got
> five of the "bad" messages, approximately evenly spaced in a
> two-minute interval about 20 minutes after boot.
> 
> I did notice one improvement compared to vanilla 2.6.8.1.  The sound
> didn't skip when I switched from X to a text console.  However, my
> keyboard no longer worked in X, but that seems to be due to some
> recent changes to the input subsystem.

There was some change in 2.6.9-pre-something that cause the mouse and
keyboard to exchange event interfaces between them, if it interests you.

> 
> Did you build it with our without my patch, BTW?
> 
> -- 
> M?ns Rullg?rd
> mru@mru.ath.cx
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>  
>  +++++++++++++++++++++++++++++++++++++++++++
>  This Mail Was Scanned By Mail-seCure System
>  at the Tel-Aviv University CC.
> 
