Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293731AbSCLJAJ>; Tue, 12 Mar 2002 04:00:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310190AbSCLI7z>; Tue, 12 Mar 2002 03:59:55 -0500
Received: from 99dyn73.com21.casema.net ([62.234.30.73]:51666 "EHLO
	abraracourcix.bitwizard.nl") by vger.kernel.org with ESMTP
	id <S293731AbSCLI7j>; Tue, 12 Mar 2002 03:59:39 -0500
Message-Id: <200203120859.JAA04099@cave.bitwizard.nl>
Subject: zero copy. 
To: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Date: Tue, 12 Mar 2002 09:59:36 +0100 (MET)
CC: linux-net@vger.kernel.org
From: R.E.Wolff@BitWizard.nl (Rogier Wolff)
X-notice1: This Email contains my Email address. This grants you the right
X-notice2: to communicate with me using this address, related to the subject
X-notice3: in this message. Unsollicitated mass-mailings are explictly 
X-notice4: forbidden here, and by Dutch law. 
X-Mailer: ELM [version 2.4ME+ PL60 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

Is linux able to do zero copy?

I remember from previous discussions that there was always a camp
that would claim that the copy was free because of the checksum, 
and/or the other way around. And warming the cache on input would
prove to eliminate almost all overhead. 

I have an application where the bulk of the data is NOT generated or
consumed by the CPU, in fact, the CPU does not have enough bandwidth
to move all the data. We really need to have the DMA-devices go and
get the data for themselves....

So far, I'm finding more or less unavoidable copy to/from user calls
in both the tcp send and the tcp recieve path..... 

Suggestions?

			Roger. 

-- 
** R.E.Wolff@BitWizard.nl ** http://www.BitWizard.nl/ ** +31-15-2137555 **
*-- BitWizard writes Linux device drivers for any device you may have! --*
* There are old pilots, and there are bold pilots. 
* There are also old, bald pilots. 
