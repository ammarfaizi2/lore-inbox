Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272606AbTG1AYy (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jul 2003 20:24:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272601AbTG1AYm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jul 2003 20:24:42 -0400
Received: from pizda.ninka.net ([216.101.162.242]:21939 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S272379AbTG1AYH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jul 2003 20:24:07 -0400
Date: Sun, 27 Jul 2003 17:36:00 -0700
From: "David S. Miller" <davem@redhat.com>
To: "Carlos Velasco" <carlosev@newipnet.com>
Cc: bloemsaa@xs4all.nl, marcelo@conectiva.com.br, netdev@oss.sgi.com,
       linux-net@vger.kernel.org, layes@loran.com, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [2.4 PATCH] bugfix: ARP respond on all devices
Message-Id: <20030727173600.475d95fb.davem@redhat.com>
In-Reply-To: <200307280235210263.10AADFF8@192.168.128.16>
References: <Pine.LNX.4.53.0307272239570.2743@vialle.bloemsaat.com>
	<200307280140470646.1078EC67@192.168.128.16>
	<20030727164649.517b2b88.davem@redhat.com>
	<200307280158250677.10891156@192.168.128.16>
	<20030727165831.05904792.davem@redhat.com>
	<200307280211590888.10957DD9@192.168.128.16>
	<20030727171403.6e5bcc58.davem@redhat.com>
	<200307280235210263.10AADFF8@192.168.128.16>
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.6; sparc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Jul 2003 02:35:21 +0200
"Carlos Velasco" <carlosev@newipnet.com> wrote:

> On 27/07/2003 at 17:14 David S. Miller wrote:
> >Other systems do not give you the capabilities our routing layer does,
> >such as route based source address selections.  So it is no surprise
> >that they behave differently in this area.
> 
> Problem is that linux is unable to behave like the other OS and systems
> do in a simple way.
> The easy way is the "hidden" patch, if it's applied in the kernel.

Not true, anyone is free to design a graphical GUI or shell script (or
even a wrapper for the /sbin/ip tool) that gives you the default
behavior you want, without any user interaction whatsoever.
