Return-Path: <linux-kernel-owner+w=401wt.eu-S932096AbXAIT0a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932096AbXAIT0a (ORCPT <rfc822;w@1wt.eu>);
	Tue, 9 Jan 2007 14:26:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932098AbXAIT0a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Jan 2007 14:26:30 -0500
Received: from agminet01.oracle.com ([141.146.126.228]:25999 "EHLO
	agminet01.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932096AbXAIT03 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Jan 2007 14:26:29 -0500
Date: Tue, 9 Jan 2007 11:24:16 -0800
From: Randy Dunlap <randy.dunlap@oracle.com>
To: Krzysztof Halasa <khc@pm.waw.pl>
Cc: Auke Kok <auke-jan.h.kok@intel.com>, Andrew Morton <akpm@osdl.org>,
       Jeff Garzik <jgarzik@pobox.com>, NetDev <netdev@vger.kernel.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Arjan van de Ven <arjan@linux.intel.com>
Subject: Re: [PATCH -MM] e1000: rewrite hardware initialization code
Message-Id: <20070109112416.266efb84.randy.dunlap@oracle.com>
In-Reply-To: <m3fyakau44.fsf@defiant.localdomain>
References: <45A3D29D.1000202@intel.com>
	<m3fyakau44.fsf@defiant.localdomain>
Organization: Oracle Linux Eng.
X-Mailer: Sylpheed 2.3.0 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Whitelist: TRUE
X-Whitelist: TRUE
X-Brightmail-Tracker: AAAAAQAAAAI=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 09 Jan 2007 20:16:27 +0100 Krzysztof Halasa wrote:

> Auke Kok <auke-jan.h.kok@intel.com> writes:
> 
> >  drivers/net/e1000/Makefile            |   19
> >  drivers/net/e1000/e1000.h             |   95
> >  drivers/net/e1000/e1000_80003es2lan.c | 1330 +++++
> >  drivers/net/e1000/e1000_80003es2lan.h |   89
> >  drivers/net/e1000/e1000_82540.c       |  586 ++
> >  drivers/net/e1000/e1000_82541.c       | 1164 ++++
> >  drivers/net/e1000/e1000_82541.h       |   86
> >  drivers/net/e1000/e1000_82542.c       |  466 ++
> >  drivers/net/e1000/e1000_82543.c       | 1397 +++++
> >  drivers/net/e1000/e1000_82543.h       |   45
> >  drivers/net/e1000/e1000_82571.c       | 1132 ++++
> >  drivers/net/e1000/e1000_82571.h       |   42
> 
> Perhaps the "e1000_" prefix could be dropped as redundant?
> -- 

Yes, that suggestion would agree with what Linus told us about
usb file names 7 years ago.  (huh?  that long?)

---
~Randy
