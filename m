Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030199AbWFAPYo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030199AbWFAPYo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jun 2006 11:24:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030200AbWFAPYo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jun 2006 11:24:44 -0400
Received: from caffeine.uwaterloo.ca ([129.97.134.17]:11399 "EHLO
	caffeine.csclub.uwaterloo.ca") by vger.kernel.org with ESMTP
	id S1030199AbWFAPYn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jun 2006 11:24:43 -0400
Date: Thu, 1 Jun 2006 11:23:44 -0400
To: "linux-os (Dick Johnson)" <linux-os@analogic.com>
Cc: Alan Stern <stern@rowland.harvard.edu>, Andrew Morton <akpm@osdl.org>,
       David Liontooth <liontooth@cogweb.net>, linux-kernel@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net
Subject: Re: USB devices fail unnecessarily on unpowered hubs
Message-ID: <20060601152344.GB23746@csclub.uwaterloo.ca>
References: <Pine.LNX.4.44L0.0606011050330.6784-100000@iolanthe.rowland.org> <Pine.LNX.4.61.0606011104140.1745@chaos.analogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0606011104140.1745@chaos.analogic.com>
User-Agent: Mutt/1.5.9i
From: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: lsorense@csclub.uwaterloo.ca
X-SA-Exim-Scanned: No (on caffeine.csclub.uwaterloo.ca); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 01, 2006 at 11:09:46AM -0400, linux-os (Dick Johnson) wrote:
> Many, most, perhaps all such devices don't take more power when they
> are "enabled". Everything is already running and sucking up maximum
> current when you plug it in! If the motherboard didn't smoke when
> the device was plugged in, you might just as well let the user use
> it! Perhaps a ** WARNING ** message somewhere, but by golly, they
> got it running or else you wouldn't be able to read its parameters.

I imagine something like a harddisk might use more power while
reading/writing than when it is just spinning.  It might even start
powered down until sent some command that causes it to spin up.

A scanner certainly uses more power with the scanner light on than with
it off, and it starts out off until it is in use on most scanners.  Of
course I have never seen a usb powered scanner, so it doesn't seem to
matter.

Len Sorensen
