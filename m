Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261311AbTJWR2X (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Oct 2003 13:28:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261723AbTJWR2X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Oct 2003 13:28:23 -0400
Received: from rrcs-central-24-106-129-221.biz.rr.com ([24.106.129.221]:16807
	"EHLO mailbox.nortoncafe.dnsalias.org") by vger.kernel.org with ESMTP
	id S261311AbTJWR2W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Oct 2003 13:28:22 -0400
From: Rob <rpc@cafe4111.org>
Reply-To: rpc@cafe4111.org
Organization: Cafe
To: "Joseph D. Wagner" <theman@josephdwagner.info>,
       linux-kernel@vger.kernel.org
Subject: Re: FEATURE REQUEST: Specific Processor Optimizations on x86 Architecture
Date: Thu, 23 Oct 2003 13:26:19 -0400
User-Agent: KMail/1.5.4
References: <200310221855.15925.theman@josephdwagner.info>
In-Reply-To: <200310221855.15925.theman@josephdwagner.info>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200310231326.20159.rpc@cafe4111.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I don't want to have to hand edit the makefiles just to optimize my kernel.
> I think this change is simple enough to do, and would allow kernel
> developers the option of processor-specific optimizations in the future.

yea, it's simple enough to do.
/usr/src/linux-2.4.22/Makefile, line 94. Add "-march *" as you wish.
Now all that talent was wasted on this, all this time... for something so 
small, only that you want that simple fix made available for everyone. DIY 
like the rest of the people who are already building their own kernel(!!!)

look: every time i build, i have to uncomment "export install_path=/boot".
go figure out why i never asked them to change it for me, and stop biting the 
hand that feeds.

-- 
Don't be fooled... if you can help it.
