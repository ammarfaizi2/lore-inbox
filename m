Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269008AbTGOQxe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 12:53:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269012AbTGOQxe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 12:53:34 -0400
Received: from mailhost.tue.nl ([131.155.2.7]:43280 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id S269008AbTGOQxR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 12:53:17 -0400
Date: Tue, 15 Jul 2003 19:08:04 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: Jeff Garzik <jgarzik@pobox.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Dave Jones <davej@codemonkey.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.5 'what to expect'
Message-ID: <20030715170804.GA1089@win.tue.nl>
References: <20030711155613.GC2210@gtf.org> <20030711203850.GB20970@win.tue.nl> <20030715000331.GB904@matchmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030715000331.GB904@matchmail.com>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 14, 2003 at 05:03:31PM -0700, Mike Fedyk wrote:

> So, will the DOS partition make it up to 2TB?  If so, then we won't have
> a problem until we have larger than 2TB drives

Yes, DOS partition table works up to 2^32 sectors, and with
2^9-byte sectors that is 2 TiB.

People are encountering that limit already. We need something
better, either use some existing scheme, or invent something.

Andries


