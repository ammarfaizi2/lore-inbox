Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261301AbVCFFIn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261301AbVCFFIn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Mar 2005 00:08:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261322AbVCFFIm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Mar 2005 00:08:42 -0500
Received: from 64-85-47-3.ip.van.radiant.net ([64.85.47.3]:13317 "EHLO
	vlinkmail") by vger.kernel.org with ESMTP id S261301AbVCFFHg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Mar 2005 00:07:36 -0500
Date: Sat, 5 Mar 2005 21:03:25 -0800
From: Greg KH <greg@kroah.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Andrew Morton <akpm@osdl.org>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, chrisw@osdl.org
Subject: Re: Linux 2.6.11.1
Message-ID: <20050306050325.GA11889@kroah.com>
References: <20050304175302.GA29289@kroah.com> <20050304124431.676fd7cf.akpm@osdl.org> <20050304205842.GA32232@kroah.com> <20050304131537.7039ca10.akpm@osdl.org> <Pine.LNX.4.58.0503041353050.11349@ppc970.osdl.org> <20050304135933.3a325efc.akpm@osdl.org> <20050304220518.GC1201@kroah.com> <20050304143614.203278fd.akpm@osdl.org> <20050305000604.GA3355@kroah.com> <42290D58.6090908@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42290D58.6090908@pobox.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 04, 2005 at 08:37:28PM -0500, Jeff Garzik wrote:
> Greg KH wrote:
> >On Fri, Mar 04, 2005 at 02:36:14PM -0800, Andrew Morton wrote:
> >
> >>But we end up with a cset in the permanent kernel history which simply
> >>should not have been there.
> >
> >
> >Is this really a big deal?
> 
> If you are pushing linux-release to Linus/Andrew rapidly, quick fixes 
> will land in linux-2.6 rapidly, and more invasive stuff will land only 
> in linux-2.6 when the invasive stuff is ready to go.  It even takes the 
> pressure off pushing invasive stuff ASAP.
> 
> Have you pushed linux-2.6.11.1 upstream yet?  :)

Having Linus pull from the 2.6.x.y bk tree, will not work out.  We
probably don't want the .1, .2, and so on tags in the tree, as well as
not all fixes in there will be proper for his tree (like the 2 currently
in 2.6.11.1.)  The "real" fix will go into his tree through the proper
ways.

But I/we will be sure to pick out the stuff that should go there and
send them to him.

thanks,

greg k-h
