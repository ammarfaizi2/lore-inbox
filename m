Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266194AbUAVKfr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jan 2004 05:35:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266207AbUAVKfr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jan 2004 05:35:47 -0500
Received: from aun.it.uu.se ([130.238.12.36]:51184 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S266194AbUAVKea (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jan 2004 05:34:30 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16399.42771.62274.415044@alkaid.it.uu.se>
Date: Thu, 22 Jan 2004 11:33:55 +0100
From: Mikael Pettersson <mikpe@csd.uu.se>
To: Boszormenyi Zoltan <zboszor@freemail.hu>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Linux-2.6.1-mm4/5 dies booting on an Athlon64
In-Reply-To: <400F88B1.1090002@freemail.hu>
References: <400F88B1.1090002@freemail.hu>
X-Mailer: VM 7.17 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Boszormenyi Zoltan writes:
 > Hi,
 > 
 > mainboard is MSI K8T Neo, Athlon64 3200+.
 > It does not boot successfully without the "nolapic"
 > option. "noapic" does not make any difference, "nolapic" does.
 > Kernel is compiled on a 32bit Fedora,
 > K7/Athlon and Hammer/Opteron/Athlon64
 > are selected under CPU support.

1. "does not boot successfully" is extremely vague.
   Please supply a boot log or decoded kernel oops.

2. Does this also occur with 2.6.1 or 2.6.2-rc1?
   If so, what was the last standard 2.6 kernel that worked?

3. Does 2.4.25-pre6 work?

4. Try a minimal .config w/o any non-essential features.
   (Where non-essential mean anything not needed to boot
   and get to a login prompt.)
