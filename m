Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263157AbTIVOVq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Sep 2003 10:21:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263158AbTIVOVq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Sep 2003 10:21:46 -0400
Received: from nessie.weebeastie.net ([61.8.7.205]:457 "EHLO
	nessie.weebeastie.net") by vger.kernel.org with ESMTP
	id S263157AbTIVOVp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Sep 2003 10:21:45 -0400
Date: Tue, 23 Sep 2003 00:20:23 +1000
From: CaT <cat@zip.com.au>
To: Dave Jones <davej@redhat.com>, Linus Torvalds <torvalds@osdl.org>,
       Kronos <kronos@kronoz.cjb.net>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix Athlon MCA
Message-ID: <20030922142023.GC514@zip.com.au>
References: <20030921143934.GA1867@dreamland.darkstar.lan> <Pine.LNX.4.44.0309211034080.11614-100000@home.osdl.org> <20030921174731.GA891@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030921174731.GA891@redhat.com>
User-Agent: Mutt/1.3.28i
Organisation: Furball Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 21, 2003 at 06:47:31PM +0100, Dave Jones wrote:
> yeah, I prefer that way just for the added comment outside the loop.
> expanding it to mention "some athlons don't work with bank 0 enabled"

Would this MCE message be of the same flavour as the one this
thread is about?

Message from syslogd@lexx at Mon Sep 22 21:38:01 2003 ...
lexx kernel: MCE: The hardware reports a non fatal, correctable incident occurred on CPU 0.

Message from syslogd@lexx at Mon Sep 22 21:38:01 2003 ...
lexx kernel: Bank 2: 940040000000017a

I don't have my stick of RAM plugged into the first RAM slot but rather
the 3rd of 4. I guess this correspends to bank 2 above. I've been ignoring
them uptil now but is this a linux hassle or a h/w one?

-- 
	And so the stripper looks down and asks 'Can you breathe?'
		- from a friend's bucks night
