Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265955AbUGZUZf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265955AbUGZUZf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jul 2004 16:25:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266034AbUGZUZV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jul 2004 16:25:21 -0400
Received: from mail.kroah.org ([69.55.234.183]:31887 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S265955AbUGZTfT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jul 2004 15:35:19 -0400
Date: Mon, 26 Jul 2004 15:03:05 -0400
From: Greg KH <greg@kroah.com>
To: Oliver Neukum <oliver@neukum.org>
Cc: Robert Love <rml@ximian.com>,
       "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>,
       Andrew Morton <akpm@osdl.org>, cw@f00f.org,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] kernel events layer
Message-ID: <20040726190305.GA19498@kroah.com>
References: <F989B1573A3A644BAB3920FBECA4D25A6EBFB5@orsmsx407> <1090853403.1973.11.camel@localhost> <20040726161221.GC17449@kroah.com> <200407262013.33454.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200407262013.33454.oliver@neukum.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 26, 2004 at 08:13:33PM +0200, Oliver Neukum wrote:
> Am Montag, 26. Juli 2004 18:12 schrieb Greg KH:
> > > If Greg can come up with a solution for using kobjects, I am all for
> > > that - that would be great - but I really do not see kobject paths
> > > working out. ?I think the best we have is the file path in the tree.
> > 
> > Give me a few days, I'm working on it, but have been traveling too much.
> > Robert and I will sit down during OSCON this week and try to work out
> > something along these lines, and then post it again here.
> 
> On a related note, is this supposed to supersede the current hotplug
> mechanism?

No, it will not.  At the most, it will report the same information to
make it easier for userspace programs who want to get the other
event information, also get the hotplug stuff through the same
interface, reducing their complexity.

So the existing hotplug interface is not going away at all.  Do not even
begin to think that :)

thanks,

greg k-h
