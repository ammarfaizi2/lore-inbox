Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261237AbVAaPcD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261237AbVAaPcD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jan 2005 10:32:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261238AbVAaPcD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jan 2005 10:32:03 -0500
Received: from 41-052.adsl.zetnet.co.uk ([194.247.41.52]:29192 "EHLO
	mail.esperi.org.uk") by vger.kernel.org with ESMTP id S261237AbVAaPb7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jan 2005 10:31:59 -0500
To: Hugh Dickins <hugh@veritas.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.10: SPARC64 mapped figure goes unsignedly negative...
References: <87sm4izw3u.fsf@amaterasu.srvr.nix>
	<Pine.LNX.4.61.0501311256580.5368@goblin.wat.veritas.com>
From: Nix <nix@esperi.org.uk>
X-Emacs: it's not slow --- it's stately.
Date: Mon, 31 Jan 2005 15:30:54 +0000
In-Reply-To: <Pine.LNX.4.61.0501311256580.5368@goblin.wat.veritas.com> (Hugh
 Dickins's message of "Mon, 31 Jan 2005 13:04:55 +0000 (GMT)")
Message-ID: <87sm4hwr81.fsf@amaterasu.srvr.nix>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Corporate Culture,
 linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 31 Jan 2005, Hugh Dickins suggested tentatively:
> On Sun, 30 Jan 2005, Nix wrote:
>> /proc/meminfo on my UltraSPARC IIi:
>> Mapped:       18446744073687883208 kB
>> 
>> (This kernel is compiled with GCC-3.4.3, which might be relevant.)
> 
> Indeed: sparc64 gcc-3.4 seems to be having trouble with that
> since 2.6.9: we've been persuing it offlist, I'll factor you in.

Excellent; thank you!

(2.6.10 seems to *run* perfectly well on that box, for what it's worth;
unless this is a symptom of some underlying dark and terrible failure,
it looks like a not-very-important cosmetic bug.)

-- 
`Blish is clearly in love with language. Unfortunately,
 language dislikes him intensely.' --- Russ Allbery
