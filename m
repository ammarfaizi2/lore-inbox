Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265382AbUAJURR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jan 2004 15:17:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265394AbUAJURR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jan 2004 15:17:17 -0500
Received: from twilight.ucw.cz ([81.30.235.3]:32170 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id S265382AbUAJUP3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jan 2004 15:15:29 -0500
Date: Sat, 10 Jan 2004 21:15:12 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Pavel Machek <pavel@suse.cz>
Cc: Dmitry Torokhov <dtor_core@ameritech.net>,
       kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@zip.com.au>
Subject: Re: Do not use synaptics extensions by default
Message-ID: <20040110201512.GA23208@ucw.cz>
References: <20040110175930.GA1749@elf.ucw.cz> <200401101428.49358.dtor_core@ameritech.net> <20040110195124.GC1212@elf.ucw.cz> <20040110195639.GE22654@ucw.cz> <20040110201057.GA1367@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040110201057.GA1367@elf.ucw.cz>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 10, 2004 at 09:10:58PM +0100, Pavel Machek wrote:

> Hi!
> 
> > > > Why would you document something that is deprecated? It was removed so the
> > > > new users would not start using it instead of psmouse.proto. psmouse.noext
> > > > should be gone soon.
> > > 
> > > My understanding is that Documentation/kernel-parameters.txt should
> > > document all available parameters...
> > 
> > Well, I wouldn't mind documenting psmouse.noext, with a comment that it
> > shouldn't be used because it'll be removed in near future.
> 
> AFAICS, it is still psmouse*_*noext in mainline kernel, so this should
> be correct...
> 
> 								Pavel

No problem with this patch, though it'd be better if you could provide
it against the -mm kernel for Andrew.

> --- clean/Documentation/kernel-parameters.txt	2004-01-09 20:24:12.000000000 +0100
> +++ linux/Documentation/kernel-parameters.txt	2004-01-10 21:08:32.000000000 +0100
> @@ -795,6 +799,9 @@
>  			before loading.
>  			See Documentation/ramdisk.txt.
>  
> +	psmouse_noext=  [HW,MOUSE,deprecated] Equivalent to psmouse_proto=bare,
> +			will be removed in near future.
> +
>  	psmouse_proto=  [HW,MOUSE] Highest PS2 mouse protocol extension to
>  			probe for (bare|imps|exps).
>  
> 
> 
> -- 
> When do you have a heart between your knees?
> [Johanka's followup: and *two* hearts?]

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
