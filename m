Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265950AbTFSVEQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jun 2003 17:04:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265949AbTFSVEQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jun 2003 17:04:16 -0400
Received: from fmr02.intel.com ([192.55.52.25]:30430 "EHLO
	caduceus.fm.intel.com") by vger.kernel.org with ESMTP
	id S265950AbTFSVEP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jun 2003 17:04:15 -0400
Message-ID: <A46BBDB345A7D5118EC90002A5072C780E040933@orsmsx116.jf.intel.com>
From: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>
To: "'Alan Stern'" <stern@rowland.harvard.edu>,
       "'Patrick Mochel'" <mochel@osdl.org>
Cc: "'Greg KH'" <greg@kroah.com>,
       "'viro@parcelfarce.linux.theplanet.co.uk'" 
	<viro@parcelfarce.linux.theplanet.co.uk>,
       "'Kevin P. Fleming'" <kpfleming@cox.net>,
       "'Russell King'" <rmk@arm.linux.org.uk>,
       "'Mike Anderson'" <andmike@us.ibm.com>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: RE: Flaw in the driver-model implementation of attributes
Date: Thu, 19 Jun 2003 14:18:11 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Alan Stern [mailto:stern@rowland.harvard.edu]
> 
> On Thu, 19 Jun 2003, Patrick Mochel wrote:
> 
> > SCSI copied USB in this respect. I've always been skeptical about the
> > representation, though Greg had good reason to initially do this. I
wonder
> > if that object could be moved over /sys/class/usb-host/ these days..
> 
> I wonder about the apparent proliferation of entries under /sys/class/.
> If people continue to add things like /sys/class/usb-storage/ right at the
> top level, won't it become rather unwieldy?  What would be a good place to
> put something like that?

That was exactly my point with the "it-should-go-where-the-
physical-device-is" suggestion. /sys/class will become something
as wild as /proc is now IANF.

Iñaky Pérez-González -- Not speaking for Intel -- all opinions are my own
(and my fault)
