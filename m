Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282239AbRKWUzn>; Fri, 23 Nov 2001 15:55:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282240AbRKWUzd>; Fri, 23 Nov 2001 15:55:33 -0500
Received: from pc-62-30-67-59-az.blueyonder.co.uk ([62.30.67.59]:22766 "EHLO
	kushida.jlokier.co.uk") by vger.kernel.org with ESMTP
	id <S282239AbRKWUzZ>; Fri, 23 Nov 2001 15:55:25 -0500
Date: Fri, 23 Nov 2001 20:52:35 +0000
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: berthiaume_wayne@emc.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: Multicast Broadcast
Message-ID: <20011123205235.A11439@kushida.jlokier.co.uk>
In-Reply-To: <93F527C91A6ED411AFE10050040665D00241AB03@corpusmx1.us.dg.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <93F527C91A6ED411AFE10050040665D00241AB03@corpusmx1.us.dg.com>; from berthiaume_wayne@emc.com on Wed, Nov 21, 2001 at 03:53:48PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

berthiaume_wayne@emc.com wrote:
> 	I have a cluster that I wish to be able to perform a multicast
> broadcast over two backbones, primary and secondary, simultaneously. The two
> eth's are bound to the same VIP. When I perform the broadcast, it only goes
> out on eth0. 

I have seen this problem when trying to use an NTP server to multicast
to two ethernets.  Unfortunately, NTP's output would only send to one of
the networks (eth0).

I never did find a workaround.

-- Jamie
