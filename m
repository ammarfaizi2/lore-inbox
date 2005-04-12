Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262602AbVDMDfr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262602AbVDMDfr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 23:35:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262310AbVDMDdm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 23:33:42 -0400
Received: from ns2.suse.de ([195.135.220.15]:54956 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S262608AbVDLTcU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 15:32:20 -0400
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Andrew Morton <akpm@osdl.org>, linuxppc64-dev <linuxppc64-dev@ozlabs.org>,
       Linus Torvalds <torvalds@osdl.org>, Andrea Arcangeli <andrea@suse.de>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ppc64: very basic desktop g5 sound support (#2)
References: <1113282436.21548.42.camel@gaston>
From: Andreas Schwab <schwab@suse.de>
X-Yow: ..  someone in DAYTON, Ohio is selling USED CARPETS to a
 SERBO-CROATIAN
Date: Tue, 12 Apr 2005 21:32:19 +0200
In-Reply-To: <1113282436.21548.42.camel@gaston> (Benjamin Herrenschmidt's
 message of "Tue, 12 Apr 2005 15:07:16 +1000")
Message-ID: <jell7nu6yk.fsf@sykes.suse.de>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:

> This patch hacks the current PowerMac Alsa driver to add some basic
> support of analog sound output to some desktop G5s. It has severe
> limitations though:
>
>  - Only 44100Khz 16 bits
>  - Only work on G5 models using a TAS3004 analog code, that is early
>    single CPU desktops and all dual CPU desktops at this date, but none
>    of the more recent ones like iMac G5.
>  - It does analog only, no digital/SPDIF support at all, no native
>    AC3 support

On my PowerMac the internal speaker is now working, but unfortunately on
the line-out I get nearly no output.  I have pushed both the master and
pcm control to the maximum and still barely hear anything.

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux Products GmbH, Maxfeldstraße 5, 90409 Nürnberg, Germany
Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
