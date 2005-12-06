Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751593AbVLFEIs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751593AbVLFEIs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Dec 2005 23:08:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751591AbVLFEIs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Dec 2005 23:08:48 -0500
Received: from mail.kroah.org ([69.55.234.183]:45206 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1751476AbVLFEIr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Dec 2005 23:08:47 -0500
Date: Mon, 5 Dec 2005 20:08:20 -0800
From: Greg KH <greg@kroah.com>
To: Tim Bird <tim.bird@am.sony.com>
Cc: Dave Airlie <airlied@gmail.com>, David Woodhouse <dwmw2@infradead.org>,
       arjan@infradead.org, andrew@walrond.org, linux-kernel@vger.kernel.org
Subject: Re: Linux in a binary world... a doomsday scenario
Message-ID: <20051206040820.GB26602@kroah.com>
References: <21d7e9970512051610n1244467am12adc8373c1a4473@mail.gmail.com> <4394DA1D.3090007@am.sony.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4394DA1D.3090007@am.sony.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 05, 2005 at 04:23:57PM -0800, Tim Bird wrote:
> Dave Airlie wrote:
> >>To the larger argument about supporting binary drivers,
> >>all Arjan manages to prove with his post is that,
> >>if handled in the worst possible way, support for
> >>binary drivers would be a disaster.  Who can disagree
> >>with that?
> >> 
> > And do you think that given the opportunity, any company is going
> > spend the extra money required to not do it in the worst possible
> > way?? 
> 
> I meant "handled in the worst possible way by
> the kernel developers".  It *is* possible to define
> stable APIs and have them used successfully.
> 
> POSIX is not the greatest example, but it seems
> to work OK.  I realize that drivers are more
> tightly bound to the kernel than are libraries
> or applications, but sheesh, this is not rocket
> science.

For people to think that the kernel developers are just "too dumb" to
make a stable kernel api (and yes, I've had people accuse me of this
many times to my face[1]) shows a total lack of understanding as to
_why_ we change the in-kernel api all the time.  Please see
Documentation/stable_api_nonsense.txt for details on this.

thanks,

greg k-h

[1] My usual response is, "If we are so dumb, why are you using the kernel
    made by us?", which usually stops the conversation right there.

