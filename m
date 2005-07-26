Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262423AbVG0ABW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262423AbVG0ABW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Jul 2005 20:01:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262297AbVGZX7H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Jul 2005 19:59:07 -0400
Received: from waste.org ([216.27.176.166]:25045 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S262332AbVGZX6l (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Jul 2005 19:58:41 -0400
Date: Tue, 26 Jul 2005 16:58:24 -0700
From: Matt Mackall <mpm@selenic.com>
To: "David S. Miller" <davem@davemloft.net>
Cc: bunk@stusta.de, jgarzik@pobox.com, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] NETCONSOLE must depend on INET
Message-ID: <20050726235824.GN12006@waste.org>
References: <20050719182919.GA5531@stusta.de> <20050719.140104.68160812.davem@davemloft.net> <20050726232043.GB7425@waste.org> <20050726.163202.119887768.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050726.163202.119887768.davem@davemloft.net>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 26, 2005 at 04:32:02PM -0700, David S. Miller wrote:
> From: Matt Mackall <mpm@selenic.com>
> Date: Tue, 26 Jul 2005 16:20:43 -0700
> 
> > This problem also exists in PKTGEN. And this fix is incorrect as
> > neither is dependent on the IP part of the networking stack in any
> > substantive way. The right fix is to make inet_aton available outside
> > of CONFIG_INET (preferred) or making private copies of inet_aton.
> 
> Adrian posted a fix, you whine, that's why Adrian's fix
> went in :-)

Adrian's fix is the moral equivalent of throwing in a cast to shut up
a compiler warning for a legitimate bug.
 
> More seriously, please submit a version of whatever you
> believe to be the more correct fix so it can be reviewed
> and integrated.

Do you have a preferred location to put this function or
shall I invent one?

-- 
Mathematics is the supreme nostalgia of our time.
