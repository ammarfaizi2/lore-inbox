Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265473AbUABKLQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jan 2004 05:11:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265476AbUABKLQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jan 2004 05:11:16 -0500
Received: from sole.infis.univ.trieste.it ([140.105.134.1]:34239 "EHLO
	sole.infis.univ.trieste.it") by vger.kernel.org with ESMTP
	id S265473AbUABKLF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jan 2004 05:11:05 -0500
Date: Fri, 2 Jan 2004 11:10:51 +0100
From: Andrea Barisani <lcars@gentoo.org>
To: linux-kernel@vger.kernel.org, linux-hotplug-devel@lists.sourceforge.net
Cc: greg@kroah.com
Subject: does udev really require hotplug?
Message-ID: <20040102101051.GA12073@sole.infis.univ.trieste.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-GPG-Key: 0x864C9B9E
X-GPG-Fingerprint: 0A76 074A 02CD E989 CE7F  AC3F DA47 578E 864C 9B9E
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi everybody and happy new year!

Just one simple question about a very simple matter that right now 
I can't figure out: does udev need hotplug package presence?

>From your README:

  If for some reason you do not install the hotplug scripts, you must tell the
  kernel to point the hotplug binary at wherever you install udev at.  This can
  be done by:
	echo "/sbin/udev" > /proc/sys/kernel/hotplug


...does this work properly? It's not clear if some features are lost by not having 
hotplug script installed. Also is this policy subject to changes in the near
future?


Bye and thanks

P.S.
please CC me since I'm not subscribed

-- 
Andrea Barisani <lcars@gentoo.org>                            .*.
Gentoo Linux Infrastructure Developer                          V
                                                             (   )
GPG-Key 0x864C9B9E http://dev.gentoo.org/~lcars/pubkey.asc   (   )
    0A76 074A 02CD E989 CE7F AC3F DA47 578E 864C 9B9E        ^^_^^
