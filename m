Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263280AbSJJHbJ>; Thu, 10 Oct 2002 03:31:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263304AbSJJHbI>; Thu, 10 Oct 2002 03:31:08 -0400
Received: from twilight.ucw.cz ([195.39.74.230]:18337 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S263280AbSJJHbI>;
	Thu, 10 Oct 2002 03:31:08 -0400
Date: Thu, 10 Oct 2002 09:36:31 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Pavel Machek <pavel@ucw.cz>
Cc: vojtech@suse.cz, torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: Input - Make i8042.c less picky about AUX ports [1/3]
Message-ID: <20021010093631.A7994@ucw.cz>
References: <200210100725.JAA00155@bug.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200210100725.JAA00155@bug.ucw.cz>; from pavel@ucw.cz on Thu, Oct 10, 2002 at 09:23:40AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 10, 2002 at 09:23:40AM +0200, Pavel Machek wrote:
> > ChangeSet@1.597.3.1, 2002-10-08 17:36:32+02:00, vojtech@suse.cz
> >   Make i8042.c even less picky about detecting an AUX port because of
> >   broken chipsets that don't support the LOOP command or report failure
> >   on the TEST command. Hopefully this won't screw any old 386/486
> >   systems without the AUX port.
> 
> would it make sense to at least printk() on such
> broken chipsets? 

Maybe. But if we wanted to printk() on every chipset which doesn't
follow the i8042 spec in some way, we'd keep the logs full ...

-- 
Vojtech Pavlik
SuSE Labs
