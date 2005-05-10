Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261815AbVEJV0C@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261815AbVEJV0C (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 May 2005 17:26:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261813AbVEJV0B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 May 2005 17:26:01 -0400
Received: from main.gmane.org ([80.91.229.2]:13740 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S261815AbVEJVXk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 May 2005 17:23:40 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Giuseppe Bilotta <bilotta78@hotpop.com>
Subject: Re: [ANNOUNCE] hotplug-ng 002 release
Date: Tue, 10 May 2005 23:21:50 +0200
Message-ID: <9uws1jrpglc$.tcdpt0xg3ytu.dlg@40tude.net>
References: <20050506212227.GA24066@kroah.com> <1115611034.14447.11.camel@localhost.localdomain> <20050509232103.GA24238@suse.de> <1115717357.10222.1.camel@localhost.localdomain> <20050510094339.GC6346@wonderland.linux.it> <4280AFF4.6080108@ums.usu.ru> <20050510172447.GA11263@wonderland.linux.it> <20050510201355.GB3226@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: adsl-ull-253-118.44-151.net24.it
User-Agent: 40tude_Dialog/2.0.15.1
Cc: linux-hotplug-devel@lists.sourceforge.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 May 2005 13:13:55 -0700, Greg KH wrote:

> Also, the blacklisting stuff should not be
> that prevelant anymore...

Is there a way to control the order in which modules get loaded? For
example, I usually blacklist the parport module and only load it when
I need it, thus freeing an IRQ (for audio, IIRC). If parport loads
automatically, it grabs the IRQ; if it loads after the IRQ is grabbed
already, it'll resort to polled mode. Can these things be controlled
without the blacklist?

-- 
Giuseppe "Oblomov" Bilotta

"I'm never quite so stupid
 as when I'm being smart" --Linus van Pelt

