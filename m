Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269631AbUJAAOd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269631AbUJAAOd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Sep 2004 20:14:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269630AbUJAAOd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Sep 2004 20:14:33 -0400
Received: from mail.kroah.org ([69.55.234.183]:7874 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S269631AbUJAAOa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Sep 2004 20:14:30 -0400
Date: Thu, 30 Sep 2004 17:14:17 -0700
From: Greg KH <greg@kroah.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: CaT <cat@zip.com.au>, Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       "Li, Shaohua" <shaohua.li@intel.com>
Subject: Re: promise controller resource alloc problems with ~2.6.8
Message-ID: <20041001001416.GA9555@kroah.com>
References: <20040927084550.GA1134@zip.com.au> <Pine.LNX.4.58.0409301615110.2403@ppc970.osdl.org> <20040930233048.GC7162@zip.com.au> <Pine.LNX.4.58.0409301646040.2403@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0409301646040.2403@ppc970.osdl.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 30, 2004 at 04:56:21PM -0700, Linus Torvalds wrote:
> 
> Greg, we kind of left the ACPI resource management breakage pending, and 
> clearly we need some resolution. Comments?

I added that patch to my bk trees, and it's sitting in the -mm tree now.
I wanted some testing, which I guess has happened, and no one has
complained yet, so if this proves to be another case where this patch
fixes things, I have no problem with it being applied.

But let's see the result of testing on this box first :)

thanks,

greg k-h
