Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262709AbTJGS1N (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Oct 2003 14:27:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262680AbTJGSZw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Oct 2003 14:25:52 -0400
Received: from mail.kroah.org ([65.200.24.183]:61059 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262677AbTJGSZi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Oct 2003 14:25:38 -0400
Date: Tue, 7 Oct 2003 11:10:41 -0700
From: Greg KH <greg@kroah.com>
To: Hugo Mills <hugo-lkml@carfax.org.uk>, linux-kernel@vger.kernel.org,
       Andreas Jellinghaus <aj@dungeon.inka.de>
Subject: Re: devfs vs. udev
Message-ID: <20031007181041.GI1956@kroah.com>
Reply-To: linux-kernel@vger.kernel.org
References: <yw1xad8dfcjg.fsf@users.sourceforge.net> <pan.2003.10.07.13.41.23.48967@dungeon.inka.de> <yw1xekxpdtuq.fsf@users.sourceforge.net> <20031007142349.GX1223@rdlg.net> <pan.2003.10.07.16.06.52.842471@dungeon.inka.de> <20031007165404.GB29870@carfax.org.uk> <20031007174928.GB1956@kroah.com> <20031007175817.GB1125@carfax.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031007175817.GB1125@carfax.org.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 07, 2003 at 06:58:17PM +0100, Hugo Mills wrote:
> On Tue, Oct 07, 2003 at 10:49:28AM -0700, Greg KH wrote:
> > On Tue, Oct 07, 2003 at 05:54:04PM +0100, Hugo Mills wrote:
> > > 
> > >    Surely udev needs the ability to make more than one device node or
> > > symlink when a device is plugged in anyway, so I just see this as an
> > > issue of writing the appropriate default configuration files.
> > 
> > More than one device node per device?  Why would you want that?
> 
>    OK, more than one actual node per device (i.e. per major:minor
> pair) may not necessarily be required, but in devfs there are, for
> example device nodes created in /dev/scsi/host0/bus0/device0/lun0/...
> etc, and links to those device nodes created in /dev/discs/disc0/...
> It can occasionally be useful to have the two distinct namespaces
> available.

Yes, symlinks are on the TODO list, as lots of people want them
/dev/cdrom, /dev/pilot, etc.

thanks,

greg k-h
