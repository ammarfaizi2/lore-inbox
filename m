Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265096AbUFGW1L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265096AbUFGW1L (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jun 2004 18:27:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265103AbUFGW1L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jun 2004 18:27:11 -0400
Received: from smcc.demon.nl ([212.238.157.128]:40464 "HELO smcc.demon.nl")
	by vger.kernel.org with SMTP id S265096AbUFGW1G convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jun 2004 18:27:06 -0400
From: "Nemosoft Unv." <webcam@smcc.demon.nl>
To: Greg KH <greg@kroah.com>
Subject: Re: small patch: enable pwc usb camera driver
Date: Tue, 8 Jun 2004 00:27:04 +0200
User-Agent: KMail/1.6.1
Cc: kai.engert@gmx.de, linux-kernel@vger.kernel.org
References: <40C466FB.1040309@kuix.de> <20040607202036.GA6185@kroah.com>
In-Reply-To: <20040607202036.GA6185@kroah.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Message-Id: <200406080027.04577@smcc.demon.nl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 07 June 2004 22:20, Greg KH wrote:
> On Mon, Jun 07, 2004 at 03:00:43PM +0200, Kai Engert wrote:
> > The attached patch enables the pwc driver included with kernel
> > 2.6.7-rc2
> >
> > It also removes the warnings during compilation.
> > However, note that I blindly duplicated the release approach used by
> > other usb camera drivers, replacing the current no-op.
> >
> > The driver works for me with a Logitech QuickCam Notebook Pro and
> > GnomeMeeting.
>
> Nice, thanks, I've applied this.  

Don't use this. It will BUG() your kernel hard, because of a double free(). 

> It's amazing how long it took for this to be fixed... :(

I could start a big *bleep*ing rant about this, but I´ll save that for some 
other time.

 - Nemosoft

