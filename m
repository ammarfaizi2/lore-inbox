Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751073AbWIYQIt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751073AbWIYQIt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Sep 2006 12:08:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751082AbWIYQIs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Sep 2006 12:08:48 -0400
Received: from www.osadl.org ([213.239.205.134]:18353 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S1751073AbWIYQIs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Sep 2006 12:08:48 -0400
Subject: Re: GPLv3 Position Statement
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Neil Brown <neilb@suse.de>, Michiel de Boer <x@rebelhomicide.demon.nl>,
       James Bottomley <James.Bottomley@SteelEye.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <1159183895.11049.56.camel@localhost.localdomain>
References: <1158941750.3445.31.camel@mulgrave.il.steeleye.com>
	 <451798FA.8000004@rebelhomicide.demon.nl>
	 <17687.46268.156413.352299@cse.unsw.edu.au>
	 <1159183895.11049.56.camel@localhost.localdomain>
Content-Type: text/plain
Date: Mon, 25 Sep 2006 18:10:20 +0200
Message-Id: <1159200620.9326.447.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-09-25 at 12:31 +0100, Alan Cox wrote:
> The GPLv3 rewords it in an attempt to be clearer but also I think rather
> more over-reaching. It's not clear what for example happens with a
> rented device containing GPL software but with DRM on the hardware.
> Thats quite different to owned hardware. GPLv2 leaves it open for the
> courts to make a sensible decision per case, GPLv3 tries to define it in
> advance and its very very hard to define correctly.

Also the prevention of running modified versions is not only caused by
economic interests and business models. There are also scenarios where
it is simply necessary:

- The liability for damages, where the manufacturer of a device might
be responsible in case of damage when he abandoned the prevention. This
applies to medical devices as well as to lasers, machine tools and many
more. Device manufacturers can not necessarily escape such liabilities
as it might be considered grossly negligent to hand out the prevention
key, even if the user signed an exemption from liability.

- Regulations to prevent unauthorized access to radio frequencies, which
is what concerns e.g. cellphone manufacturers.

- ...

An ultimate definition of acceptable and unacceptable usage scenarios is
simply not possible due to the complexity of the problem. Any attempt to
create a definition will lead to loopholes and grey areas. Further it
will compulsory exclude acceptable usage scenarios.

A simple loophole example was brought up in the discussion already:
Technical limitations which do not allow modification at all, e.g. ROMs,
ASICs are apparently considered as a valid usage scenario, but it also
allows in consequence the circumvention of the intended lock down
protection by simple technical means, e.g. ROM based software
cartridges.

If you knit narrower meshes, you create more holes. This is not only
true for knitgoods, it's also a well known problem of legal systems.

	tglx


