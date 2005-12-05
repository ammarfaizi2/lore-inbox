Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751426AbVLETGQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751426AbVLETGQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Dec 2005 14:06:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751430AbVLETGQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Dec 2005 14:06:16 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:35204 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751426AbVLETFx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Dec 2005 14:05:53 -0500
Date: Mon, 5 Dec 2005 14:21:43 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: Linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Could not suspend device [VIA UHCI USB controller]: error -22
Message-ID: <20051205132143.GC7478@elf.ucw.cz>
References: <43923479.3020305@tls.msk.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43923479.3020305@tls.msk.ru>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Also, "suspend to mem" does just nothing, -- the same as "suspend to disk"
> (but for disk, it never worked at all as stated above).

Can you quote exact messages? Suspend to mem should not have problems
without 4MB pages, as it does not do any pagetables related magic. If
it does include same check, it is bug and should be easy to fix.

								Pavel
-- 
Thanks, Sharp!
