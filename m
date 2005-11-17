Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932434AbVKQRDL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932434AbVKQRDL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Nov 2005 12:03:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932429AbVKQRDK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Nov 2005 12:03:10 -0500
Received: from digitalimplant.org ([64.62.235.95]:51623 "HELO
	digitalimplant.org") by vger.kernel.org with SMTP id S932434AbVKQRDJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Nov 2005 12:03:09 -0500
Date: Thu, 17 Nov 2005 09:03:05 -0800 (PST)
From: Patrick Mochel <mochel@digitalimplant.org>
X-X-Sender: mochel@monsoon.he.net
To: Greg KH <greg@kroah.com>
cc: Olivier Galibert <galibert@pobox.com>,
       kernel list <linux-kernel@vger.kernel.org>,
       Linux-pm mailing list <linux-pm@lists.osdl.org>
Subject: Re: [linux-pm] [RFC] userland swsusp
In-Reply-To: <20051117164451.GA27178@kroah.com>
Message-ID: <Pine.LNX.4.50.0511170901250.6343-100000@monsoon.he.net>
References: <F760B14C9561B941B89469F59BA3A8470BDD12EB@orsmsx401.amr.corp.intel.com>
 <20051116191051.GG2193@spitz.ucw.cz> <20051117165437.GA10402@dspnet.fr.eu.org>
 <20051117164451.GA27178@kroah.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 17 Nov 2005, Greg KH wrote:

> On Thu, Nov 17, 2005 at 05:54:37PM +0100, Olivier Galibert wrote:
> > On Wed, Nov 16, 2005 at 07:10:52PM +0000, Pavel Machek wrote:
> > > What unstable implementation? swsusp had very little regressions over past
> > > year or so. Drivers were different story, but nothing changes w.r.t. drivers.
> >
> > Do you mean swsusp is actually supposed to work?  Suspend-to-ram,
> > suspend-to-disk or both?
>
> Both.  -to-ram depends on your video chip, but to-disk should work just
> fine.  If not, please report bugs.

swsusp has nothing to do with suspend-to-ram. swsusp is a
platform-independent implementation of suspend-to-disk. STR is
very-platform dependent. Please see the file:

	Documentation/power/states.txt

for more info.


	Pat

