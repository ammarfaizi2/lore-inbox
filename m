Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261801AbTDHVJ2 (for <rfc822;willy@w.ods.org>); Tue, 8 Apr 2003 17:09:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261804AbTDHVJ2 (for <rfc822;linux-kernel-outgoing>); Tue, 8 Apr 2003 17:09:28 -0400
Received: from havoc.daloft.com ([64.213.145.173]:41709 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S261801AbTDHVJ0 (for <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Apr 2003 17:09:26 -0400
Date: Tue, 8 Apr 2003 17:20:59 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: Dominik Brodowski <linux@brodo.de>
Cc: linux-kernel@vger.kernel.org, rmk@arm.linux.org.uk
Subject: Re: [PATCHES 2.5.67] PCMCIA hotplugging, in-kernel-matching and depmod support
Message-ID: <20030408212059.GA5358@gtf.org>
References: <20030408205623.GA5253@brodo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030408205623.GA5253@brodo.de>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 08, 2003 at 10:56:23PM +0200, Dominik Brodowski wrote:
> ... and the deprecation of "cardmgr" and "cardctl"
> 
> Dear kernel developers and testers,
> 
> Updated and re-diffed revisions of my pcmcia-related patches are 
> available at http://www.brodo.de/pcmcia/
> 
> These patches update the PCMCIA subsystem (16-bit) to use the driver
> model matching and hotplug utilities. The "cardmgr" will not be 
> needed any longer - in fact, it won't even work any longer.
> 
> They are based on kernel 2.5.67

Will we see pcmcia id lists making their way into low-level drivers?

That was a big stumbling block when I last looked at the "big picture"
for pcmcia -- in-kernel drivers still required probe assistance from
userspace via the /etc/pcmcia/* bindings.

	Jeff



