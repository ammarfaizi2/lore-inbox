Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266248AbUHCM4A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266248AbUHCM4A (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Aug 2004 08:56:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266353AbUHCMzy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Aug 2004 08:55:54 -0400
Received: from grendel.digitalservice.pl ([217.67.200.140]:52119 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S266248AbUHCMzr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Aug 2004 08:55:47 -0400
From: "R. J. Wysocki" <rjwysocki@sisk.pl>
Organization: SiSK
To: Mark Watts <m.watts@eris.qinetiq.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.8-rc2-mm2
Date: Tue, 3 Aug 2004 15:05:37 +0200
User-Agent: KMail/1.5
Cc: Andrew Morton <akpm@osdl.org>
References: <20040802015527.49088944.akpm@osdl.org> <200408030927.18395.m.watts@eris.qinetiq.com>
In-Reply-To: <200408030927.18395.m.watts@eris.qinetiq.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200408031505.37005.rjwysocki@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 03 of August 2004 10:27, Mark Watts wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>
>
> Something bad might have slipped in to do with dual opterons.

I've run it successfully on a dual-Opteron system, so it's not related to dual 
Opterons in general.  Could you be more specific, please?

> Whenever I boot, I get a kernel panic right after it brings up the
> processors.
>
> console=ttyS0 only lets me see
> 'Kernel unable to handle ...'  with the rest cut off.
>
> If I boot normally, there's a couple of oops' or panics on the screen but
> the roll by to fast to see.
>
> .config is attched and its the same config that boots 2.6.8rc2 just fine.

Ah, I've set CONFIG_NR_CPUS=2.  The rest looks similarly.

Greets,
R.

-- 
Rafael J. Wysocki
[tel. (+48) 605 053 693]
----------------------------
For a successful technology, reality must take precedence over public 
relations, for nature cannot be fooled.
					-- Richard P. Feynman
