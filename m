Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264447AbTFEEKe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jun 2003 00:10:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264460AbTFEEKd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jun 2003 00:10:33 -0400
Received: from nessie.weebeastie.net ([61.8.7.205]:45283 "EHLO
	nessie.weebeastie.net") by vger.kernel.org with ESMTP
	id S264447AbTFEEKc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jun 2003 00:10:32 -0400
Date: Thu, 5 Jun 2003 14:24:19 +1000
From: CaT <cat@zip.com.au>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.70: pcmcia oops (a real one! honest!)
Message-ID: <20030605042419.GA522@zip.com.au>
References: <20030528042610.GD6501@zip.com.au> <20030529090209.B12513@flint.arm.linux.org.uk> <20030529212139.GA25971@kroah.com> <20030531154142.GA473@zip.com.au> <20030602210537.GA6666@kroah.com> <20030603192836.GA12746@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030603192836.GA12746@kroah.com>
User-Agent: Mutt/1.3.28i
Organisation: Furball Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 03, 2003 at 12:28:36PM -0700, Greg KH wrote:
> Ah, stupid bug in the driver class code was causing this.  Can you try
> this patch out against a clean 2.5.70 tree?  It fixes the problem for
> me, and I want to make sure it fixes it for you too.

It does. Whilst I get no messages telling me ttyS1 and eth1 have been
deregistered, the kernel doesn't crash on me either and everything
appears normal with lspci.

Whee. :)

-- 
Martin's distress was in contrast to the bitter satisfaction of some
of his fellow marines as they surveyed the scene. "The Iraqis are sick
people and we are the chemotherapy," said Corporal Ryan Dupre. "I am
starting to hate this country. Wait till I get hold of a friggin' Iraqi.
No, I won't get hold of one. I'll just kill him."
	- http://www.informationclearinghouse.info/article2479.htm
