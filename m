Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264029AbTFBV0O (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jun 2003 17:26:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264067AbTFBV0O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jun 2003 17:26:14 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:49619 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S264029AbTFBV0N
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jun 2003 17:26:13 -0400
Date: Mon, 2 Jun 2003 14:40:13 -0700
From: Greg KH <greg@kroah.com>
To: Adrian Bunk <bunk@fs.tum.de>, linux-kernel@vger.kernel.org
Subject: Re: [2.5 patch] SECURITY_ROOTPLUG must depend on USB
Message-ID: <20030602214013.GB6801@kroah.com>
References: <20030601184436.GD29425@fs.tum.de> <20030602172016.GB4992@kroah.com> <20030602141316.A15203@figure1.int.wirex.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030602141316.A15203@figure1.int.wirex.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 02, 2003 at 02:13:16PM -0700, Chris Wright wrote:
> * Greg KH (greg@kroah.com) wrote:
> > On Sun, Jun 01, 2003 at 08:44:36PM +0200, Adrian Bunk wrote:
> > > The following patch lets SECURITY_ROOTPLUG depend on USB (otherwise
> > > there are link errors since Root Plug Support needs
> > > usb_bus_list{,_lock}):
> > 
> > Applied, thanks.
> 
> While we're at it, here's a tiny cleanup for a compile warning from John
> Cherry's build stats[1].  You may have a cleaner way you'd rather handle
> this.

Thanks, but I already sent Linus a patch to clean this up in a different
way.

greg k-h
