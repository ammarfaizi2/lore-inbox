Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265943AbUAUMe7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jan 2004 07:34:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265944AbUAUMe6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jan 2004 07:34:58 -0500
Received: from twilight.ucw.cz ([81.30.235.3]:60032 "EHLO midnight.ucw.cz")
	by vger.kernel.org with ESMTP id S265943AbUAUMev (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jan 2004 07:34:51 -0500
Date: Wed, 21 Jan 2004 13:34:54 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Andi Kleen <ak@suse.de>
Cc: rusty@rustcorp.com.au, linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: 2.6.1-mm4
Message-ID: <20040121123454.GB538@ucw.cz>
References: <p73r7xwglgn.fsf@verdi.suse.de> <20040121043608.6E4BB2C0CB@lists.samba.org> <20040121084009.GC295@ucw.cz> <20040121132744.1094129f.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040121132744.1094129f.ak@suse.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 21, 2004 at 01:27:44PM +0100, Andi Kleen wrote:
> On Wed, 21 Jan 2004 09:40:09 +0100
> Vojtech Pavlik <vojtech@suse.cz> wrote:
> 
> > 
> > Inbetween the module changes and the input changes there was a
> > situation, where you'd have to pass
> > 
> > 	psmouse.psmouse_maxproto=imps2
> > 
> > as a kernel argument. This should (I hope so, I have to check) be fixed
> > now.
> 
> No, 2.6.1 requires it.
> 
> And worst is that you have to reboot to change mouse settings at all.
> That just doesn't make any sense. Can you please add an runtime sysfs
> interface for this?

It's planned, though not easy to implement at all. I don't think I'll be
able to get this into 2.6.2. For now you can enable EMBEDDED, compile
psmouse as a module, and just rmmod/insmod it with new parameters.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
