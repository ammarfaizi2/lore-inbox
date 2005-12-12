Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751237AbVLLLat@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751237AbVLLLat (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Dec 2005 06:30:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751238AbVLLLat
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Dec 2005 06:30:49 -0500
Received: from 41-052.adsl.zetnet.co.uk ([194.247.41.52]:32782 "EHLO
	mail.esperi.org.uk") by vger.kernel.org with ESMTP id S1751237AbVLLLat
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Dec 2005 06:30:49 -0500
To: Ingo Molnar <mingo@elte.hu>
Cc: Linus Torvalds <torvalds@osdl.org>, Helge Hafting <helgehaf@aitel.hist.no>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.15-rc5: multiuser scheduling trouble
References: <Pine.LNX.4.64.0512032155290.3099@g5.osdl.org>
	<20051210162759.GA15986@aitel.hist.no>
	<Pine.LNX.4.64.0512111607040.15597@g5.osdl.org>
	<20051212065150.GA8187@elte.hu>
From: Nix <nix@esperi.org.uk>
X-Emacs: anything free is worth what you paid for it.
Date: Mon, 12 Dec 2005 11:30:22 +0000
In-Reply-To: <20051212065150.GA8187@elte.hu> (Ingo Molnar's message of "12
 Dec 2005 06:54:39 -0000")
Message-ID: <87vexuy2lt.fsf@amaterasu.srvr.nix>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Corporate Culture,
 linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12 Dec 2005, Ingo Molnar announced authoritatively:
> does this mean X defaults to nice level 0, and then if you renice
> Firefox and X by +10, everything is fine? Or is Linus' suspicion, and X
> defaults to something like nice -5? (e.g. on Debian type of systems)

Your latter suspicion is correct, on Debian at least: see the setting of
nice_value in /etc/X11/Xwrapper.config.

-- 
`Don't confuse the shark with the remoras.' --- Rob Landley

