Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272621AbTG1BKR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jul 2003 21:10:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272615AbTG1BIw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jul 2003 21:08:52 -0400
Received: from 5.Red-80-32-157.pooles.rima-tde.net ([80.32.157.5]:1543 "EHLO
	smtp.newipnet.com") by vger.kernel.org with ESMTP id S272548AbTG1BIC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jul 2003 21:08:02 -0400
Message-ID: <200307280323020667.10D68954@192.168.128.16>
In-Reply-To: <20030727175557.1d624b36.davem@redhat.com>
References: <Pine.LNX.4.53.0307272239570.2743@vialle.bloemsaat.com>
 <200307280140470646.1078EC67@192.168.128.16>
 <20030727164649.517b2b88.davem@redhat.com>
 <200307280158250677.10891156@192.168.128.16>
 <20030727165831.05904792.davem@redhat.com>
 <200307280211590888.10957DD9@192.168.128.16>
 <20030727171403.6e5bcc58.davem@redhat.com>
 <200307280235210263.10AADFF8@192.168.128.16>
 <20030727173600.475d95fb.davem@redhat.com>
 <200307280253090799.10BB2DF0@192.168.128.16>
 <20030727175557.1d624b36.davem@redhat.com>
X-Mailer: Calypso Version 3.30.00.00 (4)
Date: Mon, 28 Jul 2003 03:23:02 +0200
From: "Carlos Velasco" <carlosev@newipnet.com>
To: "David S. Miller" <davem@redhat.com>
Cc: bloemsaa@xs4all.nl, marcelo@conectiva.com.br, netdev@oss.sgi.com,
       linux-net@vger.kernel.org, layes@loran.com, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [2.4 PATCH] bugfix: ARP respond on all devices
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/07/2003 at 17:55 David S. Miller wrote:

>With or without your suggestion, people have to do something
>different.

Just enabling the hidden switch solved my setting and I think it solves
most of "problem" settings.

>This doesn't even address all the problems there are with
>the hidden patch.  It does things that belong on the netfilter
>level and not on the ARP/routing level.

Well... it's just your opinion... other OS and systems don't use
netfilter of firewalling at all (ex. Win) and behave like with "hidden"
applied.
Really, the only one I have tested that not do it is Linux 2.2+

For me (not a kernel developer), my world are the OSI layers, and the
isolation of the interfaces at layer 2 IMHO should be in the kernel not
any firewall module that you must install, tune and configure.

>Again, I'd like you to read all the discussions that have happened on
>this topic in the past, in particular those made by Alexey Kuznetsov
>on this topic.  He gives very clear and concise reasons why the
>"hidden" patch is logically doing things in the wrong part of the
>kernel, and therefore won't ever be put into the tree.

I will look... but doing arp filter is not a real simple solution in
any way.

Regards,
Carlos Velasco


