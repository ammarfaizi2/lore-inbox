Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266888AbTCDU7a>; Tue, 4 Mar 2003 15:59:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266907AbTCDU7a>; Tue, 4 Mar 2003 15:59:30 -0500
Received: from palrel10.hp.com ([156.153.255.245]:55203 "EHLO palrel10.hp.com")
	by vger.kernel.org with ESMTP id <S266888AbTCDU73>;
	Tue, 4 Mar 2003 15:59:29 -0500
Date: Tue, 4 Mar 2003 13:09:57 -0800
To: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: IrDA/PCMCIA CF conflict
Message-ID: <20030304210957.GA17857@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Erik Lotspeich wrote :
> 
> I have an IBM Thinkpad A21m with Linux 2.4.19.  Both the PCMCIA
> IDE/Compact Flash adapter and IrDA (syncing to Palm) works perfectly --
> separately.  If I boot with the CF/adapter in place, the IrDA does not
> work.  If I simply remove the PCMCIA card and re-insert it, IrDA works
> again.  If I boot without the PCMCIA CF adapter in place, then insert it
> after using the IrDA, no trouble.

	/etc/pcmcia/config.opts -> exclude irq

	Jean
