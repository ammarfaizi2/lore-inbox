Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266376AbTGJQri (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jul 2003 12:47:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266383AbTGJQri
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jul 2003 12:47:38 -0400
Received: from storm.he.net ([64.71.150.66]:6304 "HELO storm.he.net")
	by vger.kernel.org with SMTP id S266376AbTGJQrg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jul 2003 12:47:36 -0400
Date: Thu, 10 Jul 2003 10:02:17 -0700
From: Greg KH <greg@kroah.com>
To: John Wong <kernel@implode.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: USB stops working with any of 2.4.22-pre's after 2.4.21
Message-ID: <20030710170217.GA12098@kroah.com>
References: <20030710065801.GA351@gambit.implode.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030710065801.GA351@gambit.implode.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 09, 2003 at 11:58:01PM -0700, John Wong wrote:
> Jul  9 23:39:44 gambit kernel: eth0: Resetting the Tx ring pointer.
> Jul  9 23:39:51 gambit kernel: usb-ohci.c: unlink URB timeout
> Jul  9 23:39:54 gambit kernel: NETDEV WATCHDOG: eth0: transmit timed out

Hm, looks like bad things are happening with your interrupts.

Do you need acpi to run this box?  What happens if you disable it?

As it looks like networking is also in trouble, I don't think this is a
USB specific problem for you.

Good luck,

greg k-h
