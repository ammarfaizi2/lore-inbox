Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261769AbVFFXdy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261769AbVFFXdy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Jun 2005 19:33:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261735AbVFFXT1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Jun 2005 19:19:27 -0400
Received: from lyle.provo.novell.com ([137.65.81.174]:59734 "EHLO
	lyle.provo.novell.com") by vger.kernel.org with ESMTP
	id S261738AbVFFXBd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Jun 2005 19:01:33 -0400
Date: Mon, 6 Jun 2005 16:01:18 -0700
From: Greg KH <gregkh@suse.de>
To: Dave Jones <davej@redhat.com>, Grant Grundler <grundler@parisc-linux.org>,
       tom.l.nguyen@intel.com, linux-pci@atrey.karlin.mff.cuni.cz,
       linux-kernel@vger.kernel.org, roland@topspin.com, davem@davemloft.net
Subject: Re: pci_enable_msi() for everyone?
Message-ID: <20050606230118.GD11184@suse.de>
References: <20050603224551.GA10014@kroah.com> <20050604013112.GB16999@colo.lackof.org> <20050604064821.GC13238@suse.de> <20050604070537.GB8230@colo.lackof.org> <20050604071803.GA13684@suse.de> <20050604072348.GA28293@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050604072348.GA28293@redhat.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 04, 2005 at 03:23:48AM -0400, Dave Jones wrote:
> What if MSI support has been disabled in the bridge due to some quirk
> (like the recent AMD 8111 quirk) ?   Maybe the above function
> should check pci_msi_enable as well ?

Yes, you are correct.  I said it wasn't tested :)

thanks,

greg k-h
