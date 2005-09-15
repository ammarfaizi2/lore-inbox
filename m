Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751102AbVIOLp2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751102AbVIOLp2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Sep 2005 07:45:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751107AbVIOLp2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Sep 2005 07:45:28 -0400
Received: from hermes.domdv.de ([193.102.202.1]:64777 "EHLO hermes.domdv.de")
	by vger.kernel.org with ESMTP id S1751102AbVIOLp1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Sep 2005 07:45:27 -0400
Message-ID: <43295ED5.1090309@domdv.de>
Date: Thu, 15 Sep 2005 13:45:25 +0200
From: Andreas Steinmetz <ast@domdv.de>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050724)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: daniel.blueman@gmail.com
CC: Runar Ingebrigtsen <runar@mopo.no>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Help porting wireless InProComm IPN 2220 driver to 2.6
References: <6278d22205091503442c3973d4@mail.gmail.com>	 <43295825.90205@domdv.de> <6278d22205091504232ac3d8c3@mail.gmail.com>
In-Reply-To: <6278d22205091504232ac3d8c3@mail.gmail.com>
X-Enigmail-Version: 0.92.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel J Blueman wrote:
> This depends if the module uses any symbols exported from the kernel
> with EXPORT_SYMBOL_GPL(), and clearly the module license - 'strings'
> should be enough do check this is you don't have a MIPS platform to
> hand.

Even then (I didn't check the binary yet), is it really legal to
distribute a kernel source tree which contains sources with statements
like the following?

/******************************************************************************
Copyright (c) 2002-2003 Inprocomm, Inc.

All rights reserved. Copying, compilation, modification, distribution
or any other use whatsoever of this material is strictly prohibited
except in accordance with a Software License Agreement with Inprocomm, Inc.
******************************************************************************/

This doesn't look exactly like GPL compatability to me, still it is
_within_ the kernel tree.

Note that I don't say they can't distribute a binary only module, it is
the fact that it is located _within_ the kernel tree that, ahem,
irritates me.
I wouldn't say anything if there would be a separate 'source' tree for
the proprietary module but: is distributing a kernel source with
proprietary binary code embedded really legal?
-- 
Andreas Steinmetz                       SPAMmers use robotrap@domdv.de
