Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130095AbRAKRh3>; Thu, 11 Jan 2001 12:37:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130309AbRAKRhU>; Thu, 11 Jan 2001 12:37:20 -0500
Received: from vault12.wastelandranger.org ([63.171.230.193]:7172 "EHLO
	wastelandranger.org") by vger.kernel.org with ESMTP
	id <S130095AbRAKRhE>; Thu, 11 Jan 2001 12:37:04 -0500
Date: Thu, 11 Jan 2001 11:37:06 -0600 (CST)
From: Joseph Anthony <jga@vault12.wastelandranger.org>
X-X-Sender: <jga@wastelandranger.org>
Reply-To: <jga@wastelandranger.org>
To: Miles Lane <miles@megapathdsl.net>
cc: <jga@wastelandranger.org>, <linux-kernel@vger.kernel.org>
Subject: Re: PPP: VJ decompression error
In-Reply-To: <3A5D5CFC.5080309@megapathdsl.net>
Message-ID: <Pine.LNX.4.31.0101111135230.1076-100000@wastelandranger.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks, that seemed to do the trick, thanks also for the ppp list info.

-Joe

On Wed, 10 Jan 2001, Miles Lane wrote:

> Date: Wed, 10 Jan 2001 23:13:00 -0800
> From: Miles Lane <miles@megapathdsl.net>
> To: jga@wastelandranger.org
> Cc: linux-kernel@vger.kernel.org
> Subject: Re: PPP: VJ decompression error
>
> Joseph Anthony wrote:
>
> > Ok, I just upgraded to 2.4.0 from 2.2.17 and I get a slew of these "PPP:
> > VJ decompression error" messages in my kern.log. I have searched all over
> > the place for a patch or an answer, but find nothing. These messages show
> > up mostly when I use Netscape, if that helps.
>
> I complained about this ages ago and submitted snippets of PPP
> debug output for analysis.  As I recall, the problem was never
> resolved and I wound up simply putting "novj" in my PPP config
> file:
>
>     /etc/ppp/options
>
> If you'd like to pursue this further, there is a linux-ppp mailing list:
>
> 	linux-ppp@vger.kernel.org
>
> I believe this is the PPP maintainer's e-mail address:
>
> 	Paul Mackerras <paulus@linuxcare.com>
>
> Best of luck,
>
> 	Miles
>

=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
=         Gentlemen! You can't fight in here, this is the War Room!         =
=  Joseph Anthony  jga@wastelandranger.org  http://www.wastelandranger.org  =
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
