Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266643AbUH1UhT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266643AbUH1UhT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Aug 2004 16:37:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266646AbUH1UgG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Aug 2004 16:36:06 -0400
Received: from the-village.bc.nu ([81.2.110.252]:7808 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S267994AbUH1URs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Aug 2004 16:17:48 -0400
Subject: Re: SMP cpu deep sleep
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Bill Davidsen <davidsen@tmr.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <cgdn8t$l27$1@gatekeeper.tmr.com>
References: <1092989207.18275.14.camel@linux.local>
	 <pan.2004.08.20.16.44.39.888193@austin.ibm.com>
	 <cgdn8t$l27$1@gatekeeper.tmr.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1093354219.2810.25.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sat, 28 Aug 2004 20:15:45 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2004-08-23 at 22:30, Bill Davidsen wrote:
> For power saving, HLT is hard to beat ;-) You note HLT as if there was 
> some good reason not to use it...

On a large number of processors HLT has only small effect because the
processor still has to do bus arbitration , still has large leakage
currents and has other circuitry running. The PowerNow stuff seems to
make a much bigger difference but has limits to how low you can go.

