Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262663AbTDUXNF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Apr 2003 19:13:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262675AbTDUXNF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Apr 2003 19:13:05 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:39691 "EHLO
	www.home.local") by vger.kernel.org with ESMTP id S262663AbTDUXNE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Apr 2003 19:13:04 -0400
Date: Tue, 22 Apr 2003 01:24:49 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Ben Greear <greearb@candelatech.com>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.21-rc1
Message-ID: <20030421232449.GD554@alpha.home.local>
References: <Pine.LNX.4.53L.0304211545580.12940@freak.distro.conectiva> <3EA47596.9060901@candelatech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3EA47596.9060901@candelatech.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 21, 2003 at 03:49:58PM -0700, Ben Greear wrote:
> Marcelo Tosatti wrote:
> >Here goes the first candidate for 2.4.21.
> >
> >Please test it extensively.
> >
> ><green@linuxhacker.ru>:
> >  o [VLAN]: Fix memory leak in procfs handling
> 
> I looked at the diff on kernel.org to peruse this change, and did not see 
> any changes to any vlan files??

Oleg added a kfree(page) at net/8021q/vlanproc.c:256

Cheers,
Willy
