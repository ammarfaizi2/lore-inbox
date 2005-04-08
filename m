Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262946AbVDHUYO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262946AbVDHUYO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Apr 2005 16:24:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262949AbVDHUYO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Apr 2005 16:24:14 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:57554 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262946AbVDHUQ2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Apr 2005 16:16:28 -0400
Date: Fri, 8 Apr 2005 22:16:07 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       schwidefsky@de.ibm.com, netdev@oss.sgi.com
Subject: Re: [PATCH] s390: claw network device driver
Message-ID: <20050408201606.GA1429@elf.ucw.cz>
References: <200503290533.j2T5XEYT028850@hera.kernel.org> <4248FBFD.5000809@pobox.com> <20050328230830.5e90396f.akpm@osdl.org> <20050329071002.GA16204@havoc.gtf.org> <20050329152057.GA27840@wohnheim.fh-wedel.de> <4249B52C.2000300@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4249B52C.2000300@pobox.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >>As mentioned in the email, you want netdev, not linux-net...
> >
> >
> >Just out of curiosity: why are there two mailing lists?  Especially if
> >one of them is the Wrong One.
> 
> <shrug>
> 
> linux-net is mostly dead.  I get the impression it is occasionally used 
> by users.
> 
> netdev (as, perhaps, the name implies) is where the network developers 
> hang out.

Eh...

pavel@Elf:~/bin$ grep linux-net /usr/src/linux/MAINTAINERS
L:      linux-net@vger.kernel.org
L:      linux-net@vger.kernel.org
L:      linux-net@vger.kernel.org
L:      linux-net@vger.kernel.org
L:      linux-net@vger.kernel.org
L:      linux-net@vger.kernel.org
L:      linux-net@vger.kernel.org
L:      linux-net@vger.kernel.org
L:      linux-net@vger.kernel.org
L:      linux-net@vger.kernel.org
L:      linux-net@vger.kernel.org
L:      linux-net@vger.kernel.org
L:      linux-net@vger.kernel.org
L:      linux-net@vger.kernel.org
L:      linux-net@vger.kernel.org
L:      linux-net@vger.kernel.org
L:      linux-net@vger.kernel.org
L:      linux-net@vger.kernel.org
L:      linux-net@vger.kernel.org
pavel@Elf:~/bin$

More importantly, it is still listed as "the list" for network
drivers...

NETWORK DEVICE DRIVERS
P:      Andrew Morton
M:      akpm@osdl.org
P:      Jeff Garzik
M:      jgarzik@pobox.com
L:      linux-net@vger.kernel.org
S:      Maintained

NETWORKING [GENERAL]
P:      Networking Team
M:      netdev@oss.sgi.com
L:      linux-net@vger.kernel.org
S:      Maintained

							Pavel

-- 
Boycott Kodak -- for their patent abuse against Java.
