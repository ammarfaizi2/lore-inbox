Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265354AbTLHJlo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Dec 2003 04:41:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265357AbTLHJlo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Dec 2003 04:41:44 -0500
Received: from holomorphy.com ([199.26.172.102]:50138 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S265354AbTLHJln (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Dec 2003 04:41:43 -0500
Date: Mon, 8 Dec 2003 01:41:38 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Misha Nasledov <misha@nasledov.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test11 Oops
Message-ID: <20031208094138.GE8039@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Misha Nasledov <misha@nasledov.com>, linux-kernel@vger.kernel.org
References: <20031208032127.GA14638@nasledov.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031208032127.GA14638@nasledov.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 07, 2003 at 07:21:28PM -0800, Misha Nasledov wrote:
> I just encountered an Oops on my IBM ThinkPad T21 with 2.6.0-test11. I
> suspect that it has something to do with my battery being so low that it would
> not even give a reading. I had to copy down the oops and by the time I
> rebooted the machine, it had charged enough and booted successfuly. Here is
> the text of the oops:
> 
> EIP:	0060:[<c0119179>]	Not tainted
> EFLAGS:	00010002
> EIP is at schedule+0xf9/0x590
> eax: 00000001	ebx: c03acc20	ecx: c03acc40	edx: 28b4a89a
> esi: 00000000	edi: cfe38800	ebp: c0425cfc	esp: c0425cb8
> ds: 008b	es: 007b	ss: 0068
> Process swapper (pid: 0, threadinfo=c0424000 task=c03acc20)

What did it say the cause for it was? BUG()? Fault?


-- wli
