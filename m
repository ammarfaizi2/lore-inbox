Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932412AbVKQRA1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932412AbVKQRA1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Nov 2005 12:00:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932419AbVKQRA0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Nov 2005 12:00:26 -0500
Received: from mail.kroah.org ([69.55.234.183]:25992 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S932412AbVKQRA0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Nov 2005 12:00:26 -0500
Date: Thu, 17 Nov 2005 08:44:51 -0800
From: Greg KH <greg@kroah.com>
To: Olivier Galibert <galibert@pobox.com>,
       kernel list <linux-kernel@vger.kernel.org>,
       Linux-pm mailing list <linux-pm@lists.osdl.org>
Subject: Re: [linux-pm] [RFC] userland swsusp
Message-ID: <20051117164451.GA27178@kroah.com>
References: <F760B14C9561B941B89469F59BA3A8470BDD12EB@orsmsx401.amr.corp.intel.com> <20051116191051.GG2193@spitz.ucw.cz> <20051117165437.GA10402@dspnet.fr.eu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051117165437.GA10402@dspnet.fr.eu.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 17, 2005 at 05:54:37PM +0100, Olivier Galibert wrote:
> On Wed, Nov 16, 2005 at 07:10:52PM +0000, Pavel Machek wrote:
> > What unstable implementation? swsusp had very little regressions over past
> > year or so. Drivers were different story, but nothing changes w.r.t. drivers.
> 
> Do you mean swsusp is actually supposed to work?  Suspend-to-ram,
> suspend-to-disk or both?

Both.  -to-ram depends on your video chip, but to-disk should work just
fine.  If not, please report bugs.

thanks,

greg k-h
