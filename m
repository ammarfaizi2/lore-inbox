Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263176AbTE2XfF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 May 2003 19:35:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263179AbTE2XfF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 May 2003 19:35:05 -0400
Received: from yankee.rb.xcalibre.co.uk ([217.8.240.35]:45033 "EHLO
	yankee.rb.xcalibre.co.uk") by vger.kernel.org with ESMTP
	id S263176AbTE2XfE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 May 2003 19:35:04 -0400
Envelope-to: linux-kernel@vger.kernel.org
From: Alistair J Strachan <alistair@devzero.co.uk>
To: Greg KH <greg@kroah.com>
Subject: Re: 2.5.69-mm9
Date: Fri, 30 May 2003 00:48:16 +0100
User-Agent: KMail/1.5.9
Cc: linux-kernel@vger.kernel.org
References: <20030525172746.43b9866d.akpm@digeo.com> <20030529204324.GF25560@kroah.com>
In-Reply-To: <20030529204324.GF25560@kroah.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200305300048.16337.alistair@devzero.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 29 May 2003 21:43, Greg KH wrote:
> > While we're at it, any idea why this is shown in dmesg:
> >
> > Please use the 'usbfs' filetype instead, the 'usbdevfs' name is
> > deprecated.
> >
> > Even though I've clearly got this in /etc/fstab:
> >
> > [alistair] 11:44 PM [~] cat /etc/fstab | grep usb
> > none /proc/bus/usb usbfs defaults 0 0
>
> See the bugzilla.kernel.org bug entry for this issue:
> 	http://bugme.osdl.org/show_bug.cgi?id=223
> for more information on why this happens.

Thanks Greg, I should've checked there first.

Hope you get it fixed.

Cheers,
Alistair.
