Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265314AbTL0Eaz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Dec 2003 23:30:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265315AbTL0Eaz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Dec 2003 23:30:55 -0500
Received: from obsidian.spiritone.com ([216.99.193.137]:19156 "EHLO
	obsidian.spiritone.com") by vger.kernel.org with ESMTP
	id S265314AbTL0Eay (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Dec 2003 23:30:54 -0500
Date: Fri, 26 Dec 2003 20:30:50 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Calin Szonyi <caszonyi@rdslink.ro>
cc: linux-kernel@vger.kernel.org, kraxel@bytesex.org
Subject: Re: panic in bttv_risc_planar
Message-ID: <3320000.1072499450@[10.10.2.4]>
In-Reply-To: <Pine.LNX.4.53.0312270235570.7966@grinch.ro>
References: <Pine.LNX.4.53.0312262105560.537@grinch.ro> <2850000.1072477728@[10.10.2.4]> <Pine.LNX.4.53.0312270235570.7966@grinch.ro>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dec 26 17:59:08 grinch kernel: Unable to handle kernel paging request at virtual address c4bea00c
Dec 26 17:59:08 grinch kernel:  printing eip:
Dec 26 17:59:08 grinch kernel: c0333f60
...
and yet ...
...
> 0xc0333f63 <bttv_risc_planar+579>:	mov    %eax,(%ecx)
> 0xc0333f65 <bttv_risc_planar+581>:	add    %edx,0x5c(%esp,1)

Mmm. you *sure* nothing else changed? You didn't take out -O2 when you
put in -g or change the config file at all or anything?

M.

