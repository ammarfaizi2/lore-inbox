Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750874AbWEVOvG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750874AbWEVOvG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 May 2006 10:51:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750891AbWEVOvG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 May 2006 10:51:06 -0400
Received: from mx1.suse.de ([195.135.220.2]:3756 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750874AbWEVOvF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 May 2006 10:51:05 -0400
From: Andi Kleen <ak@suse.de>
To: "Brown, Len" <len.brown@intel.com>
Subject: Re: APIC error on CPUx
Date: Mon, 22 May 2006 16:50:59 +0200
User-Agent: KMail/1.9.1
Cc: "Jan Engelhardt" <jengelh@linux01.gwdg.de>,
       "Vladimir Dvorak" <dvorakv@vdsoft.org>, linux-kernel@vger.kernel.org
References: <CFF307C98FEABE47A452B27C06B85BB681D44D@hdsmsx411.amr.corp.intel.com>
In-Reply-To: <CFF307C98FEABE47A452B27C06B85BB681D44D@hdsmsx411.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605221651.00063.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> "noapic" is a perfectly reasonable thing to use if you don't
> have a lot of interrupt sources and there is no more sharing
> in PIC mode than IOAPIC mode.

It makes interrupt handling much slower. The PIC accesses can be > 50% 
of the interrupt handling cost.

Of course that tends to hide some bugs.

-Andi
