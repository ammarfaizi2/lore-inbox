Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132500AbRDKAWM>; Tue, 10 Apr 2001 20:22:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132496AbRDKAWA>; Tue, 10 Apr 2001 20:22:00 -0400
Received: from ns.suse.de ([213.95.15.193]:19724 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S132500AbRDKAVt>;
	Tue, 10 Apr 2001 20:21:49 -0400
Date: Wed, 11 Apr 2001 02:21:42 +0200
From: Andi Kleen <ak@suse.de>
To: Dave <daveo@osdn.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: bizarre TCP behavior
Message-ID: <20010411022142.A28926@gruyere.muc.suse.de>
In-Reply-To: <Pine.LNX.4.33.0104101809190.1468-100000@meatloop.andover.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.33.0104101809190.1468-100000@meatloop.andover.net>; from daveo@osdn.com on Tue, Apr 10, 2001 at 06:24:46PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 10, 2001 at 06:24:46PM -0400, Dave wrote:
> 
> I am having a very strange problem in linux 2.4 kernels.  I have not set
> any iptables rules at all, and there is no firewall blocking any of my
> outgoing traffic.  At what seems like random selection, I can not connect
> to IP's yet I can get ping replies from them.  Most IP's reply just fine,
> but certain ones fail to send even an ACK.  This problem disappears when I
> boot into 2.2.  Here is a brief example of what I am talking about:

Try echo 0 > /proc/sys/net/ipv4/tcp_ecn
If it helps complain to the sites that their firewall is broken.


-Andi
