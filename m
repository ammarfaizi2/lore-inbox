Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261926AbUBWP13 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Feb 2004 10:27:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261927AbUBWP13
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Feb 2004 10:27:29 -0500
Received: from adsl-065-083-130-194.sip.int.bellsouth.net ([65.83.130.194]:56569
	"HELO mail.kotisprop.com") by vger.kernel.org with SMTP
	id S261926AbUBWP1P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Feb 2004 10:27:15 -0500
Subject: Re: Sound choppy when switching scaling_gov
From: Adam Voigt <adam@kotisprop.com>
Reply-To: adam@kotisprop.com
To: Jonas Diemer <diemer@gmx.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20040221110948.5f023281.diemer@gmx.de>
References: <20040221110948.5f023281.diemer@gmx.de>
Content-Type: text/plain
Organization: Kotis Properties
Message-Id: <1077550109.1978.2.camel@globex.kotisprop.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Mon, 23 Feb 2004 10:28:30 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Does re-nicing the xmms process to a higher priority fix it? I had this
same problem, and re-nicing fixed it (well, hack-fixed it). I think
someone made mention of new 2.6 features like pre-emption, or the like
fixing it. Though, I'm a kernel newb, so that maybe incorrect.


On Sat, 2004-02-21 at 05:09, Jonas Diemer wrote:
> Hi!
> 
> I am experiencing choppy sound playback with xmms. For example, when I
> keep switching workspaces in my WindowManager, the sound is nearly not
> usable. But also during normal work, mp3 playback is somewhat chopy.
> 
> This only occurs after I change the scaling_gov. Not after every change
> though. If it happens, and I change the scaling gov again, sound
> eventually is ok again.
> 
> I have a Pentium III 1.13GHz Laptop with a snd_intel8x0 soundchip. The
> CPU (should) run at 733Mhz in powersave, so mp3 playback should be ok...
> 
> My Kernel is 2.6.2 (haven't tried the new one yet).
> 
> regards
> Jonas
> 
> PS: CC me in your replies, please.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
-- 

Adam Voigt
adam@kotisprop.com


