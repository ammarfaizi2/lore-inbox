Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264670AbTFYRUA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jun 2003 13:20:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264732AbTFYRUA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jun 2003 13:20:00 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:11199 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S264731AbTFYRTw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jun 2003 13:19:52 -0400
Date: Wed, 25 Jun 2003 10:33:26 -0700
From: Greg KH <greg@kroah.com>
To: Mark Watts <m.watts@eris.qinetiq.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Finding out what cards a driver supports...
Message-ID: <20030625173326.GB11589@kroah.com>
References: <200306251453.02690.m.watts@eris.qinetiq.com> <20030625143239.GA11244@gtf.org> <200306251658.35745.m.watts@eris.qinetiq.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200306251658.35745.m.watts@eris.qinetiq.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 25, 2003 at 04:58:35PM +0100, Mark Watts wrote:
> 
> > On Wed, Jun 25, 2003 at 02:53:02PM +0100, Mark Watts wrote:
> > > How would I find out what network cards a particular driver supports?
> > > (particularly the tg3 / bcm5700 driver in 2.4.x)
> >
> > Look in the PCI ids table, and compare that with the output of 'lspci -n'
> > for your card.
> >
> > 	Jeff
> 
> Is there a way to do it without actually having the card in question?
> 
> I'm trying to help a chap who has a 3Com 3c940 GigE card...

Have them run 'lspci -n'  :)


