Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263171AbUEQXpI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263171AbUEQXpI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 May 2004 19:45:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263174AbUEQXpI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 May 2004 19:45:08 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:64939 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263171AbUEQXmN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 May 2004 19:42:13 -0400
Message-ID: <40A94DC4.4070206@pobox.com>
Date: Mon, 17 May 2004 19:41:56 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Russell King <rmk+lkml@arm.linux.org.uk>
CC: Andrew Morton <akpm@osdl.org>, Robert.Picco@hp.com,
       linux-kernel@vger.kernel.org, venkatesh.pallipadi@intel.com
Subject: Re: [PATCH] HPET driver
References: <40A3F805.5090804@hp.com> <40A40204.1060509@pobox.com> <40A93DA5.4020701@hp.com> <20040517160508.63e1ddf0.akpm@osdl.org> <20040517161212.659746db.akpm@osdl.org> <40A94857.9030507@pobox.com> <20040518002528.B26439@flint.arm.linux.org.uk>
In-Reply-To: <20040518002528.B26439@flint.arm.linux.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King wrote:
> On Mon, May 17, 2004 at 07:18:47PM -0400, Jeff Garzik wrote:
> 
>>Seems sane, though I wonder about two things:
>>
>>* better home is probably asm-generic
> 
> 
> hmm, I wonder about endian issues tho (and please remember that ARM can
> be either BE or LE depending on the machine we're building for...)


As long as writeq() is implemented wholly in terms of writel(), that's 
fine...

	Jeff



