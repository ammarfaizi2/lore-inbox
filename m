Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264860AbRFTI6P>; Wed, 20 Jun 2001 04:58:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264862AbRFTI6E>; Wed, 20 Jun 2001 04:58:04 -0400
Received: from olsinka.site.cas.cz ([147.231.11.16]:12672 "EHLO
	twilight.suse.cz") by vger.kernel.org with ESMTP id <S264860AbRFTI5u>;
	Wed, 20 Jun 2001 04:57:50 -0400
Date: Wed, 20 Jun 2001 10:26:58 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Keith Owens <kaos@ocs.com.au>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.5-ac15 -- Unresolved symbols "gameport_register_port"
Message-ID: <20010620102658.A970@suse.cz>
In-Reply-To: <20010619193326.A295@suse.cz> <24417.992989367@ocs3.ocs-net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <24417.992989367@ocs3.ocs-net>; from kaos@ocs.com.au on Wed, Jun 20, 2001 at 08:22:47AM +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 20, 2001 at 08:22:47AM +1000, Keith Owens wrote:

> On Tue, 19 Jun 2001 19:33:26 +0200, 
> Vojtech Pavlik <vojtech@suse.cz> wrote:
> >On Wed, Jun 20, 2001 at 12:43:02AM +1000, Keith Owens wrote:
> >> drivers/char/Makefile says
> >> subdir-$(CONFIG_INPUT) += joystick
> >
> >Ouch. Forgot about this one. I guess it'd be better to fix this, because
> >the gameport code really is independent on input.
> 
> The number of gameport devices is large enough to justify their own
> subdirectory, drivers/char/gameport instead of being lumped in with the
> joysticks.  What do you think?

Except that they're not character devices at all, I'm fine with this.

-- 
Vojtech Pavlik
SuSE Labs
