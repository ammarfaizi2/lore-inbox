Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932088AbVKWQuk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932088AbVKWQuk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 11:50:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932079AbVKWQuk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 11:50:40 -0500
Received: from wproxy.gmail.com ([64.233.184.195]:45672 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932088AbVKWQuj convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 11:50:39 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=iHZd0cnbxweA7a68Q9dUrZ0AGD5jbBcyZYtrm4RY8Cm22Wxijvinogjw6aECDkElcnyhDjwxF8BgNq8v58Q3LZOPMgisnwubbQ44Uczv1SMQ+1nS9kZqzYr3uZKXmKwpnjyDJtQrbogd73+iV6V+6Tw7P3LQq6577njKLqmmYic=
Message-ID: <9e4733910511230850m29f2d358wfb887f604d7beb48@mail.gmail.com>
Date: Wed, 23 Nov 2005 11:50:33 -0500
From: Jon Smirl <jonsmirl@gmail.com>
To: Bill Davidsen <davidsen@tmr.com>
Subject: Re: Christmas list for the kernel
Cc: Russell King <rmk+lkml@arm.linux.org.uk>, Vojtech Pavlik <vojtech@suse.cz>,
       Greg KH <greg@kroah.com>, lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <438499A9.1040409@tmr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <9e4733910511221031o44dd90caq2b24fbac1a1bae7b@mail.gmail.com>
	 <20051122204918.GA5299@kroah.com>
	 <9e4733910511221313t4a1e3c67wc7b08160937eb5c5@mail.gmail.com>
	 <20051123121726.GA7328@ucw.cz>
	 <9e4733910511230643j64922738p709fecd6c86b4a95@mail.gmail.com>
	 <20051123150349.GA15449@flint.arm.linux.org.uk>
	 <438499A9.1040409@tmr.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/23/05, Bill Davidsen <davidsen@tmr.com> wrote:
> Russell King wrote:
> > On Wed, Nov 23, 2005 at 09:43:58AM -0500, Jon Smirl wrote:
>
> >>Plus I have 64 tty devices. Couldn't the tty devices be created
> >>dynamically as they are consumed? Same for the loop and ram devices?
> >
> >
> > You do realise that the dynamic device creation for those 64 console
> > devices is done via the console device being _opened_ by userspace?
> >
> Which userspace program is opening 64 console devices? Surely it could
> be taught to use a smaller number. If you mean that open the console
> once creates all those devices, I think that's exactly what Jon was
> suggesting is not desirable (I agree).

I believe the 64 console devices is comming from this define in tty.h
#define MAX_NR_CONSOLES 63

>
> --
>     -bill davidsen (davidsen@tmr.com)
> "The secret to procrastination is to put things off until the
>   last possible moment - but no longer"  -me
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>


--
Jon Smirl
jonsmirl@gmail.com
