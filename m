Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266555AbUG0SoX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266555AbUG0SoX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jul 2004 14:44:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266552AbUG0SmO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jul 2004 14:42:14 -0400
Received: from [66.35.79.110] ([66.35.79.110]:38583 "EHLO www.hockin.org")
	by vger.kernel.org with ESMTP id S266554AbUG0Sh2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jul 2004 14:37:28 -0400
Date: Tue, 27 Jul 2004 11:37:05 -0700
From: Tim Hockin <thockin@hockin.org>
To: Mike Waychison <Michael.Waychison@Sun.COM>
Cc: Greg KH <greg@kroah.com>, Oliver Neukum <oliver@neukum.org>,
       Robert Love <rml@ximian.com>,
       "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>,
       Andrew Morton <akpm@osdl.org>, cw@f00f.org,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] kernel events layer
Message-ID: <20040727183705.GA9242@hockin.org>
References: <F989B1573A3A644BAB3920FBECA4D25A6EBFB5@orsmsx407> <1090853403.1973.11.camel@localhost> <20040726161221.GC17449@kroah.com> <200407262013.33454.oliver@neukum.org> <20040726190305.GA19498@kroah.com> <20040726204457.GA10970@hockin.org> <41069BB8.1030405@sun.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41069BB8.1030405@sun.com>
User-Agent: Mutt/1.4.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 27, 2004 at 02:15:20PM -0400, Mike Waychison wrote:
> > What about flipping it around and using either hotplug or a hotplug-like
> > mechanism for these events?

> The problem with this is that you'd lose the ability to send the
> messages broadcast, whereby you may have multiple dbus's listening for
> events.

Broadcast it in user space.
