Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932335AbVKODfN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932335AbVKODfN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Nov 2005 22:35:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932345AbVKODfM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Nov 2005 22:35:12 -0500
Received: from mx1.redhat.com ([66.187.233.31]:8150 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932335AbVKODfK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Nov 2005 22:35:10 -0500
Date: Mon, 14 Nov 2005 22:35:02 -0500
From: Dave Jones <davej@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, info@colognechip.com,
       Greg KH <greg@kroah.com>
Subject: Re: [PATCH] i4l: update hfc_usb driver
Message-ID: <20051115033502.GB5620@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	info@colognechip.com, Greg KH <greg@kroah.com>
References: <200511071721.jA7HLC18028788@hera.kernel.org> <20051115004518.GA26922@redhat.com> <20051114193025.7ca34fac.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051114193025.7ca34fac.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 14, 2005 at 07:30:25PM -0800, Andrew Morton wrote:
 > Dave Jones <davej@redhat.com> wrote:
 > >
 > > On Mon, Nov 07, 2005 at 09:21:12AM -0800, Linux Kernel wrote:
 > >  > tree 0bb0aeb735a917561cf4d91d4c3fa1ed5434bede
 > >  > parent 6978bbc097c2f665c336927a9d56ae39ef75fa56
 > >  > author Martin Bachem <info@colognechip.com> Mon, 07 Nov 2005 17:00:20 -0800
 > >  > committer Linus Torvalds <torvalds@g5.osdl.org> Mon, 07 Nov 2005 23:53:47 -0800
 > >  > 
 > >  > [PATCH] i4l: update hfc_usb driver
 > >  > 
 > >  >   - cleanup source
 > >  >   - remove nonfunctional code parts
 > > 
 > > Something isn't right with this.  We've got a number of reports from
 > > Fedora rawhide users over the last few days since this went in that
 > > this module is now auto-loading itself, and preventing other usb devices
 > > from working.
 > 
 > Putting the USB_DEVICE() thingies back in seems to fix it up?

Sounds good to me :-)

		Dave

