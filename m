Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311629AbSCNOoQ>; Thu, 14 Mar 2002 09:44:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311630AbSCNOoH>; Thu, 14 Mar 2002 09:44:07 -0500
Received: from gold.he.net ([216.218.149.2]:26897 "EHLO gold.he.net")
	by vger.kernel.org with ESMTP id <S311629AbSCNOn5>;
	Thu, 14 Mar 2002 09:43:57 -0500
Reply-To: <jss@pacbell.net>
From: "J.S.S." <jss@pacbell.net>
To: "Mike Fedyk" <mfedyk@matchmail.com>
Cc: "linux-kernel" <linux-kernel@vger.kernel.org>
Subject: RE: New kernel reboots machine during boot up
Date: Thu, 14 Mar 2002 06:47:20 -0800
Message-ID: <PGEMINDOPMDNMJINCKBNAEFPCEAA.jss@pacbell.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
In-Reply-To: <20020314011025.GA363@matchmail.com>
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've had the same problem before.
The answer was in my configuration.  Make sure your options are chosen
correctly in the processor section of configuration.  If you need help, look
at a previous .config file you have.  Or, check out a stock .config file
from Redhat or another vendor where the kernel boots fine. The problem is
that you have some option checked that is not compatible with you
processor - or so was the case with mine.

				J.Souza

-----Original Message-----
From: linux-kernel-owner@vger.kernel.org
[mailto:linux-kernel-owner@vger.kernel.org]On Behalf Of Mike Fedyk
Sent: Wednesday, March 13, 2002 5:10 PM
To: Amir Kazerouninia
Cc: linux-kernel@vger.kernel.org
Subject: Re: New kernel reboots machine during boot up


On Wed, Mar 13, 2002 at 02:36:18PM -0800, Amir Kazerouninia wrote:
> Hello,
> 	The kernel I just compiled is the 2.4.18 kernel. LILO deals with the
large
> drive fine when booting the previous 2.2.19 kernel. I compiled the new one
> from scratch with no networking support and very little else. The problem
> basically occurs right at boot, it doesn't matter if I use a floppy to
boot
> or my haddrive. The problem with the harddrive is that I'll get a loading
> vmlinuz-2.4.18......... and then it reboots. I haven't been able to pause
it
> to get a clear picture of what is happening. The floppy is a little easier
> because what happens is that it says Loading, gives a series of dots and
> then reboots. Any suggestions would be greatly appreciated. Thanks in
> advance for suggestions.

You have probably optimized your kernel for the wrong processor.  Double
check that and try again.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

