Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267416AbUI0WvN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267416AbUI0WvN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Sep 2004 18:51:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267415AbUI0WvN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Sep 2004 18:51:13 -0400
Received: from sol.linkinnovations.com ([203.94.173.142]:12160 "EHLO
	theirongiant.lochness.weebeastie.net") by vger.kernel.org with ESMTP
	id S267411AbUI0WvG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Sep 2004 18:51:06 -0400
Date: Tue, 28 Sep 2004 08:49:57 +1000
From: CaT <cat@zip.com.au>
To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
Cc: linux-kernel@vger.kernel.org, davem@davemloft.net, jgarzik@pobox.com,
       linux-net@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: strange network slowness in 2.6 unless pingflooding
Message-ID: <20040927224957.GA1043@zip.com.au>
References: <20040927090342.GA1794@zip.com.au> <41587A26.6020606@conectiva.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41587A26.6020606@conectiva.com.br>
Organisation: Furball Inc.
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 27, 2004 at 05:37:58PM -0300, Arnaldo Carvalho de Melo wrote:
> CaT wrote:
> >Hi,
> >
> >This is still happening. I ran the same set of tests on a totally
> >different network, with my xircom  realport ethernet card (tulip
> >driver - 16bit) and from linux to linux and windows to linux. Scrolling
> >through a message in mutt eventually slows down and if I lift my finger
> >off the enter key whilst it's slow the scrolling keeps going, as if it
> >was all bufferd. If I do a pingflood (ping -f) from a machine to my
> >laptop it's all fine.
> >
> >I am also now running 2.6.9-rc1-mm4.
> 
> Have you tried FAQ:
> 
> echo 0 > /proc/sys/net/ipv4/tcp_window_scaling

It does not help. Same problem as before.

-- 
    Red herrings strewn hither and yon.
