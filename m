Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265310AbTL0E2m (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Dec 2003 23:28:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265311AbTL0E2m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Dec 2003 23:28:42 -0500
Received: from citrine.spiritone.com ([216.99.193.133]:52128 "EHLO
	citrine.spiritone.com") by vger.kernel.org with ESMTP
	id S265310AbTL0E2l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Dec 2003 23:28:41 -0500
Date: Fri, 26 Dec 2003 20:28:37 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Calin Szonyi <caszonyi@rdslink.ro>
cc: linux-kernel@vger.kernel.org, kraxel@bytesex.org
Subject: Re: panic in bttv_risc_planar
Message-ID: <2890000.1072499316@[10.10.2.4]>
In-Reply-To: <Pine.LNX.4.53.0312270235570.7966@grinch.ro>
References: <Pine.LNX.4.53.0312262105560.537@grinch.ro> <2850000.1072477728@[10.10.2.4]> <Pine.LNX.4.53.0312270235570.7966@grinch.ro>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I'm not familiar with addr2line :-(
> I was trying this command line(the result is below):
>  //usr/src/linux-2.6.0 $ addr2line -e ./vmlinux 320
> ??:0
> 
> I obtain the same result if i use 0x140 instead of 320 (320 is decimal
> for 0x140)

"addr2line -e ./vmlinux 0xc0333f60" if I recall correctly
(the full address, not the offset within the function). Might not need
the 0x in front.

But I think maybe Linus already told you what it is ;-)

M.

