Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262026AbVCUVfm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262026AbVCUVfm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 16:35:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262039AbVCUVcX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 16:32:23 -0500
Received: from mailgw1.technion.ac.il ([132.68.238.34]:19166 "EHLO
	mailgw1.technion.ac.il") by vger.kernel.org with ESMTP
	id S261990AbVCUVak (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 16:30:40 -0500
Date: Mon, 21 Mar 2005 23:30:36 +0200 (IST)
From: Jacques Goldberg <goldberg@phep2.technion.ac.il>
X-X-Sender: goldberg@localhost.localdomain
Reply-To: Jacques Goldberg <Jacques.Goldberg@cern.ch>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: Greg KH <gregkh@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: Need break driver<-->pci-device automatic association
In-Reply-To: <20050321210948.B17493@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.58_heb2.09.0503212326040.8166@localhost.localdomain>
References: <Pine.LNX.4.58_heb2.09.0503181042470.8660@localhost.localdomain>
 <20050318165124.GC14952@kroah.com> <Pine.LNX.4.58_heb2.09.0503192021431.11358@localhost.localdomain>
 <20050321081638.GC2703@pazke> <20050321082228.A22099@flint.arm.linux.org.uk>
 <Pine.LNX.4.58_heb2.09.0503211336090.6491@localhost.localdomain>
 <20050321201847.A16069@flint.arm.linux.org.uk>
 <Pine.LNX.4.58_heb2.09.0503212248010.7910@localhost.localdomain>
 <20050321210948.B17493@flint.arm.linux.org.uk>
X-MailKey: 829.36.63
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




On Mon, 21 Mar 2005, Russell King wrote:

> What it comes back to is that we _need_ driver match priorities, so we
> can detect when a more specific driver for the device is loaded (iow
> one which matches by vendor+device rather than just class), unbind the
> existing driver, and bind the more specific one.

  Absolutely agreed. This is what I dreamt of when starting this thread.
  My job is done now. The ball is in your hands.
  I shall now become mute but shall read further.
  If you ever need a real test you will always be welcome  to send it to
me since I have a case hardware.

  Thanks to all of you. Cheers. Jacques
