Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263178AbTJERRn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Oct 2003 13:17:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263179AbTJERRm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Oct 2003 13:17:42 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:22464 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id S263178AbTJERRi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Oct 2003 13:17:38 -0400
Date: Sun, 5 Oct 2003 19:17:24 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Peter Osterlund <petero2@telia.com>
Cc: Neil Brown <neilb@cse.unsw.edu.au>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>,
       Vojtech Pavlik <vojtech@suse.cz>,
       Johan Braennlund <spahmtrahp@yahoo.com>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: PATCH - ALPS glidepoint/dualpoint driver for 2.5.7x
Message-ID: <20031005171724.GA13141@ucw.cz>
References: <16123.44602.150927.280989@gargle.gargle.HOWL> <1056699687.599.2.camel@teapot.felipe-alfaro.com> <16124.2893.587755.586343@gargle.gargle.HOWL> <m2smm7oc8s.fsf@p4.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m2smm7oc8s.fsf@p4.localdomain>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 05, 2003 at 06:55:31PM +0200, Peter Osterlund wrote:
 
> Hi!
> 
> I have updated your patch for kernel 2.6.0-test6-bk6 and made it
> report events compatible with the synaptics touchpad kernel driver.
> This should make it possible to use an ALPS device with the XFree86
> synaptics driver:
> 
>         http://w1.894.telia.com/~u89404340/touchpad/index.html
> 
> Using this driver will give you edge scrolling and similar things.
> 
> I don't have an ALPS GlidePoint so I haven't been able to test this
> patch at all. Test reports are appreciated. You probably need to
> change a few parameters in the X configuration, like edge parameters
> and finger pressure thresholds. Also note that the auto detection will
> not work with an ALPS device, so you have to use Protocol="event" and
> Device="/dev/input/eventN" for some value of N.

Very nice. Could you also make it a separate file? I think it's enough
code to make that worth it ...

>  linux-petero/drivers/input/mouse/psmouse-base.c |   86 ++++++++++++++++++++++++
>  linux-petero/drivers/input/mouse/psmouse.h      |    1 
>  2 files changed, 87 insertions(+)

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
