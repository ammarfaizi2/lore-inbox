Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751331AbWCAXZh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751331AbWCAXZh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Mar 2006 18:25:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751936AbWCAXZh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Mar 2006 18:25:37 -0500
Received: from dspnet.fr.eu.org ([213.186.44.138]:44553 "EHLO dspnet.fr.eu.org")
	by vger.kernel.org with ESMTP id S1751331AbWCAXZg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Mar 2006 18:25:36 -0500
Date: Thu, 2 Mar 2006 00:25:35 +0100
From: Olivier Galibert <galibert@pobox.com>
To: Greg KH <greg@kroah.com>
Cc: Ren? Rebe <rene@exactcode.de>, linux-kernel@vger.kernel.org
Subject: Re: MAX_USBFS_BUFFER_SIZE
Message-ID: <20060301232535.GA13225@dspnet.fr.eu.org>
Mail-Followup-To: Olivier Galibert <galibert@pobox.com>,
	Greg KH <greg@kroah.com>, Ren? Rebe <rene@exactcode.de>,
	linux-kernel@vger.kernel.org
References: <200603012116.25869.rene@exactcode.de> <20060301213223.GA17270@kroah.com> <200603012242.35633.rene@exactcode.de> <20060301215423.GA17825@kroah.com> <20060301223430.GA9159@dspnet.fr.eu.org> <20060301224123.GA10422@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060301224123.GA10422@kroah.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 01, 2006 at 02:41:23PM -0800, Greg KH wrote:
> On Wed, Mar 01, 2006 at 11:34:30PM +0100, Olivier Galibert wrote:
> > As a data point, I have traces of a scanner session including a
> > download of a 26Mb binary image using 524288 bytes logical blocks
> > physically transferred with 61440 bytes bulk_in frames.  Seems stable
> > enough.  IIRC the scanner-side controller chip has some advanced
> > buffering just to handle that kind of bandwidth.
> 
> That's impressive.  What are the endpoint sizes on the device that did
> this?

Hmmm, the chip is a Genesys gl841, on a canonscan lide 35.  And it
advertises a 64 bytes wMaxPacketSize on both in and out bulk
interfaces.  Go figure.

Want the log and/or the lsusb -v?

  OG.
