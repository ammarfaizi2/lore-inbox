Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268762AbUIXOHN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268762AbUIXOHN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Sep 2004 10:07:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268764AbUIXOHM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Sep 2004 10:07:12 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:12007 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S268762AbUIXOHE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Sep 2004 10:07:04 -0400
Subject: Re: PATCH: tty ldisc work version 4
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Paul Fulghum <paulkf@microgate.com>
Cc: Alan Cox <alan@redhat.com>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1096033380.4995.6.camel@deimos.microgate.com>
References: <20040922141821.GA27672@devserv.devel.redhat.com>
	 <20040922172139.0d7a1dd3.akpm@osdl.org>
	 <20040923054842.GB30650@devserv.devel.redhat.com>
	 <1096033380.4995.6.camel@deimos.microgate.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1096031067.9730.21.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Fri, 24 Sep 2004 14:04:31 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2004-09-24 at 14:43, Paul Fulghum wrote:
> Did this turn out to be related to the code
> in release_dev() that switches back a tty struct
> back to N_TTY ldisc before freeing the tty struct?

No it was just a stupid mistake in my code. I'll propogate the
other changes back in now I've found it.

