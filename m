Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131290AbRCHIg5>; Thu, 8 Mar 2001 03:36:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131291AbRCHIgs>; Thu, 8 Mar 2001 03:36:48 -0500
Received: from kerberos.suse.cz ([195.47.106.10]:24595 "EHLO kerberos.suse.cz")
	by vger.kernel.org with ESMTP id <S131290AbRCHIgc>;
	Thu, 8 Mar 2001 03:36:32 -0500
Date: Thu, 8 Mar 2001 09:36:05 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: konrad_lkml@gmx.de
Cc: linux-kernel@vger.kernel.org
Subject: Re: IDE bug in 2.4.2-ac12?
Message-ID: <20010308093605.A904@suse.cz>
In-Reply-To: <20010307202016.B5030@suse.cz> <31749.984038475@www28.gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <31749.984038475@www28.gmx.net>; from konrad_lkml@gmx.de on Thu, Mar 08, 2001 at 09:01:15AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 08, 2001 at 09:01:15AM +0100, konrad_lkml@gmx.de wrote:

> Do you mean the Power Supply Unit? Or the Program Storage Unit? ;-)

Power Supply Unit, yes.

> To answer to your questions:
>  - I haven't tried to remove the CD-ROM because both devices shall work 
> together
>  - the ZIP doesn't cause problems when just the power cable is connected
> 
> Although my PC has only got an old Baby AT 200W power supply I don't think 
> that's the point.

I don't see any other way how the ZIP could have impact on the IDE HDD
on a different IDE interface.

If you wonder why /proc/ide/via reports slower DMA rates for the HDD
when the ZIP is connected is because the auto slowdown code kicks in and
lowers the transfer rate when too many CRC errors happen.

-- 
Vojtech Pavlik
SuSE Labs
