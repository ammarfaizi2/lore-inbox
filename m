Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964846AbWEYCJc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964846AbWEYCJc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 May 2006 22:09:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964850AbWEYCJc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 May 2006 22:09:32 -0400
Received: from smtp.enter.net ([216.193.128.24]:31503 "EHLO smtp.enter.net")
	by vger.kernel.org with ESMTP id S964846AbWEYCJc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 May 2006 22:09:32 -0400
From: "D. Hazelton" <dhazelton@enter.net>
To: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: OpenGL-based framebuffer concepts
Date: Wed, 24 May 2006 22:09:21 +0000
User-Agent: KMail/1.8.1
Cc: Jon Smirl <jonsmirl@gmail.com>,
       Matthew Garrett <mgarrett@chiark.greenend.org.uk>,
       Kyle Moffett <mrmacman_g4@mac.com>,
       Manu Abraham <abraham.manu@gmail.com>, linux cbon <linuxcbon@yahoo.fr>,
       Helge Hafting <helge.hafting@aitel.hist.no>, Valdis.Kletnieks@vt.edu,
       linux-kernel@vger.kernel.org
References: <20060519224056.37429.qmail@web26611.mail.ukl.yahoo.com> <9e4733910605231638t4da71284oa37b66a88c60cf8a@mail.gmail.com> <20060524220827.GA12192@srcf.ucam.org>
In-Reply-To: <20060524220827.GA12192@srcf.ucam.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605242209.22787.dhazelton@enter.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 24 May 2006 22:08, Matthew Garrett wrote:
> On Tue, May 23, 2006 at 07:38:40PM -0400, Jon Smirl wrote:
> > 2) The ROM support in the kernel knows about the shadow RAM copy at
> > C000::0. When you request the ROM from a laptop video system it
> > returns a map to the shadow RAM copy, not to a physical ROM. You need
> > access to the shadow RAM copy to get to things the BIOS left there
> > when it ran.
>
> My experience is that, on some laptops, the code at c000:0003 may jump
> into some other address block that isn't necessarily shadowed. There's
> no reason to assume that POSTing an ancilliary ROM will work after the
> system has left the BIOS. Further, my laptop doesn't appear to have a
> rom entry in sysfs, which makes getting at stuff that way rather more
> awkward...

As has been previously stated, the kernel should have already setup the 
primary video card by that point. EDID information can be used to get 
information about valid modes. I don't know of a single laptop that has 
multiple video cards in it. If you do, please enlighten me.

DRH
