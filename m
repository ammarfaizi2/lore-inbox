Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261264AbVCYAsj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261264AbVCYAsj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Mar 2005 19:48:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261276AbVCYAsc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Mar 2005 19:48:32 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:49936 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261296AbVCYALN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Mar 2005 19:11:13 -0500
Date: Fri, 25 Mar 2005 01:11:06 +0100
From: Adrian Bunk <bunk@stusta.de>
To: dtor_core@ameritech.net
Cc: linux-input@atrey.karlin.mff.cuni.cz, vojtech@suse.cz,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] drivers/input/serio/libps2.c: ps2_command: add a missing check
Message-ID: <20050325001106.GE3966@stusta.de>
References: <20050324031447.GY1948@stusta.de> <200503240013.16573.dtor_core@ameritech.net> <20050324212602.GD3966@stusta.de> <d120d5000503241339b0b5312@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d120d5000503241339b0b5312@mail.gmail.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 24, 2005 at 04:39:31PM -0500, Dmitry Torokhov wrote:
> 
> Yes, if it will make the checker happy. Although I (and this is
> probably just me) use BUG_ON only if kernel would not OOPS otherwise,
> to avoid scribbling over random memory and such.

I don't whether it would make the checker happy (and I don't care much).

It would IMHO make the code better understandable.

But I don't have a very strong opinion on this issue.

> Dmitry

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

