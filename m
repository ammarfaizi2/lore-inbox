Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261855AbTAaRqn>; Fri, 31 Jan 2003 12:46:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261868AbTAaRqn>; Fri, 31 Jan 2003 12:46:43 -0500
Received: from twilight.ucw.cz ([195.39.74.230]:58824 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S261855AbTAaRqn>;
	Fri, 31 Jan 2003 12:46:43 -0500
Date: Fri, 31 Jan 2003 18:55:58 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Nigel Cunningham <ncunningham@clear.net.nz>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: drivers/char/keyboard.c now unused?
Message-ID: <20030131185558.A25927@ucw.cz>
References: <1043894474.1623.6.camel@laptop-linux.cunninghams>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1043894474.1623.6.camel@laptop-linux.cunninghams>; from ncunningham@clear.net.nz on Thu, Jan 30, 2003 at 03:41:15PM +1300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 30, 2003 at 03:41:15PM +1300, Nigel Cunningham wrote:
> Hi all.
> 
> I've been doing some work on porting my patches to the 2.4 version of
> software suspend to 2.5. Under 2.4, I use the shift_state variable from
> drivers/char/keyboard.c to provide interactive, step-by-step progression
> through the process. That is, there is an option for you to be able to
> press and release shift before the next stage starts. With the new input
> layer, drivers/char/keyboard.c still exists, but seems to be unused. Can
> I get confirmation that my understand is correct, and (if possible) a
> pointer to information on how I can reimplement the functionality under
> 2.5?

Your understanding is not correct, and drivers/char/keyboard.c is very
much used for all keyboard input in 2.5.

> Oh and before anyone has a hernia, I'm not intending to leave this
> functionality in the final version - its just for debugging purposes.
> 
> Thanks in advance,
> 
> Nigel
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
Vojtech Pavlik
SuSE Labs
