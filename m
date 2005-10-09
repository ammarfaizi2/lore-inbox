Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932235AbVJIIJf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932235AbVJIIJf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Oct 2005 04:09:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932239AbVJIIJe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Oct 2005 04:09:34 -0400
Received: from mx1.redhat.com ([66.187.233.31]:29892 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932235AbVJIIJe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Oct 2005 04:09:34 -0400
Date: Sun, 9 Oct 2005 01:09:09 -0700
From: Pete Zaitcev <zaitcev@redhat.com>
To: Matthew Dharm <mdharm-kernel@one-eyed-alien.net>
Cc: greg@kroah.com, usb-storage@lists.one-eyed-alien.net,
       linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net,
       zaitcev@redhat.com
Subject: Re: [usb-storage] usb: drivers/usb/storage/libusual
Message-Id: <20051009010909.4b93f9c2.zaitcev@redhat.com>
In-Reply-To: <20051009021413.GA25979@one-eyed-alien.net>
References: <20050927205559.078ba9ed.zaitcev@redhat.com>
	<20050928085159.GA11862@kroah.com>
	<20051008140132.49f9eec3.zaitcev@redhat.com>
	<20051009021413.GA25979@one-eyed-alien.net>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed version 2.0.0 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 8 Oct 2005 19:14:13 -0700, Matthew Dharm <mdharm-kernel@one-eyed-alien.net> wrote:

> But, I'm not sure this is much better.  It's certainly different, but I
> fear that we're going to spend a lot of time explaining to end-users a new
> and less-than-totally-obvious system.

Devices continue to default to usb-storage, regardless if libusual is
configured. So, no explanations should be necessary at first. Fedora may
be different if we like how it works in Rawhide and let it into a release.
Then I would talk to Karsten about documenting this in Fedora handbook.

Although... I may be missing something about the behaviour of end users.
I thought that what we had before was transparent, but I was wrong.

I have some hopes for Gentoo users to tell me if libusual is workable
actually. They like to try new options as soon as they appear :-)

> And I think I'm totally convinced now that request_module() needs some
> serious help. []

I think maybe if this use of it gets visible, it may be easier to
implement changes to request_module(), than if I were just mailing
to linux-kernel. Patch always speaks louder than words.

Maybe Keith or Rusty will have a look and bust this to bits, from
the module-init-tools perspective.

-- Pete
