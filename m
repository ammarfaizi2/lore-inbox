Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292629AbSCDRvJ>; Mon, 4 Mar 2002 12:51:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292594AbSCDRuB>; Mon, 4 Mar 2002 12:50:01 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:30626 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S292631AbSCDRta>; Mon, 4 Mar 2002 12:49:30 -0500
Date: Mon, 4 Mar 2002 11:04:12 -0700
From: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
To: Martin Josefsson <gandalf@wlug.westbo.se>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Gigabit Performance 2.4.19-preX - Excessive locks, calls, waits
Message-ID: <20020304110412.A31724@vger.timpanogas.org>
In-Reply-To: <20020304001223.A29448@vger.timpanogas.org> <Pine.LNX.4.21.0203041830020.12740-100000@tux.rsn.bth.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.21.0203041830020.12740-100000@tux.rsn.bth.se>; from gandalf@wlug.westbo.se on Mon, Mar 04, 2002 at 06:39:31PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Thanks!  I'll check it out.  I;ve already done very heavy modifications
to the e1000 for my testing.

Jeff

On Mon, Mar 04, 2002 at 06:39:31PM +0100, Martin Josefsson wrote:
> Hi Jeff,
> 
> Have you tried the NAPI patch and the NAPI'fied e1000 driver?
> I'm not sure how far the development has come but I know it improves
> performance quite a bit versus the regular e1000 driver.
> 
> You'll find it here:
> ftp://robur.slu.se/pub/Linux/net-development/NAPI/
> 
> kernel/napi-patch-ank is the NAPI patch, you need to change
> the get_fast_time() call to do_gettimeofday() for it to compile.
> 
> e1000/ is the NAPI'fied e1000 driver, the latest release is from Jan 29
> but there is a document that describes how you checkout the latest version
> via cvs.
> 
> I've never tried the e1000 NAPI driver since I don't have one of these
> boards but I use the tulip NAPI driver a lot here and it works great,
> impressive performance.
> 
> I hope you get better performance.
> 
> /Martin
> 
> Never argue with an idiot. They drag you down to their level, then beat you with experience.
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
