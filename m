Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267248AbTAGABE>; Mon, 6 Jan 2003 19:01:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267254AbTAGABE>; Mon, 6 Jan 2003 19:01:04 -0500
Received: from dhcp024-209-039-102.neo.rr.com ([24.209.39.102]:44677 "EHLO
	neo.rr.com") by vger.kernel.org with ESMTP id <S267248AbTAGABC>;
	Mon, 6 Jan 2003 19:01:02 -0500
Date: Mon, 6 Jan 2003 19:12:20 +0000
From: Adam Belay <ambx1@neo.rr.com>
To: Kaleb Pederson <kibab@icehouse.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: windows=stable, linux=5 reboots/50 min
Message-ID: <20030106191220.GD23277@neo.rr.com>
Mail-Followup-To: Adam Belay <ambx1@neo.rr.com>,
	Kaleb Pederson <kibab@icehouse.net>, linux-kernel@vger.kernel.org
References: <LDEEIFJOHNKAPECELHOAKEJFCCAA.kibab@icehouse.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <LDEEIFJOHNKAPECELHOAKEJFCCAA.kibab@icehouse.net>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 06, 2003 at 10:57:03PM -0800, Kaleb Pederson wrote:
> After a recent hard drive crash, I re-installed Linux to a new hard drive.
> After about 2 weeks, my system now spontaneously reboots about once per 10
> minutes (on avg.).  I'm assuming I messed up something in my kernel
> configuration as Windows is still stable. To verify that it wasn't the new
> hard drive (or use of different controller) I formatted a segment of it
> under Windows and copied 7+ gb of data onto it while doing other things
> without problem.
> 
> The system will reboot as early as after detecting the hard drives and
> before loading the root filesystem or anytime thereafter - sometimes in
> logging into the console, sometimes in X.
> 

Hmm, I've observed this behavior with apm on certian buggy systems, though
it was several versions ago.  Are you using apm, acpi, or neither?
Considering both control power management, I would try disabling them as a
test.

Regards,
Adam
