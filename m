Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270985AbTGVSPn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jul 2003 14:15:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270982AbTGVSPn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jul 2003 14:15:43 -0400
Received: from www.opensource-ca.org ([168.234.203.30]:42710 "EHLO
	guug.galileo.edu") by vger.kernel.org with ESMTP id S270977AbTGVSPl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jul 2003 14:15:41 -0400
Date: Tue, 22 Jul 2003 12:26:09 -0600
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org,
       debian-sparc@lists.debian.org
Subject: Re: sparc scsi esp depends on pci & hangs on boot
Message-ID: <20030722182609.GA30174@guug.org>
References: <20030722025142.GC25561@guug.org> <20030722080905.A21280@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030722080905.A21280@devserv.devel.redhat.com>
User-Agent: Mutt/1.5.4i
From: Otto Solares <solca@guug.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 22, 2003 at 08:09:05AM -0400, Pete Zaitcev wrote:
> > Date: 	Mon, 21 Jul 2003 20:51:42 -0600
> > From: Otto Solares <solca@guug.org>
> 
> > ultra enterprise 1 (sun4u sparc64)
> > sparc station 4    (sun4m sparc32)
> > 
> > on both i need to enable PCI support even
> > when these boxes doesn't have a PCI bus,
> 
> I'll look into sparc32 problems when I get from Canada.

good.

converting the esp scsi driver to sbus without
pci requirement is the right step IMO.  Maybe
the scsi people can comment on this.

-solca

