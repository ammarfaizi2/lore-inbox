Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964833AbVIOLQ5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964833AbVIOLQ5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Sep 2005 07:16:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750891AbVIOLQ5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Sep 2005 07:16:57 -0400
Received: from hermes.domdv.de ([193.102.202.1]:32520 "EHLO hermes.domdv.de")
	by vger.kernel.org with ESMTP id S1750770AbVIOLQ4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Sep 2005 07:16:56 -0400
Message-ID: <43295825.90205@domdv.de>
Date: Thu, 15 Sep 2005 13:16:53 +0200
From: Andreas Steinmetz <ast@domdv.de>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050724)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: daniel.blueman@gmail.com
CC: Runar Ingebrigtsen <runar@mopo.no>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Help porting wireless InProComm IPN 2220 driver to 2.6
References: <6278d22205091503442c3973d4@mail.gmail.com>
In-Reply-To: <6278d22205091503442c3973d4@mail.gmail.com>
X-Enigmail-Version: 0.92.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel J Blueman wrote:
> The file D-Link has made available contains either this or a
> closed-source driver.
> 

This is getting interesting. The tar archive contains a kernel source
tree (looks like 2.4.26). This kernel source tree contains the directory:

linux-2.4.x/drivers/net/wireless/inpro2220

Within this directory there's the file IPN2220 which is a mips object
file, so this is a binary only driver.

Now, even if this is built as a module the module "source" is imported
in the kernel source tree, i.e. it is not separate from the kernel
source. IMHO I do see this then as a GPL violation that goes beyond the
Linus tolerated level.

-- 
Andreas Steinmetz                       SPAMmers use robotrap@domdv.de
