Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272596AbTG1AVm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jul 2003 20:21:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272595AbTG1AVG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jul 2003 20:21:06 -0400
Received: from 5.Red-80-32-157.pooles.rima-tde.net ([80.32.157.5]:35846 "EHLO
	smtp.newipnet.com") by vger.kernel.org with ESMTP id S272585AbTG1AUV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jul 2003 20:20:21 -0400
Message-ID: <200307280235210263.10AADFF8@192.168.128.16>
In-Reply-To: <20030727171403.6e5bcc58.davem@redhat.com>
References: <Pine.LNX.4.53.0307272239570.2743@vialle.bloemsaat.com>
 <200307280140470646.1078EC67@192.168.128.16>
 <20030727164649.517b2b88.davem@redhat.com>
 <200307280158250677.10891156@192.168.128.16>
 <20030727165831.05904792.davem@redhat.com>
 <200307280211590888.10957DD9@192.168.128.16>
 <20030727171403.6e5bcc58.davem@redhat.com>
X-Mailer: Calypso Version 3.30.00.00 (4)
Date: Mon, 28 Jul 2003 02:35:21 +0200
From: "Carlos Velasco" <carlosev@newipnet.com>
To: "David S. Miller" <davem@redhat.com>
Cc: bloemsaa@xs4all.nl, marcelo@conectiva.com.br, netdev@oss.sgi.com,
       linux-net@vger.kernel.org, layes@loran.com, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [2.4 PATCH] bugfix: ARP respond on all devices
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/07/2003 at 17:14 David S. Miller wrote:

>[ Please wrap your lines at 72 characters, you emails are really
>  difficult to read and reply to, thanks. ]

Done.

>This only means your problem can also be fixed by correcting
>your routing tables.

Playing with routing table and using arp_filter.
Or using the hidden patch.
Or using a tool for filtering arp as iparp or netfilter/arpfilter.

IMHO "hidden" is the simpliest (provided it's compiled in the kernel).

>Show me the standard that Linux violates by behaving in this way?
>There are none, our behavior is perfectly acceptable.

Sure it's... I have never said it's wrong, I only say that its
behaviour is different to other OS and it's NOT usual.
And on certain scenaries it could be a desired behaviour.

>Other systems do not give you the capabilities our routing layer does,
>such as route based source address selections.  So it is no surprise
>that they behave differently in this area.

Problem is that linux is unable to behave like the other OS and systems
do in a simple way.
The easy way is the "hidden" patch, if it's applied in the kernel.

Regards,
Carlos Velasco


