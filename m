Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264331AbTLZW3B (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Dec 2003 17:29:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264339AbTLZW3B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Dec 2003 17:29:01 -0500
Received: from citrine.spiritone.com ([216.99.193.133]:59823 "EHLO
	citrine.spiritone.com") by vger.kernel.org with ESMTP
	id S264331AbTLZW25 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Dec 2003 17:28:57 -0500
Date: Fri, 26 Dec 2003 14:28:49 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Calin Szonyi <caszonyi@rdslink.ro>, linux-kernel@vger.kernel.org
cc: kraxel@bytesex.org
Subject: Re: panic in bttv_risc_planar
Message-ID: <2850000.1072477728@[10.10.2.4]>
In-Reply-To: <Pine.LNX.4.53.0312262105560.537@grinch.ro>
References: <Pine.LNX.4.53.0312262105560.537@grinch.ro>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Dec 26 17:59:08 grinch kernel: EIP is at bttv_risc_planar+0x140/0x2c0

If you could take the vmlinux binary and do "gdb vmlinux", then
"disassemble bttv_risc_planar" and post all the output, that'd help.

Or ideally, recompile with -g, and use addr2line to find out exactly
what it was.

M.

