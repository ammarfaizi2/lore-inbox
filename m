Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932107AbWHQMWv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932107AbWHQMWv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 08:22:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932290AbWHQMWv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 08:22:51 -0400
Received: from rhlx01.fht-esslingen.de ([129.143.116.10]:63123 "EHLO
	rhlx01.fht-esslingen.de") by vger.kernel.org with ESMTP
	id S932107AbWHQMWu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 08:22:50 -0400
Date: Thu, 17 Aug 2006 14:22:48 +0200
From: Andreas Mohr <andi@rhlx01.fht-esslingen.de>
To: Maciej Rutecki <maciej.rutecki@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Dmitry Torokhov <dtor@mail.ru>
Subject: Re: 2.6.18-rc4-mm1
Message-ID: <20060817122248.GA16927@rhlx01.fht-esslingen.de>
References: <20060813012454.f1d52189.akpm@osdl.org> <44DF10DF.5070307@gmail.com> <20060813121126.b1dc22ee.akpm@osdl.org> <62F8B56A.8000908@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <62F8B56A.8000908@gmail.com>
User-Agent: Mutt/1.4.2.1i
X-Priority: none
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, Aug 14, 2022 at 10:42:18AM +0200, Maciej Rutecki wrote:
> Andrew Morton napisa??(a):
> > Please always do reply-to-all.
> > 
> 
> Sorry.
> 
> > 
> > 
> > Could be i8042-get-rid-of-polling-timer-v4.patch.  Please try the below
> > reversion patch, on top of rc4-mm1, thanks.
> > 
> > 
> 
> Thanks for help.
> 
> I try this patch, keyboard works, but I have other problem. When I try:
> 
> echo "standby" > /sys/power/state
> 
> system goes to standby, but keyboard stop working and CMOS clock was
> corrupted (randomize date and time e.g. Fri Feb 18 2028 13:57:43). So I
> must reset computer.

Thou shalt Not enable no dangerous CMOS corrupting suspend debugging configs ;)

No idea whether "corrupting" the CMOS content with suspend debugging data
has any influence on the keyboard resume, though, but it could easily have.

Andreas Mohr
