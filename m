Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262054AbTIPTtq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Sep 2003 15:49:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262406AbTIPTtq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Sep 2003 15:49:46 -0400
Received: from gprs151-26.eurotel.cz ([160.218.151.26]:3203 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262054AbTIPTtp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Sep 2003 15:49:45 -0400
Date: Tue, 16 Sep 2003 21:49:29 +0200
From: Pavel Machek <pavel@suse.cz>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] add likely around access_ok for uaccess
Message-ID: <20030916194929.GF602@elf.ucw.cz>
References: <3F644E36.5010402@colorfullife.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F644E36.5010402@colorfullife.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> while trying to figure out why sysv msg is around 30% slower than pipes 
> for data transfers I noticed that gcc's autodetection (3.2.2) guesses 
> the "if(access_ok())" tests in uaccess.h wrong and puts the error memset 
> into the direct path and the copy out of line.
> 
> The attached patch adds likely to the tests - any objections? What about 
> the archs except i386?

How much speedup did you gain?
								Pavel

-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
