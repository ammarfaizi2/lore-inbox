Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264498AbRFTRW3>; Wed, 20 Jun 2001 13:22:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264500AbRFTRWT>; Wed, 20 Jun 2001 13:22:19 -0400
Received: from cobae1.consultronics.on.ca ([205.210.130.26]:21888 "EHLO
	cobae1.consultronics.on.ca") by vger.kernel.org with ESMTP
	id <S264499AbRFTRWO>; Wed, 20 Jun 2001 13:22:14 -0400
Date: Wed, 20 Jun 2001 13:22:12 -0400
From: Greg Louis <glouis@dynamicro.on.ca>
To: linux-kernel@vger.kernel.org
Subject: 2.4.5ac16 SMP kernel panic trying to kill init
Message-ID: <20010620132212.A1116@athame.dynamicro.on.ca>
Reply-To: Greg Louis <glouis@dynamicro.on.ca>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Organization: Dynamicro Consulting Limited
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kernel 2.4.5ac16 is running on several UP machines here, but the first
SMP machine I compiled it for fails early in boot.  I cleaned out the
source tree and recompiled, in case I'd botched the first try, but got
the same result.  Procedure for compilation was to patch, copy .config
from the running 2.4.5ac14 tree, make oldconfig, make dep, make clean,
make bzImage, make modules.  As that machine is relatively heavily used, I
couldn't take the time to write down the panic details, but the kernel
panicked "trying to kill init."  I realize this is not much to go on;
later, when I can take the machine down for a while, I'll reproduce the
panic and report in more detail.  Any suggestions for maximizing
diagnostic value of that report will be welcome.

-- 
| G r e g  L o u i s          | gpg public key:      |
|   http://www.bgl.nu/~glouis |   finger greg@bgl.nu |
