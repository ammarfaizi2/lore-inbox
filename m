Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136384AbRD2V7h>; Sun, 29 Apr 2001 17:59:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136385AbRD2V71>; Sun, 29 Apr 2001 17:59:27 -0400
Received: from 513.holly-springs.nc.us ([216.27.31.173]:2861 "EHLO
	513.holly-springs.nc.us") by vger.kernel.org with ESMTP
	id <S136384AbRD2V7S>; Sun, 29 Apr 2001 17:59:18 -0400
Subject: Re: #define HZ 1024 -- negative effects?
From: Michael Rothwell <rothwell@holly-springs.nc.us>
To: Jim Gettys <jg@pa.dec.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200104292144.f3TLiBD03874@pachyderm.pa.dec.com>
In-Reply-To: <200104292144.f3TLiBD03874@pachyderm.pa.dec.com>
Content-Type: text/plain
X-Mailer: Evolution/0.10 (Preview Release)
Date: 29 Apr 2001 17:59:16 -0400
Message-Id: <988581556.7879.2.camel@gromit>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Great. I'm running 4.02. How do I enable "silken mouse"?

Thanks,

-Michael

On 29 Apr 2001 14:44:11 -0700, Jim Gettys wrote:
> The biggest single issue in GUI responsiveness on Linux has been caused
> by XFree86's implementation of mouse tracking in user space.
> 
> On typical UNIX systems, the mouse was often controlled in the kernel
> driver.  Until recently (XFree86 4.0 days), the XFree86 server's reads
> of mouse/keyboard events were not signal driven, so that if the X server
> was loaded, the cursor stopped moving.
> 
> On most (but not all) current XFree86 implementations, this is now
> signal drive, and further the internal X schedular has been reworked to
> make it difficult for a single client to monopolize the X server.
> 
> So the first thing you should try is to make sure you are using an X server
> with this "silken mouse" enabled; anotherwords, run XFree86 4.0x and make
> sure the implementation has it enabled....
> 
> There may be more to do in Linux thereafter, but until you've done this, you
> don't get to discuss the matter further....
>                                       - Jim Gettys
> 
> --
> Jim Gettys
> Technology and Corporate Development
> Compaq Computer Corporation
> jg@pa.dec.com
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

