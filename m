Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269021AbUHMHri@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269021AbUHMHri (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Aug 2004 03:47:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269020AbUHMHrh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Aug 2004 03:47:37 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:6024 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S269021AbUHMHrg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Aug 2004 03:47:36 -0400
Date: Fri, 13 Aug 2004 09:46:54 +0200
From: Jens Axboe <axboe@suse.de>
To: Arjan van de Ven <arjanv@redhat.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Alan Cox <alan@www.pagan.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: SG_IO and security
Message-ID: <20040813074654.GA2663@suse.de>
References: <1092313030.21978.34.camel@localhost.localdomain> <Pine.LNX.4.58.0408120929360.1839@ppc970.osdl.org> <Pine.LNX.4.58.0408120943210.1839@ppc970.osdl.org> <1092341803.22458.37.camel@localhost.localdomain> <Pine.LNX.4.58.0408121705050.1839@ppc970.osdl.org> <20040813065902.GB2321@suse.de> <1092383006.2813.0.camel@laptop.fenrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1092383006.2813.0.camel@laptop.fenrus.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 13 2004, Arjan van de Ven wrote:
> 
> > While that does make sense, it would be more code to fold them together
> > than what is currently there. SCSI_IOCTL_SEND_COMMAND is really
> > horrible, the person inventing that API should be subject to daily
> > public ridicule.
> 
> sounds like deprecation of this interface should start (I suspect this

Very much so, it should have been deprecated for the last 5 years :)

> one will need ample notice of that so the sooner we do .... )

I have no idea how many apps use this ioctl, does anyone have a rough
list?

-- 
Jens Axboe

