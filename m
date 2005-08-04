Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262664AbVHDUTr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262664AbVHDUTr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Aug 2005 16:19:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262666AbVHDUSE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Aug 2005 16:18:04 -0400
Received: from smtp.osdl.org ([65.172.181.4]:42880 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262664AbVHDURh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Aug 2005 16:17:37 -0400
Date: Thu, 4 Aug 2005 13:19:30 -0700
From: Andrew Morton <akpm@osdl.org>
To: mkrufky@m1k.net
Cc: frank.peters@comcast.net, linux-kernel@vger.kernel.org, vojtech@suse.cz
Subject: Re: isa0060/serio0 problems -WAS- Re: Asus MB and 2.6.12 Problems
Message-Id: <20050804131930.793156d4.akpm@osdl.org>
In-Reply-To: <42BC3EFE.5090302@m1k.net>
References: <20050624113404.198d254c.frank.peters@comcast.net>
	<42BC306A.1030904@m1k.net>
	<20050624125957.238204a4.frank.peters@comcast.net>
	<42BC3EFE.5090302@m1k.net>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Krufky <mkrufky@m1k.net> wrote:
>
> I am cc'ing your message to Vojtech Pavlik, the INPUT DRIVERS kernel 
> maintainer.
> 
> Vojtech, I figured these should be sent to you.  If I am wrong, please 
> redirect them to the correct person / list and let us know.
> 

(Pleasee don't top-post.  See what a mess you've made!)

I don't think we've fixed all the bugs which people were reporting in this
thread.  Could people please retest 2.6.13-rc6 when it's out and generate
new reports for any remaining problems?  Via bugzilla.kernel.org would be
preferred (by me.  Otherwise tracking the status of these things is a
nightmare).

Thanks.

(And, unlike previous cycles, I'll be tracking these bugs into the 2.6.14
series, so nobody can hide!)

(As long as they're in bugzilla)

> 
> Frank Peters wrote:
> 
> >On Fri, 24 Jun 2005 12:10:18 -0400
> >Michael Krufky <mkrufky@m1k.net> wrote:
> >
> >  
> >
> >>I am having the same problem with my Shuttle FT61 motherboard, although 
> >>I have not tried to disable ACPI... Until now I thought I just had a 
> >>faulty keyboard, as my method to fix this was to unplug the keyboard and 
> >>plug it back in after bootup.  When this happens, I see this in dmesg as 
> >>the last line:
> >>
> >>input: AT Translated Set 2 keyboard on isa0060/serio0
> >>
> >>I am also having problems with my AUX mouse, as seen in message
> >>
> >>Subject: 2.6.12-rc5-mm1 breaks serio: i8042 AUX port
> >>
> >>Frank, are you having problems with your ps/2 mouse port as well?
> >>
> >>    
> >>
> >
> >I am so glad that you asked this.
> >
> >I have not been able to get my ps/2 mouse to function with any
> >2.6.x or 2.4.x kernel (same ASUS MB).  The problem is already
> >so long standing that I have completely given up on it and use
> >a serial mouse exclusively and no longer bother with ps/2.
> >
> >(I also hate to report that since I dual boot with MS Windows,
> >the ps/2 mouse functions properly under the same conditions
> >with MS Windows 2K.  The hardware cannot be at fault.) 
> >
> >  
> >
> >>As a clarification, I have been having these keyboard problems 
> >>intermittently, regardless of whether I'm using -mm or mainline kernel.  
> >>I was NOT having this problem in 2.6.11  I wasn't having the psaux mouse 
> >>problems in 2.6.11 either  .... I unplugged my psaux mouse from that 
> >>machine before 2.6.12-mainline was released, so I don't know if those 
> >>symptoms are still present.
> >>    
> >>
> >
> >Actually, my keyboard problems began with kernel-2.6.11, but were
> >quickly resolved when I used the following parameter in my lilo.conf
> >file:
> >
> >i8042.nomux
> >
> >When I use this parameter, or any other i8042 specific parameter,
> >with kernel-2.6.12, there is no effect.  The keyboard still occasionally
> >comes up dead.
> >
> >Thanks for the information on unplugging and re-plugging the keyboard.
> >I'll give that a try soon.
> >
> >Frank Peters
> >
> >(Please CC to frank.peters@comcast.net as I am not a subscriber to this
> >list.)
> >-
> >To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> >the body of a message to majordomo@vger.kernel.org
> >More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >Please read the FAQ at  http://www.tux.org/lkml/
> >  
> >
> 
> 
> -- 
> Michael Krufky
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
