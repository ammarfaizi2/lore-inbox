Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262833AbTHUTEA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Aug 2003 15:04:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262850AbTHUTEA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Aug 2003 15:04:00 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:16350 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262833AbTHUTEA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Aug 2003 15:04:00 -0400
Date: Thu, 21 Aug 2003 20:03:58 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: "Bryan O'Sullivan" <bos@serpentine.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, gkajmowi@tbaytel.net,
       linux-kernel@vger.kernel.org
Subject: Re: Initramfs
Message-ID: <20030821190358.GF454@parcelfarce.linux.theplanet.co.uk>
References: <200308210044.17876.gkajmowi@tbaytel.net> <1061447419.19503.20.camel@camp4.serpentine.com> <3F44D504.7060909@pobox.com> <1061490490.23060.9.camel@serpentine.internal.keyresearch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1061490490.23060.9.camel@serpentine.internal.keyresearch.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 21, 2003 at 11:28:10AM -0700, Bryan O'Sullivan wrote:
> On Thu, 2003-08-21 at 07:19, Jeff Garzik wrote:
> 
> > Support replacing "initrd=" with "initramfs=", so that bootloaders can 
> > pass a cpio image into the standard initrd memory space.
> 
> That would be nice to have, but it would also increase the pressure to
> fix the cpio unpacker.  At least right now, its deficiencies don't cause
> many problems, because initramfs is less than convenient to use.

RTFM.  cpio -o -H newc should be used to create an archive; _not_ the
"binary" format that is default.
