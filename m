Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266549AbUG0Sfd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266549AbUG0Sfd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jul 2004 14:35:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266545AbUG0Sfd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jul 2004 14:35:33 -0400
Received: from mail1.kontent.de ([81.88.34.36]:17084 "EHLO Mail1.KONTENT.De")
	by vger.kernel.org with ESMTP id S266549AbUG0SfL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jul 2004 14:35:11 -0400
From: Oliver Neukum <oliver@neukum.org>
To: Mike Waychison <Michael.Waychison@Sun.COM>
Subject: Re: [patch] kernel events layer
Date: Tue, 27 Jul 2004 20:35:04 +0200
User-Agent: KMail/1.6.2
Cc: Tim Hockin <thockin@hockin.org>, Greg KH <greg@kroah.com>,
       Robert Love <rml@ximian.com>,
       "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>,
       Andrew Morton <akpm@osdl.org>, cw@f00f.org,
       linux-kernel@vger.kernel.org
References: <F989B1573A3A644BAB3920FBECA4D25A6EBFB5@orsmsx407> <20040726204457.GA10970@hockin.org> <41069BB8.1030405@sun.com>
In-Reply-To: <41069BB8.1030405@sun.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <200407272035.04832.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Dienstag, 27. Juli 2004 20:15 schrieb Mike Waychison:
> Tim Hockin wrote:
> > On Mon, Jul 26, 2004 at 03:03:05PM -0400, Greg KH wrote:
> >
> >>>On a related note, is this supposed to supersede the current hotplug
> >>>mechanism?
> >>
> >>No, it will not.  At the most, it will report the same information to
> >>make it easier for userspace programs who want to get the other
> >>event information, also get the hotplug stuff through the same
> >>interface, reducing their complexity.
> >>
> >>So the existing hotplug interface is not going away at all.  Do not even
> >>begin to think that :)
> >
> >
> > What about flipping it around and using either hotplug or a hotplug-like
> > mechanism for these events?
> >
> > It solves the issue of events being dropped when there is no listening
> > daemon...
> >
> > These are not going to be high-traffic messages, right, so the overhead is
> > negligible...
> >
> 
> The problem with this is that you'd lose the ability to send the
> messages broadcast, whereby you may have multiple dbus's listening for
> events.

Why is that? Couldn't a hotplug script use dbus?

	Regards
		Oliver
