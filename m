Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262845AbTEMESw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 00:18:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262850AbTEMESw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 00:18:52 -0400
Received: from granite.he.net ([216.218.226.66]:45838 "EHLO granite.he.net")
	by vger.kernel.org with ESMTP id S262845AbTEMESv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 00:18:51 -0400
Date: Mon, 12 May 2003 21:33:09 -0700
From: Greg KH <greg@kroah.com>
To: Dave Airlie <airlied@linux.ie>
Cc: linux-kernel@vger.kernel.org
Subject: Re: re-scanning the PCI bus after boot for configurable device...
Message-ID: <20030513043309.GA6118@kroah.com>
References: <Pine.LNX.4.53.0305130225240.20908@skynet> <20030513034147.GA5938@kroah.com> <Pine.LNX.4.53.0305130507090.25655@skynet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.53.0305130507090.25655@skynet>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 13, 2003 at 05:08:49AM +0100, Dave Airlie wrote:
> >
> > I've posted a driver to the linux-hotplug-devel mailing list a year or
> > so ago that might help you out with this.  On module load it rescans the
> > PCI address space, adding or removind devices that are new or now gone.
> > This will probably do what you want.
> 
> I persume it's this one
> http://marc.theaimsgroup.com/?l=linux-hotplug-devel&m=101312609603679

That's the one.

If you get it working on 2.5, I'd be interested in adding it to the main
kernel tree, as people ask for this kind of stuff every once in a while.

Good luck,

greg k-h
