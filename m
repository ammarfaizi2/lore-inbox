Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310825AbSCMRVJ>; Wed, 13 Mar 2002 12:21:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310811AbSCMRU7>; Wed, 13 Mar 2002 12:20:59 -0500
Received: from mail.pha.ha-vel.cz ([195.39.72.3]:30728 "HELO
	mail.pha.ha-vel.cz") by vger.kernel.org with SMTP
	id <S310825AbSCMRU4>; Wed, 13 Mar 2002 12:20:56 -0500
Date: Wed, 13 Mar 2002 18:20:54 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Guennadi Liakhovetski <gl@dsa-ac.de>
Cc: ARM Linux kernel <linux-arm-kernel@lists.arm.linux.org.uk>,
        linux-kernel@vger.kernel.org
Subject: Re: CONFIG_SOUND_GAMEPORT in 2.5
Message-ID: <20020313182054.A31062@ucw.cz>
In-Reply-To: <Pine.LNX.4.33.0203131625510.15512-100000@pcgl.dsa-ac.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.33.0203131625510.15512-100000@pcgl.dsa-ac.de>; from gl@dsa-ac.de on Wed, Mar 13, 2002 at 04:27:49PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 13, 2002 at 04:27:49PM +0100, Guennadi Liakhovetski wrote:

> Hello everybody. The following extract from
> drivers/input/gameport/Config.in doesn't seem quite right to me, in
> general and for ARM specifically:
> if [ "$CONFIG_GAMEPORT" = "m" ]; then
> 	define_tristate CONFIG_SOUND_GAMEPORT m
> fi
> if [ "$CONFIG_GAMEPORT" != "m" ]; then
> 	define_tristate CONFIG_SOUND_GAMEPORT y
> fi
> 
> Could the maintainer please change this?

What's the problem here?

-- 
Vojtech Pavlik
SuSE Labs
