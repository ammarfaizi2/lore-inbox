Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261956AbUAFMPN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jan 2004 07:15:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262040AbUAFMPN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jan 2004 07:15:13 -0500
Received: from gprs214-240.eurotel.cz ([160.218.214.240]:32642 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S261956AbUAFMPL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jan 2004 07:15:11 -0500
Date: Tue, 6 Jan 2004 13:16:36 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Andrew Morton <akpm@osdl.org>, James Simmons <jsimmons@infradead.org>
Subject: Re: [PATCH] VT locking
Message-ID: <20040106121636.GA888@elf.ucw.cz>
References: <1073349182.9504.175.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1073349182.9504.175.camel@gaston>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> The VT code is currently, it seems, full of races, it basically doesn't
> do any locking... This patch is definitely not fixing everything,
> but at

And the races bite, BTW. For years I was seeing weird stuff like
console output on blanked console if scroll happened at approximately
same time as blank. It was hard to reproduce reliably, through.
								Pavel

-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
