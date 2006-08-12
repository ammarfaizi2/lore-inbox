Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964960AbWHLWRQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964960AbWHLWRQ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Aug 2006 18:17:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964958AbWHLWRQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Aug 2006 18:17:16 -0400
Received: from 41-052.adsl.zetnet.co.uk ([194.247.41.52]:59406 "EHLO
	mail.esperi.org.uk") by vger.kernel.org with ESMTP id S964956AbWHLWRP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Aug 2006 18:17:15 -0400
To: linux-kernel@vger.kernel.org
Cc: Neil Brown <neilb@suse.de>, netdev@vger.kernel.org
Subject: Re: [2.6.17.8] NFS stall / BUG in UDP fragment processing / SKB trimming
References: <87zme9fy94.fsf@hades.wkstn.nix>
From: Nix <nix@esperi.org.uk>
X-Emacs: freely redistributable; void where prohibited by law.
Date: Sat, 12 Aug 2006 23:17:11 +0100
In-Reply-To: <87zme9fy94.fsf@hades.wkstn.nix> (nix@esperi.org.uk's message of "12 Aug 2006 22:21:26 +0100")
Message-ID: <87d5b5vbtk.fsf@hades.wkstn.nix>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.19 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12 Aug 2006, nix@esperi.org.uk mused:
> Then the build froze. I couldn't very well ignore *that*. Perhaps I
> couldn't blame XEmacs after all.

It just happened again. It's reproducibly triggered, at least on this
system, by the ocaml-3.09.02 configure script running over NFS (probably
NFS over UDP is necessary as well).

In theory I could now use this to minimise the problem, but the sheer
number of reboots this is likely to need is dissuading me: I'll put it
off until someone actually wants such a minimal crash case :)

-- 
`We're sysadmins. We deal with the inconceivable so often I can clearly 
 see the need to define levels of inconceivability.' --- Rik Steenwinkel
