Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262544AbTJGRsP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Oct 2003 13:48:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262546AbTJGRsP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Oct 2003 13:48:15 -0400
Received: from mail.kroah.org ([65.200.24.183]:31209 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262544AbTJGRsO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Oct 2003 13:48:14 -0400
Date: Tue, 7 Oct 2003 10:47:58 -0700
From: Greg KH <greg@kroah.com>
To: =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mru@users.sourceforge.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: devfs vs. udev
Message-ID: <20031007174758.GA1956@kroah.com>
Reply-To: linux-kernel@vger.kernel.org
References: <yw1xad8dfcjg.fsf@users.sourceforge.net> <pan.2003.10.07.13.41.23.48967@dungeon.inka.de> <yw1xekxpdtuq.fsf@users.sourceforge.net> <20031007142349.GX1223@rdlg.net> <pan.2003.10.07.16.06.52.842471@dungeon.inka.de> <20031007165404.GB29870@carfax.org.uk> <yw1xk77hx8xj.fsf@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <yw1xk77hx8xj.fsf@users.sourceforge.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 07, 2003 at 07:19:04PM +0200, Måns Rullgård wrote:
> Hugo Mills <hugo-lkml@carfax.org.uk> writes:
> 
> >    Surely udev needs the ability to make more than one device node or
> > symlink when a device is plugged in anyway, so I just see this as an
> > issue of writing the appropriate default configuration files.
> 
> Now you say "plug in".  How does udev deal with devices that don't
> correspond something that can be plugged, physically or virtually
> (PCI)?  I'm thinking of things like ttys, loopback devices, etc.

Look at sysfs.  If it's in sysfs (like ttys and block devices) udev will
handle it.

thanks,

greg k-h
