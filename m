Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289775AbSBSF4k>; Tue, 19 Feb 2002 00:56:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289781AbSBSF4a>; Tue, 19 Feb 2002 00:56:30 -0500
Received: from jaded.anu.edu.au ([150.203.159.46]:15235 "EHLO
	jaded.neocomms.net") by vger.kernel.org with ESMTP
	id <S289775AbSBSF4T>; Tue, 19 Feb 2002 00:56:19 -0500
Date: Tue, 19 Feb 2002 16:52:43 +1100
From: Patrick Cole <z@amused.net>
To: Dennis Schoen <dennis@cobolt.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [BUG]: RT8139 Too much work at interrupt, IntrStatus=....
Message-ID: <20020219055243.GA4398@jaded.anu.edu.au>
In-Reply-To: <20020109090855.GA338@cobolt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=unknown-8bit
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20020109090855.GA338@cobolt.net>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Wed, Jan 09, 2002 at 10:08:55AM +0100, Dennis Schoen wrote:

> yesterday I upgraded a firewall/router of a *busy* customer site
> from version 2.4.7 -> 2.4.17. Only 1-2 seconds after the reboot the
> network card to the DMZ stopped working. I noticed this messages in
> /var/log/messages:
> 
> Jan  8 17:07:45 liquice kernel: 8139too: rx stop wait too long
> Jan  8 17:07:46 liquice kernel: eth1: Too much work at interrupt, IntrStatus=0x0050.
> Jan  8 17:07:46 liquice kernel: eth1: Too much work at interrupt, IntrStatus=0x0010.
> Jan  8 17:07:49 liquice kernel: 8139too: rx stop wait too long
> Jan  8 17:07:49 liquice kernel: eth1: Too much work at interrupt, IntrStatus=0x0001.
> Jan  8 17:07:51 liquice kernel: eth1: Too much work at interrupt, IntrStatus=0x0001.
> Jan  8 17:07:57 liquice kernel: eth1: Too much work at interrupt, IntrStatus=0x0050.
> Jan  8 17:07:57 liquice kernel: eth1: Setting 100mbps half-duplex based on auto-negotiated partner ability 40a1.
> Jan  8 17:08:09 liquice kernel: NETDEV WATCHDOG: eth1: transmit timed out
> Jan  8 17:08:09 liquice kernel: eth1: Setting 100mbps half-duplex based on auto-negotiated partner ability ffff.
> 
> after a reboot the same problem occured.
> 
> Switching back to v2.4.7 solved the problem so I don't think that
> it's a hardware issue.

Hi dennis, I'm getting these messages too with an identical card... 
8139 (rev 10)... seems to have started happening after I went to
2.4.17... strangely enough I'm getting very similar mæssages on the
machine right beside it.. running 2.4.13, SMP, and a 3com 3c905b
(Boomerang).

Anyone have any insight on this one?
 

-- 
Patrick Cole - Debian Developer <ltd@debian.org>
             - John Curtin, ANU <Patrick.Cole@anu.edu.au>
             - Linear-G Network Solutions <z@linearg.com>
             - PGP 1024R/60D74C7D C8E0BC7969BE7899AA0FEB16F84BFE5A   
