Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261609AbSKTRCW>; Wed, 20 Nov 2002 12:02:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261613AbSKTRCW>; Wed, 20 Nov 2002 12:02:22 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:56334 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S261609AbSKTRCT>;
	Wed, 20 Nov 2002 12:02:19 -0500
Message-ID: <3DDBC1B5.9010409@pobox.com>
Date: Wed, 20 Nov 2002 12:09:09 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2b) Gecko/20021018
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Josh Myer <jbm@joshisanerd.com>
CC: Jacob Kroon <d00jkr@efd.lth.se>, linux-kernel@vger.kernel.org
Subject: Re: OSS VIA82cxxx sound driver problem.
References: <Pine.LNX.4.44.0211201005050.30881-100000@blessed.joshisanerd.com>
In-Reply-To: <Pine.LNX.4.44.0211201005050.30881-100000@blessed.joshisanerd.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Josh Myer wrote:

> Give 2.5.x a shot. In some versions there's a buglet, which was hopefully
> fixed (I kludged a patch, then the maintainer sent a proper one, and I
> haven't had time to try it out).
>
> I saw similar problems under 2.4 (it almost seems like the chipset is
> expecting aligned input; lots of errors after closing the device at the
> end of a song), but they went away when switching to 2.5.44.
>
> Basically, the OSS driver for this chipset is hopelessly bad (no offense
> Jeff!), but ALSA one is pretty well-done and handles the quirks of the
> device.



No offense taken.  I always encourage honesty in bug reports, even if 
that means I or my drivers get blown to pieces ;-)

I've had trouble finding test hardware I can play with for debugging, 
and haven't had time to review ALSA's driver in depth to evaluate the 
differences.  Patches are certainly welcome ;-)

[I need to attack the driver anyway, because I need to add VT8233 support]

	Jeff



