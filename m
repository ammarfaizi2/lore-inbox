Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317262AbSGCVwv>; Wed, 3 Jul 2002 17:52:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317263AbSGCVwu>; Wed, 3 Jul 2002 17:52:50 -0400
Received: from 89dyn229.com21.casema.net ([62.234.20.229]:4059 "EHLO
	abraracourcix.bitwizard.nl") by vger.kernel.org with ESMTP
	id <S317262AbSGCVwt>; Wed, 3 Jul 2002 17:52:49 -0400
Message-Id: <200207032154.XAA02758@cave.bitwizard.nl>
Subject: Re: sync slowness. ext3 on VIA vt82c686b
In-Reply-To: <20020703181929.GA6240@lnuxlab.ath.cx> from khromy at "Jul 3, 2002
 02:19:29 pm"
To: khromy <khromy@lnuxlab.ath.cx>
Date: Wed, 3 Jul 2002 23:54:25 +0200 (MEST)
CC: Tomas Szepe <szepe@pinerecords.com>, linux-kernel@vger.kernel.org,
       ext3-users@redhat.com
From: R.E.Wolff@BitWizard.nl (Rogier Wolff)
X-notice: Read http://www.bitwizard.nl/cou.html for the licence to my Emailaddr.
X-Mailer: ELM [version 2.4ME+ PL60 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

khromy wrote:
> On Wed, Jul 03, 2002 at 07:43:40PM +0200, Tomas Szepe wrote:
> > Checking out $(smartctl -l /dev/hda) might be advisable too.
> 
> # smartctl -l /dev/hda
> SMART Error Log:
> SMART Error Logging Version: 1
> Error Log Data Structure Pointer: 05
> ATA Error Count: 1038
                ^^^^^^^^

Whoa! That "dying" drive that I had on my desk today, had a similar
error count. 

Speaking of "SMART": Does anybody know where to get the specs for
SMART?

The "product manuals" for the maxtor drives re-specify the ATA specs
by fully explaining every command, but when it comes to "SMART" it
just lists something like "READ SMART DATA: 512 bytes".

			Roger. 

-- 
** R.E.Wolff@BitWizard.nl ** http://www.BitWizard.nl/ ** +31-15-2137555 **
*-- BitWizard writes Linux device drivers for any device you may have! --*
* There are old pilots, and there are bold pilots. 
* There are also old, bald pilots. 
