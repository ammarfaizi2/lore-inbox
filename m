Return-Path: <linux-kernel-owner+w=401wt.eu-S1751058AbXAFBdW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751058AbXAFBdW (ORCPT <rfc822;w@1wt.eu>);
	Fri, 5 Jan 2007 20:33:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751062AbXAFBdW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Jan 2007 20:33:22 -0500
Received: from ns.suse.de ([195.135.220.2]:59817 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751057AbXAFBdV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Jan 2007 20:33:21 -0500
Date: Fri, 5 Jan 2007 17:32:53 -0800
From: Greg KH <greg@kroah.com>
To: Gene Heskett <gene.heskett@verizon.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PL2303 module
Message-ID: <20070106013253.GA7777@kroah.com>
References: <200612272248.06893.gene.heskett@verizon.net> <20070106004552.GA6374@kroah.com> <200701052025.59620.gene.heskett@verizon.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200701052025.59620.gene.heskett@verizon.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 05, 2007 at 08:25:59PM -0500, Gene Heskett wrote:
> On Friday 05 January 2007 19:45, Greg KH wrote:
> >On Wed, Dec 27, 2006 at 10:48:06PM -0500, Gene Heskett wrote:
> >> Greetings;
> >>
> >> Rather offtopic, but:
> >>
> >> Is there available anyplace, a document that describes how to
> >> configure the PL2303 USB<->serial adaptor to match up with all the
> >> hardware and flow control variations inherent in the basic rs-232
> >> spec?
> >
> >It should work like any other serial port on Linux, so try the serial
> >port programming HOWTO.
> 
> Maybe so Greg, but I spent quite some time on it a few months back, trying 
> to make '7 wire' protocol work, could not.  I could type back and forth 
> between terminal proggies, but an rzsz file transfer never got past the 
> first packet.

Hm, a number of the "odd" settings might not work on the usb-serial
converters, as they can't do them (or the driver doesn't know how to
configure the chip to do that.)

The pl2303 driver was reverse engineered by looking at data from other
operating systems, so perhaps no one has added that mode to it.

good luck,

greg k-h
