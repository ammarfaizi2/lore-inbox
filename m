Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317054AbSHSCCV>; Sun, 18 Aug 2002 22:02:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317341AbSHSCCV>; Sun, 18 Aug 2002 22:02:21 -0400
Received: from 12-231-243-94.client.attbi.com ([12.231.243.94]:15886 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S317054AbSHSCCV>;
	Sun, 18 Aug 2002 22:02:21 -0400
Date: Sun, 18 Aug 2002 19:01:25 -0700
From: Greg KH <greg@kroah.com>
To: Olivier Galibert <galibert@pobox.com>, linux-kernel@vger.kernel.org
Subject: Re: devfs
Message-ID: <20020819020125.GA20296@kroah.com>
References: <1029709596.3331.32.camel@psuedomode> <Pine.GSO.4.21.0208181852450.3920-100000@weyl.math.psu.edu> <20020818210618.A1806@zalem.puupuu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020818210618.A1806@zalem.puupuu.org>
User-Agent: Mutt/1.4i
X-Operating-System: Linux 2.2.21 (i586)
Reply-By: Mon, 22 Jul 2002 00:51:56 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 18, 2002 at 09:06:18PM -0400, Olivier Galibert wrote:
> 
> I've been wondering, imagine that in the future we have a working
> dynamic device filesystem (be it devfs, driverfs, whatever) nice
> enough that we don't want a disk-based /dev anymore.  How are we
> supposed to mount it so that the kernel's open("/dev/console")
> succeeds?

initramfs might already contain a minimial /dev that has those kinds of
entries in it.

thanks,

greg k-h
