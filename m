Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271122AbTGWGc4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jul 2003 02:32:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271115AbTGWGc4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jul 2003 02:32:56 -0400
Received: from guug.org ([168.234.203.30]:52695 "EHLO guug.galileo.edu")
	by vger.kernel.org with ESMTP id S271111AbTGWGcz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jul 2003 02:32:55 -0400
Date: Wed, 23 Jul 2003 00:43:11 -0600
To: "David S. Miller" <davem@redhat.com>
Cc: Christoph Hellwig <hch@infradead.org>, zaitcev@redhat.com,
       linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org,
       debian-sparc@lists.debian.org
Subject: Re: sparc scsi esp depends on pci & hangs on boot
Message-ID: <20030723064311.GE30174@guug.org>
References: <20030722025142.GC25561@guug.org> <20030722080905.A21280@devserv.devel.redhat.com> <20030722182609.GA30174@guug.org> <20030722175400.4fe2aa5d.davem@redhat.com> <20030723070739.A697@infradead.org> <20030722232410.7a37ed4d.davem@redhat.com> <20030723072836.A932@infradead.org> <20030722232911.2e6fda86.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030722232911.2e6fda86.davem@redhat.com>
User-Agent: Mutt/1.5.4i
From: Otto Solares <solca@guug.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 22, 2003 at 11:29:11PM -0700, David S. Miller wrote:
> On Wed, 23 Jul 2003 07:28:36 +0100
> Christoph Hellwig <hch@infradead.org> wrote:
> 
> > Putting it into linux/dma-mapping.h is fine with me, but I expect to
> > see more users of the dma-mapping API soon..
> 
> And unlike this particular scsi layer usage, such drivers will be
> dependant upon things like CONFIG_PCI and thus won't get compiled
> in unless CONFIG_PCI has been enabled in the kernel configuration.

I originally though the whole idea was to remove the PCI dependency.

-solca

