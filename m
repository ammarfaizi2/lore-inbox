Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261672AbTDQPoH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Apr 2003 11:44:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261695AbTDQPoH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Apr 2003 11:44:07 -0400
Received: from havoc.daloft.com ([64.213.145.173]:57488 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S261672AbTDQPoG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Apr 2003 11:44:06 -0400
Date: Thu, 17 Apr 2003 11:56:02 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: John Bradford <john@grabjohn.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Patrick Mochel <mochel@osdl.org>,
       Grover Andrew <andrew.grover@intel.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Subtle semantic issue with sleep callbacks in drivers
Message-ID: <20030417155602.GC25696@gtf.org>
References: <20030417150926.GA25402@gtf.org> <200304171547.h3HFljoK000140@81-2-122-30.bradfords.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200304171547.h3HFljoK000140@81-2-122-30.bradfords.org.uk>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 17, 2003 at 04:47:45PM +0100, John Bradford wrote:
> Hmm, well what about with a PCI hotswap capable board - presumably
> then we could have the situation where a new VGA card appears that we
> _have_ to POST?

Then XFree86 will POST it.

The kernel really only cares about POST'ing the primary display, too.
Firmware typically completely disables, and does not POST, secondary
displays.  XFree86 is charged with the responsibility of POST'ing
secondary displays.

	Jeff



