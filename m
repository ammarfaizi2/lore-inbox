Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261778AbVEQQHY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261778AbVEQQHY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 May 2005 12:07:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261807AbVEQQFp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 May 2005 12:05:45 -0400
Received: from titan.genwebhost.com ([209.9.226.66]:47318 "EHLO
	titan.genwebhost.com") by vger.kernel.org with ESMTP
	id S261738AbVEQQCo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 May 2005 12:02:44 -0400
Date: Tue, 17 May 2005 09:02:37 -0700
From: randy_dunlap <rdunlap@xenotime.net>
To: Yves Crespin <crespin.quartz@wanadoo.fr>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Unable to handle kernel NULL pointer dereference at virtual
 address 00000009
Message-Id: <20050517090237.443ac395.rdunlap@xenotime.net>
In-Reply-To: <428996D5.9090309@wanadoo.fr>
References: <428996D5.9090309@wanadoo.fr>
Organization: YPO4
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - titan.genwebhost.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - xenotime.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 May 2005 09:01:41 +0200 Yves Crespin wrote:

| I have a lot of trouble on machines with USB disk.
| Some time process which access to this disk are blocked and shutdown command don't stop the system (unable to remove usb-uhci module).
| 
| I'm using 2.4.26 kernel
| 
| Do you need more information ?

Unless someone recognizes this as a known problem, it would help to
have a proper bug report, as described in
linux/REPORTING-BUGS .

Thanks,
~Randy


| To solve my problem, is it possible to take usb module from 2.4.30 ?
| 
| Thanks,
| 
|  Yves
| 
| <6>usb.c: USB disconnect on device 00:07.3-0 address 1
| <1>Unable to handle kernel NULL pointer dereference at virtual address 00000009
| <4> printing eip:
| <4>d0d04bf2
| <1>*pde = 00000000
| <4>Oops: 0000
| <4>CPU:    0
| <4>EIP:    0010:[<d0d04bf2>]    Not tainted
| <4>EFLAGS: 00010246
| <4>eax: ceb9da00   ebx: 00000001   ecx: fffffffd   edx: d0d08bec
| <4>esi: 00000000   edi: c84200fb   ebp: 00000000   esp: cd4e5ef8
| <4>ds: 0018   es: 0018   ss: 0018
| <4>Process maitre (pid: 686, stackpage=cd4e5000)
| <4>Stack: 00000000 ce5fd200 c8421f00 00000000 00000000 d0d04e5c 00000000 c84200d4 
| <4>       c8421f00 ceb9da00 00000001 c8421f00 c8420071 c8420000 ce5fd200 d0d04fa9 
| <4>       c8420071 c8421f00 ce5fd200 ce72d144 000000dd cdf8c370 d0d09d80 00000000 
| <4>Call Trace:    [<d0d04e5c>] [<d0d04fa9>] [<d0d09d80>] [<d0d051a6>] [<c0131c16>]
| <4>  [<c0108843>]
| <4>
| <4>Code: 3b 73 08 7d 23 3b 7c 24 20 77 94 56 53 8b 54 24 28 52 57 8b 
| <4> <4>usb-uhci.c: interrupt, status 20, frame# 0
| <6>usb.c: USB bus 2 deregistered
