Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265037AbTFYXYo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jun 2003 19:24:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265178AbTFYXYn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jun 2003 19:24:43 -0400
Received: from relay02.roc.ny.frontiernet.net ([66.133.131.35]:16358 "EHLO
	relay02.roc.ny.frontiernet.net") by vger.kernel.org with ESMTP
	id S265037AbTFYXYS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jun 2003 19:24:18 -0400
Date: Wed, 25 Jun 2003 19:38:29 -0400
From: Scott McDermott <vaxerdec@frontiernet.net>
To: linux-kernel@vger.kernel.org
Subject: Re: ide-scsi on 2.4.21 (on IBM Thinkpad T30)
Message-ID: <20030625193829.M9583@newbox.localdomain>
References: <3EF753EC.9080807@homemail.com> <3EFA2B83.3090305@homemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3EFA2B83.3090305@homemail.com>; from dsen@homemail.com on Thu, Jun 26, 2003 at 09:08:51AM +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

D. Sen on Thu 26/06 09:08 +1000:
> > > Kernel 2.4.21 causes hangs and/or ooops during boot up
> > > if I have a "probeall scsi_hostadapter ide-scsi" in my
> > > /etc/modules.conf. If I take out that line and
> > > manually load the module after the laptop has booted,
> > > everything is fine.
> > 
> > I probably have the same CD-RW that you do (in the T30)
> > and I just use hdc=ide-scsi on kernel command line, no
> > need for manually loading. Works fine but don't try
> > burning with magicdev running :)
> 
> Do you have ide-scsi built as a module though?

Yes.  It works fine, I just tried with cdrdao using
generic-mmc driver.  I have nothing at all in modules.conf
related to cd, ide, or scsi.
