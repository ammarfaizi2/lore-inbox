Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293457AbSCOXBp>; Fri, 15 Mar 2002 18:01:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293458AbSCOXBg>; Fri, 15 Mar 2002 18:01:36 -0500
Received: from 89dyn224.com21.casema.net ([62.234.20.224]:60290 "EHLO
	abraracourcix.bitwizard.nl") by vger.kernel.org with ESMTP
	id <S293457AbSCOXBV>; Fri, 15 Mar 2002 18:01:21 -0500
Message-Id: <200203152301.AAA17721@cave.bitwizard.nl>
Subject: Re: RAID magics gone...
In-Reply-To: From Rogier Wolff at "Mar 10, 2002 10:14:30 am"
To: Rogier Wolff <R.E.Wolff@BitWizard.nl>
Date: Sat, 16 Mar 2002 00:01:13 +0100 (MET)
CC: linux-kernel@vger.kernel.org, samuel@bcgreen.com
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

Rogier Wolff wrote:
> I have a machine with 4 160G disks in a raid-0 configuration. Now
> after upgrading the hardware, all of a sudden raidstart can't find the
> raid-superblocks anymore. Invalid magic. 

I forgot to send out the "resolution" of this. 

Turns out it has to do withg 48bit addressing and the Promise
controller that I wanted them on.

They work great now on the controller on the motherboard. Thanks
to all who helped!

			Roger. 

-- 
** R.E.Wolff@BitWizard.nl ** http://www.BitWizard.nl/ ** +31-15-2137555 **
*-- BitWizard writes Linux device drivers for any device you may have! --*
* There are old pilots, and there are bold pilots. 
* There are also old, bald pilots. 
