Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265912AbUAQXTG (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Jan 2004 18:19:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266152AbUAQXTG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Jan 2004 18:19:06 -0500
Received: from twilight.ucw.cz ([81.30.235.3]:34186 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id S265912AbUAQXTD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Jan 2004 18:19:03 -0500
Date: Sun, 18 Jan 2004 00:18:52 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Greg Stark <gsstark@mit.edu>
Cc: mljf@altern.org, Maciej Soltysiak <solt@dns.toxicfilms.tv>,
       Kernel Mailinglist <linux-kernel@vger.kernel.org>
Subject: Re: No mouse wheel under 2.6.1 [Was: Re: Where are 2.6.x upgrade notes?]
Message-ID: <20040117231852.GA13418@ucw.cz>
References: <87ptdocmf1.fsf@stark.xeocode.com> <003801c3d9c4$2c2dead0$0e25fe0a@southpark.ae.poznan.pl> <873caj0y96.fsf_-_@stark.xeocode.com> <1074352816.3838.2.camel@sid> <87fzee1fcq.fsf@stark.xeocode.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87fzee1fcq.fsf@stark.xeocode.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 17, 2004 at 03:37:25PM -0500, Greg Stark wrote:

> Joaquim Fellmann <mljf@altern.org> writes:
> 
> > I had the same problem. Switching protocol from MousemanPlusPS/2 to
> > ImPS2 in XF86Config-4 fixed it.
> 
> One Mr Pavlik solved the same issue on bugzilla:
> 
>     ------- Additional Comment #1 From Vojtech Pavlik 2004-01-14 09:35 ------- 
>     Use protocol "ExplorerPS/2" in XFree86. This may not seem logical, but
>     because 2.6 handles the Logitech mouse protocol itself and presents a more
>     common Microsoft-like protocol to applications that don't know how to use
>     its native event protocol.
> 
> I wonder how the IM and Explorer protocols relate.

ExplorerPS/2 is a superset of ImPS/2. The kernel virtual mouse device
(/dev/input/mice) supports both protocols, and standard PS/2 as well.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
