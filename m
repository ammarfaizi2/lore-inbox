Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263930AbUAITXP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jan 2004 14:23:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264095AbUAITXO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jan 2004 14:23:14 -0500
Received: from tolkor.sgi.com ([198.149.18.6]:54434 "EHLO tolkor.sgi.com")
	by vger.kernel.org with ESMTP id S263930AbUAITXL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jan 2004 14:23:11 -0500
Date: Fri, 9 Jan 2004 09:23:09 -0800
From: Paul Jackson <pj@sgi.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: schwab@suse.de, paulus@samba.org, akpm@osdl.org, joe.korty@ccur.com,
       linux-kernel@vger.kernel.org
Subject: Re: seperator error in __mask_snprintf_len
Message-Id: <20040109092309.42bb6049.pj@sgi.com>
In-Reply-To: <20040109152533.A25396@infradead.org>
References: <20040107165607.GA11483@rudolph.ccur.com>
	<20040107113207.3aab64f5.akpm@osdl.org>
	<20040108051111.4ae36b58.pj@sgi.com>
	<16381.57040.576175.977969@cargo.ozlabs.ibm.com>
	<20040109064619.35c487ec.pj@sgi.com>
	<je1xq9duhc.fsf@sykes.suse.de>
	<20040109152533.A25396@infradead.org>
Organization: SGI
X-Mailer: Sylpheed version 0.8.10claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas wrote:
> S390x is big-endian, too.  IMHO it should rather be in
> include/linux/byteorder, or derived from the macros in there.

ok.

I suspect I will end up agreeing with your byteorder.h suggestion - good.

Chistoph wrote:
> Yes, we'll need it for mips, too.

ok.

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
