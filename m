Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030507AbWJ3DzA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030507AbWJ3DzA (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Oct 2006 22:55:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030508AbWJ3DzA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Oct 2006 22:55:00 -0500
Received: from mail.kroah.org ([69.55.234.183]:4323 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1030507AbWJ3Dy7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Oct 2006 22:54:59 -0500
Date: Sun, 29 Oct 2006 19:54:30 -0800
From: Greg KH <greg@kroah.com>
To: Dave Jones <davej@redhat.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.19-rc3-mm1
Message-ID: <20061030035430.GA4045@kroah.com>
References: <20061029160002.29bb2ea1.akpm@osdl.org> <20061030025000.GA8896@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061030025000.GA8896@redhat.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 29, 2006 at 09:50:00PM -0500, Dave Jones wrote:
> On Sun, Oct 29, 2006 at 04:00:02PM -0800, Andrew Morton wrote:
> 
>  > - For some reason Greg has resurrected the patches which detect whether
>  >   you're using old versions of udev and if so, punish you for it.
>  > 
>  >   If weird stuff happens, try upgrading udev.
> 
> Where "old" is how old exactly ?

As per the Kconfig help entry, any version of udev released before 2006
will probably have problems with the new config option.  So follow the
text and enable the option if you are running an old version of udev and
you should be fine.

No more need to upgrade udev if you don't want to, everything should
work as-is unless you do not want it to.

I think the CHANGES file shows the version of udev that will work
properly with this change, but I need to go verify that.

thanks,

greg k-h
