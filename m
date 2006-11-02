Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752708AbWKBHWj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752708AbWKBHWj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Nov 2006 02:22:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752707AbWKBHWj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Nov 2006 02:22:39 -0500
Received: from mail.kroah.org ([69.55.234.183]:32733 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1752705AbWKBHWi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Nov 2006 02:22:38 -0500
Date: Wed, 1 Nov 2006 23:15:07 -0800
From: Greg KH <greg@kroah.com>
To: David Brownell <david-b@pacbell.net>
Cc: Randy Dunlap <randy.dunlap@oracle.com>, toralf.foerster@gmx.de,
       netdev@vger.kernel.org, linux-usb-devel@lists.sourceforge.net,
       link@miggy.org, akpm@osdl.org, zippel@linux-m68k.org, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] usbnet: use MII hooks only if CONFIG_MII is enabled
Message-ID: <20061102071507.GB28382@kroah.com>
References: <Pine.LNX.4.64.0610231618510.3962@g5.osdl.org> <20061025222709.A13681C5E0B@adsl-69-226-248-13.dsl.pltn13.pacbell.net> <20061025165858.b76b4fd8.randy.dunlap@oracle.com> <200610251922.09692.david-b@pacbell.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200610251922.09692.david-b@pacbell.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 25, 2006 at 07:22:08PM -0700, David Brownell wrote:
> On Wednesday 25 October 2006 4:58 pm, Randy Dunlap wrote:
> > On Wed, 25 Oct 2006 15:27:09 -0700 David Brownell wrote:
> > 
> > > Instead, "usbnet.c" should #ifdef the relevant ethtool hooks
> > > according to CONFIG_MII ... since it's completely legit to
> > > use usbnet with peripherals that don't need MII.
> 
> I had in mind something simpler -- #ifdeffing the entire functions,
> as in this patch.  It looks more complicated than it is, because
> "diff" gets confused by moving two functions earlier in the file.
> 
> (Thanks for starting this, Randy ... these two patches should be merged
> before RC4 ships.)

Argh, there were just too many different versions of these patches
floating around.  Can you resend the final versions please?

thanks,

greg k-h
