Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261296AbRE2IFk>; Tue, 29 May 2001 04:05:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261334AbRE2IFU>; Tue, 29 May 2001 04:05:20 -0400
Received: from zeus.kernel.org ([209.10.41.242]:5332 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S261296AbRE2IFS>;
	Tue, 29 May 2001 04:05:18 -0400
Date: Tue, 29 May 2001 10:00:34 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Pavel Roskin <proski@gnu.org>
Cc: James Simmons <jsimmons@transvirtual.com>, linux-kernel@vger.kernel.org
Subject: Re: AT keyboard optional on i386?
Message-ID: <20010529100034.A911@suse.cz>
In-Reply-To: <Pine.LNX.4.10.10105282027030.3783-100000@transvirtual.com> <Pine.LNX.4.33.0105290021420.12495-100000@portland.hansa.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.33.0105290021420.12495-100000@portland.hansa.lan>; from proski@gnu.org on Tue, May 29, 2001 at 12:50:59AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 29, 2001 at 12:50:59AM -0400, Pavel Roskin wrote:
> Hi, James!
> 
> > So as you can see even USB keyboards depend on pc_keyb.c. So their is
> > no way around this.
> 
> Perhaps redefining kbd_read_input() will help. It's cruel, I know :-)

Or just kill allocating the IRQ in the pc_keyb.c file. It worked for me.

> > You can a few nice tricks with it like plug in two PS/2 keyboards. I
> > have this for my home setup. The only thing is make sure you don't
> > have both keyboards plugged in when you turn your PC on. I found BIOS
> > get confused by two PS/2 keyboards. As you can it is very easy to
> > multiplex many keyboards with the above design. I have had 4 different
> > keyboards hooked up to my system and functioning at the same time. We
> > even got a Sun keyboard to work on a intel box :-)
> 
> That's what we like Linux for. It doesn't get confused when everything
> else does :-)
> 
> Thanks for your very interesting reply.

-- 
Vojtech Pavlik
SuSE Labs
