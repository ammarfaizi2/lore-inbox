Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293595AbSCKDte>; Sun, 10 Mar 2002 22:49:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293598AbSCKDtZ>; Sun, 10 Mar 2002 22:49:25 -0500
Received: from alb-66-24-183-158.nycap.rr.com ([66.24.183.158]:24738 "EHLO
	incandescent.mp3revolution.net") by vger.kernel.org with ESMTP
	id <S293595AbSCKDtO>; Sun, 10 Mar 2002 22:49:14 -0500
Date: Sun, 10 Mar 2002 22:49:14 -0500
From: Andres Salomon <dilinger@mp3revolution.net>
To: Jeff Garzik <garzik@havoc.gtf.org>
Cc: linux-kernel@vger.kernel.org, jgarzik@mandrakesoft.com,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: tulip woes
Message-ID: <20020311034914.GA5305@mp3revolution.net>
In-Reply-To: <20020131004733.GA25163@mp3revolution.net> <20020131142356.B1752@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020131142356.B1752@havoc.gtf.org>
User-Agent: Mutt/1.3.27i
X-Operating-System: Linux incandescent 2.4.18-pre7-ac3 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Still waiting for this fix to appear in the -ac tree.. as of
2.4.19-pre2-ac3, the problem persists.  Tarring up the tulip directory
in 2.4.10-ac12, and copying it over to the current kernel works, as a
temporary workaround.


On Thu, Jan 31, 2002 at 02:23:56PM -0500, Jeff Garzik wrote:
> 
> On Wed, Jan 30, 2002 at 07:47:33PM -0500, Andres Salomon wrote:
> > Jan 30 07:43:47 pinky kernel: eth0: Lite-On PNIC-II rev 37 at
> > 0xe0836000, 00:A0:CC:33:0D:FA, IRQ 11.
> > Jan 30 07:43:47 pinky kernel: eth0: Autonegotiation failed, using
> > 10baseT, link
> > beat status 10cc.
> > Jan 30 07:44:10 pinky kernel: NETDEV WATCHDOG: eth0: transmit timed out
> > Jan 30 07:44:10 pinky kernel: eth0: PNIC2 transmit timed out, status
> > e4260000, CSR6/7 e0402002 / effffbff CSR12 000000c8, resetting...
> > Jan 30 07:44:18 pinky kernel: NETDEV WATCHDOG: eth0: transmit timed out
> > Jan 30 07:44:18 pinky kernel: eth0: PNIC2 transmit timed out, status
> > e4260000, CSR6/7 e0402002 / effffbff CSR12 000000c8, resetting...
> 
> Kevin Hendricks sent me a patch for this, that I need to merge.
> 
> I'll dig it out after I return from LinuxWorld and post it here.
> Additional testers such as yourself are definitely welcome.
> 
> 	Jeff
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

-- 
"I think a lot of the basis of the open source movement comes from
  procrastinating students..."
	-- Andrew Tridgell <http://www.linux-mag.com/2001-07/tridgell_04.html>
