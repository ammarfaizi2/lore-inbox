Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272911AbTG3Orl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jul 2003 10:47:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272913AbTG3Ork
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jul 2003 10:47:40 -0400
Received: from crosslink-village-512-1.bc.nu ([81.2.110.254]:64756 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S272911AbTG3Ori
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jul 2003 10:47:38 -0400
Subject: Re: [PATCH] Remove module reference counting.
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: notting@redhat.com, arjanv@redhat.com, torvalds@osdl.org,
       shemminger@osdl.org, davem@redhat.com, greg@kroah.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030730063310.70b5c794.rusty@rustcorp.com.au>
References: <Pine.LNX.4.44.0307261230110.1841-100000@home.osdl.org>
	 <20030727193919.832302C450@lists.samba.org>
	 <20030727214701.A23137@devserv.devel.redhat.com>
	 <20030727201242.A29448@devserv.devel.redhat.com>
	 <1059392321.15458.23.camel@dhcp22.swansea.linux.org.uk>
	 <20030730063310.70b5c794.rusty@rustcorp.com.au>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1059576018.8052.44.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 30 Jul 2003 15:40:18 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2003-07-29 at 21:33, Rusty Russell wrote:
> > I guess kudzu could simply do lots of I/O ops directly on the floppy 
> > hardware to detect it without loading drivers but thats pretty fugly.
> 
> Agreed that'd be kinda silly.  But I was "educated" earlier that driver
> loading shouldn't fail just because hardware is missing, due to hotplug.
> 
> Is this wrong?

On systems without hotplug, on not hotpluggable devices and in a few other
cases - yes.

