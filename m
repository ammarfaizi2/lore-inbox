Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291449AbSBHHRf>; Fri, 8 Feb 2002 02:17:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291450AbSBHHRZ>; Fri, 8 Feb 2002 02:17:25 -0500
Received: from mail.pha.ha-vel.cz ([195.39.72.3]:4112 "HELO mail.pha.ha-vel.cz")
	by vger.kernel.org with SMTP id <S291449AbSBHHRK>;
	Fri, 8 Feb 2002 02:17:10 -0500
Date: Fri, 8 Feb 2002 08:17:08 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Hal Duston <hald@sound.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Input w/2.5.3-dj3
Message-ID: <20020208081708.A2995@suse.cz>
In-Reply-To: <Pine.GSO.4.10.10202071151580.16311-100000@sound.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.GSO.4.10.10202071151580.16311-100000@sound.net>; from hald@sound.net on Thu, Feb 07, 2002 at 11:55:19AM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 07, 2002 at 11:55:19AM -0600, Hal Duston wrote:

> OK, I have checked my config.  The only item I was missing
> was CONFIG_KEYBOARD_XTKBD=y.

You had it all then - CONFIG_KEYBOARD_XTKBD isn't needed.

> I have now added that, and 
> still no keyboard activity.  This is a laptop from 1994
> or so, so it's not exactly new stuff.

The old stuff and namely laptops is the most crazy where it comes to
compatibility in the keyboard area. So it may be the code fails for some
reason on your laptop.

> What should I check next?

Can you please enable #define I8042_DEBUG_IO in i8042.h and ATKBD_DEBUG
in atkbd.c, recompile, and send me the relevant 'dmesg' of your boot
with the -dj kernel?

I'll try to fix the problem then.

Thanks.

-- 
Vojtech Pavlik
SuSE Labs
