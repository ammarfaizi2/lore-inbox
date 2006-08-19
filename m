Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751606AbWHSAkf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751606AbWHSAkf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 20:40:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751605AbWHSAkf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 20:40:35 -0400
Received: from nf-out-0910.google.com ([64.233.182.185]:6713 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751293AbWHSAkf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 20:40:35 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:sender;
        b=hpvGAGiHBOIodEze2RdbsYQsjM3MpPB05kJHMkEPGvFqLglde4RKeBQFMSVq1hGImk4xktMAyq4wXy6YgEbC4GyPOMkloE7COFqCtQ6B342nEb0joxEznFC48AatXRtq4hs0QTgHKznoWT/UzuilA+MdvmB/Yvd9m8QOxs+V3+E=
Date: Sat, 19 Aug 2006 02:40:20 +0000
From: Frederik Deweerdt <deweerdt@free.fr>
To: Gabor Gombas <gombasg@sztaki.hu>
Cc: Lee Revell <rlrevell@joe-job.com>, Mattia Dongili <malattia@linux.it>,
       Miles Lane <miles.lane@gmail.com>, LKML <linux-kernel@vger.kernel.org>,
       "akpm@osdl.org" <akpm@osdl.org>
Subject: Re: 2.6.18-rc4-mm1 + hotfix -- Many processes use the sysctl system call
Message-ID: <20060819024020.GD720@slug>
References: <a44ae5cd0608171541tf2f125dl586f56da6f1b2a41@mail.gmail.com> <1155854702.8796.97.camel@mindpipe> <20060818144626.GA8236@inferi.kami.home> <1155918234.24907.35.camel@mindpipe> <20060819003037.GB6440@boogie.lpds.sztaki.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060819003037.GB6440@boogie.lpds.sztaki.hu>
User-Agent: mutt-ng/devel-r804 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 19, 2006 at 02:30:37AM +0200, Gabor Gombas wrote:
> On Fri, Aug 18, 2006 at 12:23:54PM -0400, Lee Revell wrote:
> 
> > "fixed"?  Why is sysctl being removed in the middle of a stable kernel
> > series?!?
> 
> IMHO the stable series is 2.6.x.y nowadays. 2.6.z (without a fourth
> number) is more or less what used to be 2.<odd> previously.
Not to mention we're dealing with a -mm kernel...

Regards,
Frederik
> 
> > I thought the new golden rule was "don't break userspace"?
> 
> AFAIK nothing is broken, but the messages are annoying. Especially since
> 99.9% of the time they're caused not by the applications but by glibc.
> So the message should be heavily rate limited at least, if that's not
> already done.
> 
> Gabor
> 
> -- 
>      ---------------------------------------------------------
>      MTA SZTAKI Computer and Automation Research Institute
>                 Hungarian Academy of Sciences
>      ---------------------------------------------------------
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
