Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271230AbTHHFlI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Aug 2003 01:41:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271231AbTHHFlI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Aug 2003 01:41:08 -0400
Received: from mail1.scram.de ([195.226.127.111]:61970 "EHLO mail1.scram.de")
	by vger.kernel.org with ESMTP id S271230AbTHHFlH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Aug 2003 01:41:07 -0400
Date: Fri, 8 Aug 2003 07:40:19 +0200 (CEST)
From: Jochen Friedrich <jochen@scram.de>
X-X-Sender: jochen@gfrw1044.bocc.de
To: Russell King <rmk@arm.linux.org.uk>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       <dahinds@users.sourceforge.net>
Subject: Re: PCI1410 Interrupt Problems
In-Reply-To: <20030807000914.J16116@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.44.0308080739400.6802-100000@gfrw1044.bocc.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: ---- Start SpamAssassin results
  -0.10 points, 5 required;
  * -0.5 -- Has a In-Reply-To header
  *  0.0 -- Message-Id indicates a non-spam MUA (Pine)
  * -0.5 -- BODY: Contains what looks like a quoted email text
  *  0.9 -- RBL: Received via a relay in dnsbl.njabl.org
  [RBL check: found 181.23.224.217.dnsbl.njabl.org., type: 127.0.0.3]
  ---- End of SpamAssassin results
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Russel,

> I notice your lspci didn't list a subvendor / subdevice ID for your
> cardbus bridges - can you confirm by reporting the output of:
>
> # setpci -s bus:slot.func 0x40.l

rt1-sp:~# setpci -s 00:11.0 0x40.l
00000000

Thanks,
--jochen

