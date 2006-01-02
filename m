Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750870AbWABRjO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750870AbWABRjO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jan 2006 12:39:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750872AbWABRjO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jan 2006 12:39:14 -0500
Received: from cantor.suse.de ([195.135.220.2]:10941 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750841AbWABRjO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jan 2006 12:39:14 -0500
From: Andi Kleen <ak@suse.de>
To: Adrian Bunk <bunk@stusta.de>
Subject: Re: 2.6.15-rc7: known regressions
Date: Mon, 2 Jan 2006 18:38:37 +0100
User-Agent: KMail/1.8.2
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.64.0512241930370.14098@g5.osdl.org> <200601021807.52533.ak@suse.de> <20060102172340.GI17398@stusta.de>
In-Reply-To: <20060102172340.GI17398@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601021838.38310.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 02 January 2006 18:23, Adrian Bunk wrote:

> Would you veto against a section "known regressions" in the final 2.6.15
> announcement listing this issue with a link to the Bugzilla bug?

Yes for this case. The original was likely so fragile that it might
break only with minor changes in the hardware configuration.

In general listing known regressions is a good idea though.

It might be a good idea to give them different priorities though - e.g.
a broken BIOS with a missing workaround is less priority than
a pure Linux bug.

-Andi

