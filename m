Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270982AbTG1AJC (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jul 2003 20:09:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270978AbTG1AI2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jul 2003 20:08:28 -0400
Received: from pix-525-pool.redhat.com ([66.187.233.200]:12581 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id S270982AbTG0X5b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jul 2003 19:57:31 -0400
Date: Sun, 27 Jul 2003 20:12:42 -0400
From: Bill Nottingham <notting@redhat.com>
To: Arjan van de Ven <arjanv@redhat.com>
Cc: Rusty Russell <rusty@rustcorp.com.au>, Linus Torvalds <torvalds@osdl.org>,
       Stephen Hemminger <shemminger@osdl.org>,
       "David S. Miller" <davem@redhat.com>, Greg KH <greg@kroah.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Remove module reference counting.
Message-ID: <20030727201242.A29448@devserv.devel.redhat.com>
Mail-Followup-To: Arjan van de Ven <arjanv@redhat.com>,
	Rusty Russell <rusty@rustcorp.com.au>,
	Linus Torvalds <torvalds@osdl.org>,
	Stephen Hemminger <shemminger@osdl.org>,
	"David S. Miller" <davem@redhat.com>, Greg KH <greg@kroah.com>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0307261230110.1841-100000@home.osdl.org> <20030727193919.832302C450@lists.samba.org> <20030727214701.A23137@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030727214701.A23137@devserv.devel.redhat.com>; from arjanv@redhat.com on Sun, Jul 27, 2003 at 09:47:01PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven (arjanv@redhat.com) said: 
> > The kudzu one and Alan's USB firmware example bother me more: they
> > load then unload modules currently? 
> 
> I'm pretty sure kudzu doesn't

It loads/unloads things like scsi modules and firewire controller
modules, but only for hardware actually present in the system (i.e.,
you'd probably be loading it again anyway, if you haven't already
loaded it.)

Bill
