Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262772AbTLGGz7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Dec 2003 01:55:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262925AbTLGGz7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Dec 2003 01:55:59 -0500
Received: from holomorphy.com ([199.26.172.102]:12504 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S262772AbTLGGz6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Dec 2003 01:55:58 -0500
Date: Sat, 6 Dec 2003 22:55:38 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Alex Davis <alex14641@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.23 hard lock, 100% reproducible.
Message-ID: <20031207065538.GT8039@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Alex Davis <alex14641@yahoo.com>, linux-kernel@vger.kernel.org
References: <20031207065017.48483.qmail@web40506.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031207065017.48483.qmail@web40506.mail.yahoo.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 06, 2003 at 10:50:17PM -0800, Alex Davis wrote:
> Unable to handle kernel NULL pointer
> dereference at virtual address: 00000000
>  printing eip:
> c02363dd
> *pde=00000000
> Oops: 0000
> CPU: 0
> EIP: 0010:[<c02363d>]  Not tainted
> EFLAGS: 00010217
> eax: 00000006   ebx: 00000000  ecx: 7a01a8c0   ecx: c700b2a0
> esi: c0299ce0   edi: 000001b7  ebp: c0299d94   esp: c0299c54
> ds: 0018  es: 0018  ss: 0018
> process: swapper (pid: 0, stackpage = c0299000)
> Other than that, nothing.  Is there a patch out there 
> that will simply make 2.4.22 secure?  Things run great
> on that kernel. 

Compile your kernel with debug symbols and use addr2line on that EIP.


-- wli
