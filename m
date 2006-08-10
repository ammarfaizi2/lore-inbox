Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751408AbWHJH0D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751408AbWHJH0D (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 03:26:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751440AbWHJH0D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 03:26:03 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:22483 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751408AbWHJH0C (ORCPT
	<rfc822;Linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 03:26:02 -0400
Message-ID: <44DADF88.5060102@garzik.org>
Date: Thu, 10 Aug 2006 03:26:00 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: keith.packard@intel.com
CC: Linux-kernel@vger.kernel.org, Dirk Hohndel <dirk.hohndel@intel.com>,
       Imad Sousou <imad.sousou@intel.com>
Subject: Re: Announcing free software graphics drivers for Intel i965	chipset
References: <1155151903.11104.112.camel@neko.keithp.com>	 <44DACD51.7080607@garzik.org> <1155194157.6386.14.camel@neko.keithp.com>
In-Reply-To: <1155194157.6386.14.camel@neko.keithp.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keith Packard wrote:
> On Thu, 2006-08-10 at 02:08 -0400, Jeff Garzik wrote:
> 
>> * is the 3D stuff available from git somewhere?  The download filename 
>> includes "-git-", but the checkout instructions reference cvs.
> 
> Yes, the 3D stuff is in the Mesa CVS repository, but you'll need the
> X.org 2D driver and the DRM kernel bits to use it.

So, the answer to "is the 3D stuff available from git?" is "no"?


>> * is anyone working on a more dynamic GLSL compilation system?  i.e. a 
>> "JIT", in compiler technology terms.
> 
> Yes, that's all included at the same price. Mesa includes the pieces to
> get to a reasonable IR which can then be converted to the necessary
> target-specific instruction set by the driver. Much of the 3D driver for
> the 965 actually uses GLSL to execute things previously handled by the
> traditional fixed function pipeline.

Very cool, thanks.

	Jeff


