Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310920AbSCMRmk>; Wed, 13 Mar 2002 12:42:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310918AbSCMRma>; Wed, 13 Mar 2002 12:42:30 -0500
Received: from mail.pha.ha-vel.cz ([195.39.72.3]:59656 "HELO
	mail.pha.ha-vel.cz") by vger.kernel.org with SMTP
	id <S310910AbSCMRmU>; Wed, 13 Mar 2002 12:42:20 -0500
Date: Wed, 13 Mar 2002 18:42:12 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Martin Dalecki <dalecki@evision-ventures.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] IDE 21
Message-ID: <20020313184212.A31198@ucw.cz>
In-Reply-To: <Pine.LNX.4.33.0202220901470.6365-100000@home.transmeta.com> <3C8F5EDF.4050802@evision-ventures.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3C8F5EDF.4050802@evision-ventures.com>; from dalecki@evision-ventures.com on Wed, Mar 13, 2002 at 03:14:55PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 13, 2002 at 03:14:55PM +0100, Martin Dalecki wrote:

> If I was to give this patch a name it would be:
> 
> "Vojtech Pavlik unleashed from the chains".
> 
> So credit where credit is due :-).

For bugs as well. :(

In the FIT macro in ide-timing.h the argument got swapped because of a
typo. All timings generated for VIA and AMD chips are wrong because of
that. Safe, though, but slow.

-- 
Vojtech Pavlik
SuSE Labs
