Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261660AbTI3TDd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Sep 2003 15:03:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261678AbTI3TDd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Sep 2003 15:03:33 -0400
Received: from main.gmane.org ([80.91.224.249]:29084 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S261660AbTI3TDb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Sep 2003 15:03:31 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Andreas Schwarz <usenet.2117@andreas-s.net>
Subject: Re: Call traces due to lost IRQ
Date: Tue, 30 Sep 2003 19:03:28 +0000 (UTC)
Message-ID: <slrnbnjksd.3pa.usenet.2117@home.andreas-s.net>
References: <20030930154032.GA795@donald.balu5> <20030930112429.A722@osdlab.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
User-Agent: slrn/0.9.8.0 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Wright wrote:
> * Martin Pitt (martin@piware.de) wrote:
>> Hi!
>> 
>> [1.] Kernel boot yields lost IRQ with some call traces
>
> Can you try the following patch?
>
>===== drivers/acpi/pci_link.c 1.17 vs edited =====

This solved the issue for me.

-- 
AVR-Tutorial, über 350 Links
Forum für AVRGCC und MSPGCC
-> http://www.mikrocontroller.net

