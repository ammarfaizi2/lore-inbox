Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262025AbSJNRaG>; Mon, 14 Oct 2002 13:30:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262039AbSJNRaF>; Mon, 14 Oct 2002 13:30:05 -0400
Received: from deimos.hpl.hp.com ([192.6.19.190]:451 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S262025AbSJNRaE>;
	Mon, 14 Oct 2002 13:30:04 -0400
Date: Mon, 14 Oct 2002 10:34:21 -0700
To: "ALESSANDRO.SUARDI" <ALESSANDRO.SUARDI@oracle.com>
Cc: linux-kernel@vger.kernel.org, irda-users@lists.sourceforge.net
Subject: Re: 2.5.42: IrDA issues
Message-ID: <20021014173421.GC10672@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
References: <7034136.1034515639605.JavaMail.nobody@web11.us.oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7034136.1034515639605.JavaMail.nobody@web11.us.oracle.com>
User-Agent: Mutt/1.3.28i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 13, 2002 at 05:27:19AM -0800, ALESSANDRO.SUARDI wrote:
> I have a PPP over IrDA connection to my Nokia phone; under 2.4.20-preX I have no
>  problem keeping the link up, while in 2.5.4x it fails in a very short time like this:
> 
> Oct 13 01:13:13 dolphin kernel: IrLAP, no activity on link!
> Oct 13 01:13:11 dolphin kernel: NETDEV WATCHDOG: irda0: transmit timed out
> Oct 13 01:13:11 dolphin kernel: irda0: transmit timed out
> Oct 13 01:13:13 dolphin kernel: IrLAP, no activity on link!
> Oct 13 01:13:13 dolphin kernel: NETDEV WATCHDOG: irda0: transmit timed out
> Oct 13 01:13:13 dolphin kernel: irda0: transmit timed out
> Oct 13 01:13:13 dolphin pppd[5378]: Modem hangup
> Oct 13 01:13:13 dolphin pppd[5378]: Connection terminated.
> Oct 13 01:13:13 dolphin pppd[5378]: Connect time 1.8 minutes.
> Oct 13 01:13:13 dolphin pppd[5378]: Sent 19541 bytes, received 35933 bytes.
> Oct 13 01:13:13 dolphin pppd[5378]: Exit.
> 
> I also get the transmit timed out spam (why one with WATCHDOG and one without ?)
>  in 2.4.20-pre but the IrLAP line isn't there. And the GPRS link stays up...
> 
> 
> Thanks in advance for any insight,
> 
> --alessandro

	Please do yourself a favor and give me a proper bug report,
including hardware, driver and irdadump.

	Jean

