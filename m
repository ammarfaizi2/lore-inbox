Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262439AbVAZRK3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262439AbVAZRK3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jan 2005 12:10:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262423AbVAZQw4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jan 2005 11:52:56 -0500
Received: from mail.kroah.org ([69.55.234.183]:8425 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262390AbVAZQsZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jan 2005 11:48:25 -0500
Date: Wed, 26 Jan 2005 08:48:01 -0800
From: Greg KH <greg@kroah.com>
To: "Mukker, Atul" <Atulm@lsil.com>
Cc: "'Patrick Mansfield'" <patmans@us.ibm.com>,
       "Mukker, Atul" <Atulm@lsil.com>,
       "'James Bottomley'" <James.Bottomley@steeleye.com>,
       "'Linux Kernel'" <linux-kernel@vger.kernel.org>,
       "'SCSI Mailing List'" <linux-scsi@vger.kernel.org>
Subject: RE: How to add/drop SCSI drives from within the driver?
Message-ID: <20050126164800.GB3438@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Thanks for the suggestion. After more exploration, looks like different
> distribution have different implementations for /sbin/hotplug. This may
> aggravate the issue for applications. For now, we will stick with a wait and
> watch after bus scan :-(

What do you mean?  Just use the /etc/dev.d notification stuff that all
distros that use udev have.

And what do you mean "different implementations for /sbin/hotplug"?
What distros do not use the standard "linux-hotplug" type scripts, or if
not the scripts, the same functionality?

thanks,

greg k-h
