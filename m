Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130139AbRAXIoh>; Wed, 24 Jan 2001 03:44:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130202AbRAXIo2>; Wed, 24 Jan 2001 03:44:28 -0500
Received: from aragorn.ics.muni.cz ([147.251.4.33]:63187 "EHLO
	aragorn.ics.muni.cz") by vger.kernel.org with ESMTP
	id <S130139AbRAXIoU>; Wed, 24 Jan 2001 03:44:20 -0500
Date: Wed, 24 Jan 2001 09:43:45 +0100
From: Petr Matula <pem@informatics.muni.cz>
To: Duncan Laurie <duncan@virtualwire.org>, randy.dunlap@intel.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: int. assignment on SMP + ServerWorks chipset
Message-ID: <20010124094345.A13854894@aisa.fi.muni.cz>
In-Reply-To: <3A64F7E2.30807@virtualwire.org> <20010118095810.A13218780@aisa.fi.muni.cz> <20010121215423.A20953@virtualwire.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <20010121215423.A20953@virtualwire.org>; from duncan@virtualwire.org on Sun, Jan 21, 2001 at 09:54:23PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Duncan and Randy,

I tested Duncan's patch. It works for me with parameters "mpint=5,0,4,9".

On Sun, Jan 21, 2001 at 09:54:23PM -0700, Duncan Laurie wrote:
> The values to use depend on what your system is configured to use
> for the USB interrupt.  This can be obtained by using the dump_pirq
> utility from the recent pcmcia utilities.  (I made some modifications
> to recognize the ServerWorks IRQ router which is available from
> ftp://virtualwire.org/dump_pirq)
dump_pirq gives me the same output like to Randy. I used the small 
program posted by Duncan to find the new USB interrupt.

If I understand it well, it's time to wait for BIOS upgrade and 
meanwhile Duncan's patch must be used, isn't it?

Thank you very much for all your help.

Petr

P.S. I'm sorry for the delay. I couldn't reboot the system because
it was in use by other users of our group.

---------------------------------------------------------------
 Petr Matula                                    pem@fi.muni.cz
                                    http://www.fi.muni.cz/~pem
---------------------------------------------------------------
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
