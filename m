Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129441AbRA3QyY>; Tue, 30 Jan 2001 11:54:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129632AbRA3QyO>; Tue, 30 Jan 2001 11:54:14 -0500
Received: from npt12056206.cts.com ([216.120.56.206]:33548 "HELO
	forty.spoke.nols.com") by vger.kernel.org with SMTP
	id <S129441AbRA3QyB>; Tue, 30 Jan 2001 11:54:01 -0500
Date: Tue, 30 Jan 2001 08:53:59 -0800
From: David Rees <dbr@spoke.nols.com>
To: linux-kernel@vger.kernel.org
Subject: Re: klogd is acting strange with 2.4
Message-ID: <20010130085359.A817@spoke.nols.com>
Mail-Followup-To: David Rees <dbr@spoke.nols.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20010130093035.A31970@dragon.universe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <20010130093035.A31970@dragon.universe>; from newsreader@mediaone.net on Tue, Jan 30, 2001 at 09:30:36AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 30, 2001 at 09:30:36AM -0500, newsreader@mediaone.net wrote:
> celeron 433 intel i810.  320MB ram.
> 
> Before 2.2.18.  Now I've tested with both
> 2.4.1-pre12 and 2.4.1.  2.4 kernel klogd is
> always using 99% cpu.  What gives?
> 
> I've three other less powerful boxes running
> 2.4.x kernels and none of them behave
> like this.  This server isn't taking any
> more hits than it usually does.
> 
> What more information I should post here?
> I've two apache servers, pgsql and sendmail
> and some other processes running on this
> server.

Can you try 2.4.0?  Are you using the 3c59x ethernet driver?  I've got the 
same problem on one of my machines, (see message with subject "2.4.1-pre10 
-> 2.4.1 klogd at 100% CPU ; 2.4.0 OK") and the last thing that is logged 
is a message from the 3c59x ethernet driver.

I'm doing a bit more digging to see what changed in the driver between 
revisions.  /proc/pci lists my 3c905B as this:
3Com Corporation 3c905B 100BaseTX [Cyclone] (rev 48)

-Dave
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
