Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264562AbUGYXgw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264562AbUGYXgw (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jul 2004 19:36:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264610AbUGYXgw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jul 2004 19:36:52 -0400
Received: from mail.kroah.org ([69.55.234.183]:16872 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S264562AbUGYXgp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jul 2004 19:36:45 -0400
Date: Sun, 25 Jul 2004 15:05:21 -0400
From: Greg KH <greg@kroah.com>
To: Chris Wedgwood <cw@f00f.org>, Jeff Garzik <jgarzik@pobox.com>,
       Ricky Beam <jfbeam@bluetronic.net>,
       "Eric D. Mudama" <edmudama@bounceswoosh.org>,
       "Robert M. Stockmann" <stock@stokkie.net>, linux-kernel@vger.kernel.org
Subject: Re: SATA disk device naming ?
Message-ID: <20040725190521.GB30535@kroah.com>
References: <20040713064645.GA1660@bounceswoosh.org> <Pine.GSO.4.33.0407131221000.25702-100000@sweetums.bluetronic.net> <20040713164911.GA947@havoc.gtf.org> <20040713223541.GB7980@taniwha.stupidest.org> <20040715024414.GG28239@ca-server1.us.oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040715024414.GG28239@ca-server1.us.oracle.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 14, 2004 at 07:44:14PM -0700, Joel Becker wrote:
> On Tue, Jul 13, 2004 at 03:35:41PM -0700, Chris Wedgwood wrote:
> > initrd is such a PITA at times, I wondered about something hacky like
> > sticking LABEL parsing for rootfs (marked init) into the kernel but
> > it's really gross.
> > 
> > Ideally the initrd/initramfs process just needs better (userspace)
> > infrastructure to make it more reliable/easier.
> 
> 	I'm waiting for udev to give me consistent device names easily.
> Then I can specify root=/dev/disk1 and not have to scan-all-100-disks
> for LABEL mounts.

What's missing from udev to let you do this today?

thanks,

greg k-h
