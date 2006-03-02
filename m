Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932085AbWCBJEe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932085AbWCBJEe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Mar 2006 04:04:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932111AbWCBJEe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Mar 2006 04:04:34 -0500
Received: from mx01.qsc.de ([213.148.129.14]:16839 "EHLO mx01.qsc.de")
	by vger.kernel.org with ESMTP id S932092AbWCBJEd convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Mar 2006 04:04:33 -0500
From: =?iso-8859-1?q?Ren=E9_Rebe?= <rene@exactcode.de>
Organization: ExactCODE
To: Greg KH <greg@kroah.com>
Subject: Re: MAX_USBFS_BUFFER_SIZE
Date: Thu, 2 Mar 2006 10:04:21 +0100
User-Agent: KMail/1.9
Cc: linux-kernel@vger.kernel.org
References: <200603012116.25869.rene@exactcode.de> <200603012242.35633.rene@exactcode.de> <20060301215423.GA17825@kroah.com>
In-Reply-To: <20060301215423.GA17825@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200603021004.21232.rene@exactcode.de>
X-Spam-Score: -1.4 (-)
X-Spam-Report: Spam detection software, running on the system "grum.localhost", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or label
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  Hi, On Wednesday 01 March 2006 22:54, Greg KH wrote: > >
	> Why not just send down 2 urbs with that size then, that would keep the
	> > > pipe quite full. > > > > Because that requires even more
	modifications to libusb and sane (i_usb) ... > > No, do it in your
	application I mean. [...] 
	Content analysis details:   (-1.4 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	-1.4 ALL_TRUSTED            Passed through trusted hosts only via SMTP
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wednesday 01 March 2006 22:54, Greg KH wrote:

> > > Why not just send down 2 urbs with that size then, that would keep the
> > > pipe quite full.
> > 
> > Because that requires even more modifications to libusb and sane (i_usb) ...
> 
> No, do it in your application I mean.

? The driver is a SANE backend and forced to use sanei_usb over libusb. Thus
I have to modifiy them all to allow asynchon URB queuing - or have I missed
something?

Yours,

-- 
René Rebe - Rubensstr. 64 - 12157 Berlin (Europe / Germany)
            http://www.exactcode.de | http://www.t2-project.org
            +49 (0)30  255 897 45
