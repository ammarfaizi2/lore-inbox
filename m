Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263969AbTDNWHz (for <rfc822;willy@w.ods.org>); Mon, 14 Apr 2003 18:07:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263974AbTDNWHz (for <rfc822;linux-kernel-outgoing>);
	Mon, 14 Apr 2003 18:07:55 -0400
Received: from Mail1.KONTENT.De ([81.88.34.36]:20911 "EHLO Mail1.KONTENT.De")
	by vger.kernel.org with ESMTP id S263969AbTDNWHn (for <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Apr 2003 18:07:43 -0400
From: Oliver Neukum <oliver@neukum.org>
Reply-To: oliver@neukum.name
To: Greg KH <greg@kroah.com>
Subject: Re: [RFC] /sbin/hotplug multiplexor
Date: Tue, 15 Apr 2003 00:19:26 +0200
User-Agent: KMail/1.5
Cc: linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
References: <20030414190032.GA4459@kroah.com> <200304142343.17802.oliver@neukum.org> <20030414215221.GA5989@kroah.com>
In-Reply-To: <20030414215221.GA5989@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200304150019.26809.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Montag, 14. April 2003 23:52 schrieb Greg KH:
> On Mon, Apr 14, 2003 at 11:43:17PM +0200, Oliver Neukum wrote:
> > > > Well, for a little elegance you might introduce subdirectories for
> > > > each type of hotplug event and use only them.
> > >
> > > No, that's for the individual scripts/programs to decide.  For example,
> > > that's what the current hotplug scripts do, but that's not at all what
> > > the udev program wants to do.
> >
> > So have them put a symlink into each subdirectory. This is the way it's
> > done for init since times immemorial.
>
> But the number of different "types" keeps growing.  For some programs
> (like udev) they really don't care about the type, and if you add a new
> type, it still works just fine.  Other programs do care about the type,
> so they can look at it and make a judgement based on it.

How can that be? What kind of thing should care about both
device addition and routing changes in the same way?

Not needlessly exposing scripts to event types they are not written
to handle is an advantage.

	Regards
		Oliver

