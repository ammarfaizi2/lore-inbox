Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263064AbUC2SZK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Mar 2004 13:25:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263066AbUC2SZK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Mar 2004 13:25:10 -0500
Received: from obsidian.spiritone.com ([216.99.193.137]:14233 "EHLO
	obsidian.spiritone.com") by vger.kernel.org with ESMTP
	id S263064AbUC2SZB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Mar 2004 13:25:01 -0500
Date: Mon, 29 Mar 2004 10:25:09 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: seriel console support broken in -mm4 and -mm5
Message-ID: <190920000.1080584708@[10.10.2.4]>
In-Reply-To: <189440000.1080583215@[10.10.2.4]>
References: <189440000.1080583215@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> It works fine in -rc2.
> 
> -mm4 prints jibberish (wrong speed / settings?) for serial console, but
> the getty stuff comes out file. shutdown just prints more jibberish.
> 
> -mm5 prints about half as much jibberish as -mm4 then hangs, seemingly
> halfway through boot.
> 
> I guess I'll try linus.patch from -mm4 next, unless you have any other
> suggestions that'd be more fruitful ...

OK, so -mm5 actually does the same as mm4 on my second try, so maybe the
hang is intermittent, or something.

However, linus.patch from -mm4 works fine, so the culprit is one of the
other patches in your tree ... any suggestions for which to shoot first? ;-)

M.

