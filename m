Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261242AbVGDHqw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261242AbVGDHqw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Jul 2005 03:46:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261413AbVGDHqw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Jul 2005 03:46:52 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:18641 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261242AbVGDHfS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Jul 2005 03:35:18 -0400
Date: Mon, 4 Jul 2005 09:35:11 +0200
From: Pavel Machek <pavel@suse.cz>
To: Stefan Seyfried <seife@suse.de>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [patch] call device_shutdown with interrupts enabled
Message-ID: <20050704073511.GF15370@elf.ucw.cz>
References: <20050703214929.GA9214@elf.ucw.cz> <42C8D83A.70705@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42C8D83A.70705@suse.de>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Do not call device_shutdown with interrupts disabled. It is wrong and
> > produces ugly warnings.
> 
> Hm. How about (possible whitespace damage):

Hmm, right, that's better patch. Applied (will push upstream with next
batch).
							Pavel
-- 
teflon -- maybe it is a trademark, but it should not be.
