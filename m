Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263640AbUHBVGT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263640AbUHBVGT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Aug 2004 17:06:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263664AbUHBVGS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Aug 2004 17:06:18 -0400
Received: from omx2-ext.SGI.COM ([192.48.171.19]:49877 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S263640AbUHBVGH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Aug 2004 17:06:07 -0400
From: Jesse Barnes <jbarnes@engr.sgi.com>
To: linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: [PATCH] add PCI ROMs to sysfs
Date: Mon, 2 Aug 2004 14:05:15 -0700
User-Agent: KMail/1.6.2
Cc: Jon Smirl <jonsmirl@yahoo.com>, Greg KH <greg@kroah.com>,
       linux-kernel@vger.kernel.org
References: <20040802210048.5071.qmail@web14928.mail.yahoo.com>
In-Reply-To: <20040802210048.5071.qmail@web14928.mail.yahoo.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200408021405.15640.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, August 2, 2004 2:00 pm, Jon Smirl wrote:
> --- Jesse Barnes <jbarnes@engr.sgi.com> wrote:
> > It it suitable for the mainline yet?  I expect those familiar with
> > the various cards to add the necessary quirks code as needed.
>
> Is tracking the boot video device and redirecting to C000:0 going to be
> a quirk, architecture specific, or what? Where does this little piece
> of code need to go?

I think that would be a quirk.  You'd copy ROMs like that into the rom pointer 
in the pci_dev structure I guess.

Jesse
