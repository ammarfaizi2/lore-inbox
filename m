Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751148AbWHMMaU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751148AbWHMMaU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Aug 2006 08:30:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751152AbWHMMaT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Aug 2006 08:30:19 -0400
Received: from 41-052.adsl.zetnet.co.uk ([194.247.41.52]:48146 "EHLO
	mail.esperi.org.uk") by vger.kernel.org with ESMTP id S1751148AbWHMMaR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Aug 2006 08:30:17 -0400
To: linux-kernel@vger.kernel.org
Cc: Neil Brown <neilb@suse.de>, netdev@vger.kernel.org
Subject: Re: [2.6.17.8] NFS stall / BUG in UDP fragment processing / SKB trimming
References: <87zme9fy94.fsf@hades.wkstn.nix> <87d5b5vbtk.fsf@hades.wkstn.nix>
From: Nix <nix@esperi.org.uk>
X-Emacs: because editing your files should be a traumatic experience.
Date: Sun, 13 Aug 2006 13:29:55 +0100
In-Reply-To: <87d5b5vbtk.fsf@hades.wkstn.nix> (nix@esperi.org.uk's message of "12 Aug 2006 23:17:42 +0100")
Message-ID: <87psf4zum4.fsf@hades.wkstn.nix>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.19 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12 Aug 2006, nix@esperi.org.uk wrote:
> On 12 Aug 2006, nix@esperi.org.uk mused:
>> Then the build froze. I couldn't very well ignore *that*. Perhaps I
>> couldn't blame XEmacs after all.
> 
> It just happened again. It's reproducibly triggered, at least on this
> system, by the ocaml-3.09.02 configure script running over NFS (probably
> NFS over UDP is necessary as well).

... also triggered by running a CVS update on a large tree, and pretty
much by doing anything heavy-duty with NFS on UDP at all.

NFS on TCP is, as expected, unaffected by this bug.

-- 
`We're sysadmins. We deal with the inconceivable so often I can clearly 
 see the need to define levels of inconceivability.' --- Rik Steenwinkel
