Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270488AbUJTWsy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270488AbUJTWsy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 18:48:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269157AbUJTWpr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 18:45:47 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:59044 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S270577AbUJTWlH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 18:41:07 -0400
Date: Wed, 20 Oct 2004 23:41:06 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: John Cherry <cherry@osdl.org>
Cc: Matthew Dharm <mdharm-kernel@one-eyed-alien.net>,
       Linus Torvalds <torvalds@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux v2.6.9... (compile stats)
Message-ID: <20041020224106.GM23987@parcelfarce.linux.theplanet.co.uk>
References: <Pine.LNX.4.58.0410181540080.2287@ppc970.osdl.org> <1098196575.4320.0.camel@cherrybomb.pdx.osdl.net> <20041019161834.GA23821@one-eyed-alien.net> <1098310286.3381.5.camel@cherrybomb.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1098310286.3381.5.camel@cherrybomb.pdx.osdl.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 20, 2004 at 03:11:26PM -0700, John Cherry wrote:
> On Tue, 2004-10-19 at 09:18, Matthew Dharm wrote:
> > These are x86-based stats, yes?  I'm sure other arches will likely tease
> > out more...
> 
> Yes, they are x86-based.  Other archs are on my list of things to do. 
> If you would like to pick up the ball with these other archs, the
> compile tools are at http://developer.osdl.org/cherry/compile/tools/

I've got a setup of my own dealing with i386/amd64/alpha/sparc32/sparc64/ppc
for now (both build and sparse).  If you want results published, it's not
a problem...
 
> A lot of these readl/writel warnings HAVE been addressed.  In 2.6.9-rc2,
> there were about 3000 of these warnings.  In 2.6.9, there are less than
> 1900.
 
>    drivers/net: 756 warnings, 0 errors

Dealt with.

>    drivers/pcmcia: 3 warnings, 0 errors
>    drivers/scsi/megaraid: 10 warnings, 0 errors

Ditto.

>    drivers/scsi/pcmcia: 3 warnings, 0 errors
>    drivers/scsi: 148 warnings, 0 errors

Mostly dealt with, but I'm still messing with SATA parts.

>    drivers/telephony: 2 warnings, 0 errors
>    drivers/video/aty: 4 warnings, 0 errors
>    drivers/video/kyro: 112 warnings, 0 errors

Ditto.

I'll carve up today's fixes and post the patchset in an hour or so...
