Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932299AbWG3MYR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932299AbWG3MYR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jul 2006 08:24:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932301AbWG3MYQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jul 2006 08:24:16 -0400
Received: from webmail-outgoing.us4.outblaze.com ([205.158.62.67]:13240 "EHLO
	webmail-outgoing.us4.outblaze.com") by vger.kernel.org with ESMTP
	id S932299AbWG3MYQ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jul 2006 08:24:16 -0400
X-OB-Received: from unknown (205.158.62.182)
  by wfilter2.us4.outblaze.com; 30 Jul 2006 12:24:14 -0000
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
Content-Type: text/plain; charset=US-ASCII
MIME-Version: 1.0
From: "Simon White" <s_a_white@email.com>
To: "Rene Herman" <rene.herman@keyaccess.nl>
Cc: linux-kernel@vger.kernel.org
Date: Sun, 30 Jul 2006 07:24:15 -0500
Subject: Re: Driver model ISA bus
X-Originating-Ip: 82.9.64.190
X-Originating-Server: ws1-6.us4.outblaze.com
Message-Id: <20060730122415.A17D31CE304@ws1-6.us4.outblaze.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > Is the intent of name to be the cards address, and ndev to be the
> > function on a specific card?
> 
> No, the name is just an identifier under which the driver (and 
> devices) show up in sysfs and ndev the number of devices we want to 
> the driver code to call our methods with -- given that ISA devices 
> do not announce themselves we have to tell the driver core this.

If I understood correctly, it is the maximum number of devices our
driver will support.  I got confused with an earlier version of this
whereby devices were to be registered with the isa bus on finding
them.

One further thing I'd like to check.  In my case there can only be
a maximum of 4 cards, limited by the possible hardware addresses
manually selectable.  Will the probe calls just happen or do they
require some userspace activity to occur (referring to that echo
bind in the example).

> By the way, please CC people on LKML. I'm still being busy and had 
> to pick this out of the trash where it caught my eye by chance...

Sorry, I caught this message on lkml.org and it had stripped the
email addresses.  Not sure what else to use (am not currently
subscribed to the list either).  I also seem to notice hitting
reply to a message appears to start a new thread rather than
add to an existing one...

Simon

-- 
___________________________________________________
Play 100s of games for FREE! http://games.mail.com/

