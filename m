Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261684AbUDSR53 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Apr 2004 13:57:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261685AbUDSR53
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Apr 2004 13:57:29 -0400
Received: from palrel13.hp.com ([156.153.255.238]:48085 "EHLO palrel13.hp.com")
	by vger.kernel.org with ESMTP id S261684AbUDSR5U (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Apr 2004 13:57:20 -0400
Date: Mon, 19 Apr 2004 10:57:18 -0700
To: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.26 IRDA BUG - blocker
Message-ID: <20040419175718.GA7959@bougret.hpl.hp.com>
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

Michal Semler wrote :
> 
> Hi,
> 
> I have in my laptop this irda port:
> IrCOMM protocol (Dag Brattli)
> nsc-ircc, Found chip at base=0x02e
> nsc-ircc, driver loaded (Dag Brattli)
> IrDA: Registered device irda0
> 
> modules.conf:
> alias irda0 nsc-ircc
> options nsc-ircc dongle_id=0x08
> 
> When I try connect with 2.4.26 kernel to T68i
> I getts this message and then port freezes - no devices discovered and no 
> communication, sometimes freezes whole laptop:
> 
> irlap_adjust_qos_settings(), Detected buggy peer, adjust mtt to 10us!
> IrLAP, no activity on link!
> IrLAP, no activity on link!
> IrLAP, no activity on link!
> IrLAP, no activity on link!

	My web page document those kind of problems, how to configure
nsc-ircc, and how to report bug properly. Have you read it ?
	Note that I've just answered a similar question a couple of
days ago on the IrDA mailing list.

> previous versions were OK

	There was no IrDA changes from 2.4.25 to 2.4.26.

> 2.4.26-vanilla
> debian woody with bunk2 debs
> 
> Thanks a lot
> 
> Michal

Daniele Venzano wrote :
> I'm seeing this same behaviour with a Nokia 6610, same modules, same
> messages, but kernel 2.6.5.
> I also noted that with irdaping I loose one ping every 2, so that
> sequence numbers follow the following pattern:
> 1
> 2
> 4
> 5
> 7
> 8

	Same story, please read my web page on how to report bugs. And
I bet the problem is the same.

	Regards,

	Jean
