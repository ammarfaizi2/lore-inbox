Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268525AbUIZJkq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268525AbUIZJkq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Sep 2004 05:40:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268576AbUIZJkq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Sep 2004 05:40:46 -0400
Received: from cantor.suse.de ([195.135.220.2]:15532 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S268525AbUIZJkp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Sep 2004 05:40:45 -0400
Date: Sun, 26 Sep 2004 11:40:44 +0200
From: Olaf Hering <olh@suse.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ppc64: Fix 32 bits conversion of SI_TIMER signals
Message-ID: <20040926094044.GB15204@suse.de>
References: <1096156004.18236.49.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1096156004.18236.49.camel@gaston>
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes (und GroupWise)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 On Sun, Sep 26, Benjamin Herrenschmidt wrote:

> +		err |= __put_user((u32)(u64)s->si_ptr, &d->si_ptr);

That one surely doesnt work. Let me try it again.

-- 
USB is for mice, FireWire is for men!

sUse lINUX ag, nÜRNBERG
