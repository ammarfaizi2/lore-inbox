Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264386AbTDPOdP (for <rfc822;willy@w.ods.org>); Wed, 16 Apr 2003 10:33:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264389AbTDPOdP 
	(for <rfc822;linux-kernel-outgoing>);
	Wed, 16 Apr 2003 10:33:15 -0400
Received: from pizda.ninka.net ([216.101.162.242]:43141 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S264386AbTDPOdO 
	(for <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Apr 2003 10:33:14 -0400
Date: Wed, 16 Apr 2003 07:38:14 -0700 (PDT)
Message-Id: <20030416.073814.124147956.davem@redhat.com>
To: ak@muc.de
Cc: akpm@digeo.com, linux-kernel@vger.kernel.org, anton@samba.org,
       schwidefsky@de.ibm.com, davidm@hpl.hp.com, matthew@wil.cx,
       ralf@linux-mips.org, rth@redhat.com
Subject: Re: Reduce struct page by 8 bytes on 64bit
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20030416144312.GA2327@averell>
References: <20030416140715.GA2159@averell>
	<20030416.072638.65480350.davem@redhat.com>
	<20030416144312.GA2327@averell>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Andi Kleen <ak@muc.de>
   Date: Wed, 16 Apr 2003 16:43:12 +0200
   
   On sparc64. But is that true too for all other 64bit architectures supported?
   
   e.g. How about PA-RISC? (always seems to do things differently)
   
It cannot require more than the existing API requires, which is
"unsigned long *bitmask", ie. anything equivalent in behavior to an
unsigned long pointer is good enough.
