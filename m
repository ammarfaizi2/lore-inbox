Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265697AbUGZRsS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265697AbUGZRsS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jul 2004 13:48:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265288AbUGZRsS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jul 2004 13:48:18 -0400
Received: from mail.kroah.org ([69.55.234.183]:37795 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S266021AbUGZQOO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jul 2004 12:14:14 -0400
Date: Mon, 26 Jul 2004 12:12:21 -0400
From: Greg KH <greg@kroah.com>
To: Robert Love <rml@ximian.com>
Cc: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>,
       Andrew Morton <akpm@osdl.org>, cw@f00f.org,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] kernel events layer
Message-ID: <20040726161221.GC17449@kroah.com>
References: <F989B1573A3A644BAB3920FBECA4D25A6EBFB5@orsmsx407> <1090853403.1973.11.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1090853403.1973.11.camel@localhost>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 26, 2004 at 10:50:03AM -0400, Robert Love wrote:
> On Mon, 2004-07-26 at 00:31 -0700, Perez-Gonzalez, Inaky wrote:
> 
> > methinks: if the message is related to some object that has a kobject
> > representation, use it. If not, come up with one on a case by case
> > basis [now this is the difficult one--is where it'd be difficult to
> > keep things on leash].
> 
> That introduces two orthogonal name spaces, and that really doesn't cut
> it.
> 
> If Greg can come up with a solution for using kobjects, I am all for
> that - that would be great - but I really do not see kobject paths
> working out.  I think the best we have is the file path in the tree.

Give me a few days, I'm working on it, but have been traveling too much.
Robert and I will sit down during OSCON this week and try to work out
something along these lines, and then post it again here.

thanks,

greg k-h
