Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132462AbRDJW4j>; Tue, 10 Apr 2001 18:56:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132468AbRDJW43>; Tue, 10 Apr 2001 18:56:29 -0400
Received: from [63.95.87.168] ([63.95.87.168]:14351 "HELO xi.linuxpower.cx")
	by vger.kernel.org with SMTP id <S132462AbRDJW4T>;
	Tue, 10 Apr 2001 18:56:19 -0400
Date: Tue, 10 Apr 2001 18:56:18 -0400
From: Gregory Maxwell <greg@linuxpower.cx>
To: Dave <daveo@osdn.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: bizarre TCP behavior
Message-ID: <20010410185618.C14377@xi.linuxpower.cx>
In-Reply-To: <Pine.LNX.4.33.0104101809190.1468-100000@meatloop.andover.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.8i
In-Reply-To: <Pine.LNX.4.33.0104101809190.1468-100000@meatloop.andover.net>; from daveo@osdn.com on Tue, Apr 10, 2001 at 06:24:46PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 10, 2001 at 06:24:46PM -0400, Dave wrote:
> I am having a very strange problem in linux 2.4 kernels.  I have not set
> any iptables rules at all, and there is no firewall blocking any of my
> outgoing traffic.  At what seems like random selection, I can not connect
> to IP's yet I can get ping replies from them.  Most IP's reply just fine,
> but certain ones fail to send even an ACK.  This problem disappears when I
> boot into 2.2.  Here is a brief example of what I am talking about:

echo -n 0 > /proc/sys/net/ipv4/tcp_ecn

Fix it?

If so, please tell the sites your are trying to connect to to upgrade their
$I#$@#%@(%)@%$ firewall and/or loadbalencer (usually Localdirector or PIX).

