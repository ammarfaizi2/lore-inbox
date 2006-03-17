Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750810AbWCQOvQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750810AbWCQOvQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Mar 2006 09:51:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750884AbWCQOvQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Mar 2006 09:51:16 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:7832 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1750810AbWCQOvP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Mar 2006 09:51:15 -0500
Subject: Re: New libata PATA patch for 2.6.16-rc1
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Alistair John Strachan <s0348365@sms.ed.ac.uk>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200603141048.39785.s0348365@sms.ed.ac.uk>
References: <1142262431.25773.25.camel@localhost.localdomain>
	 <200603131713.31411.s0348365@sms.ed.ac.uk>
	 <1142299457.25773.43.camel@localhost.localdomain>
	 <200603141048.39785.s0348365@sms.ed.ac.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 17 Mar 2006 14:57:40 +0000
Message-Id: <1142607460.28614.8.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2006-03-14 at 10:48 +0000, Alistair John Strachan wrote:
> for FILE in *; do dd if="$FILE" of=/dev/null bs=1M; done
> 
> 300,000 interrupts later, still no messages. Anything I can do to isolate this 
> further?

I left the IRQ trap code define enabled in the tree when I did the diff.
Ok thats that one explained

