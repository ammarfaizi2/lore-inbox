Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265713AbSJXXMx>; Thu, 24 Oct 2002 19:12:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265712AbSJXXMx>; Thu, 24 Oct 2002 19:12:53 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:60299 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S265711AbSJXXMv>; Thu, 24 Oct 2002 19:12:51 -0400
Date: Thu, 24 Oct 2002 16:12:23 -0700
From: Hanna Linder <hannal@us.ibm.com>
To: Philippe Troin <phil@fifi.org>
cc: Hanna Linder <hannal@us.ibm.com>, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org, tmolina@cox.net, haveblue@us.ibm.com
Subject: Re: more aic7xxx boot failure
Message-ID: <16660000.1035501142@w-hlinder>
In-Reply-To: <87lm4nxxnj.fsf@ceramic.fifi.org>
References: <8800000.1035498319@w-hlinder> <87lm4nxxnj.fsf@ceramic.fifi.org>
X-Mailer: Mulberry/2.1.0 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--On Thursday, October 24, 2002 15:46:56 -0700 Philippe Troin <phil@fifi.org> wrote:

> 
> Have you tried booting with "noapic"?

	Just did, That solves the problem too.

 
> What error do you get on boot?

a kernel panic and scsi_abort error 0x2 (from what
I remember flying by)

Would have to hookup with a serial cable to get all
the data. Here is what I can see on the screen:

LASTPHASE = 0x1, SCSISIGI = 0x0, SXFRCTL0 = 0x0
SSTAT0 = 0x0, SSTAT1 = 0x8
STACK == 0x17, 0x0, 0x0, 0x0
SCB count = 4
Kernel NEXQSCB = 3
Card NEXTQSCB = 0
QINFIFO entries: 3 2
a list of Waiting Queue entries 
and a list of Disconnected Queue entries.
QUOTFIFI entries:
Sequencer Free SCB List: 0 to 31
Pending list: 2
Kernel Free SCB list: 1 0
Untagged Q(0): 2
DevQ(0:0:0):0 waiting
qinpos = 0, SCB index = 3
Kernel panic: Loop 1


Hanna


