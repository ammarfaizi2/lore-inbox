Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268677AbTCDQG5>; Tue, 4 Mar 2003 11:06:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269339AbTCDQG5>; Tue, 4 Mar 2003 11:06:57 -0500
Received: from franka.aracnet.com ([216.99.193.44]:662 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S268677AbTCDQGy>; Tue, 4 Mar 2003 11:06:54 -0500
Date: Tue, 04 Mar 2003 08:17:20 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Anton Blanchard <anton@samba.org>, Sean Neakums <sneakums@zork.net>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: xmms (audio) skipping in 2.5 (not 2.4)
Message-ID: <122390000.1046794639@[10.10.2.4]>
In-Reply-To: <20030304141324.GA12185@krispykreme>
References: <103200000.1046755559@[10.10.2.4]>
 <20030304141324.GA12185@krispykreme>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Anton:
>
> Are you running debian? It likes to nice -10 the X server. Renicing it
> back to 0 fixes my xmms skips with 2.5.

Excellent - that seems to fix it totally. I guess O(1) pays more attention
to nice than 2.4.

> Sean Neakums <sneakums@zork.net> wrote:
>
> You can alter this permanently with 'dpkg-reconfigure xserver-common';
> if you elect not to have /etc/X11/Xwrapper.config managed by debconf,
> simply edit it directly.

Even better ;-)

Thanks,

M.

