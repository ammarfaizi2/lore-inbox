Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262687AbSI1C3V>; Fri, 27 Sep 2002 22:29:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262688AbSI1C3V>; Fri, 27 Sep 2002 22:29:21 -0400
Received: from ns.suse.de ([213.95.15.193]:32018 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S262687AbSI1C3U>;
	Fri, 27 Sep 2002 22:29:20 -0400
Date: Sat, 28 Sep 2002 04:34:40 +0200
From: Andi Kleen <ak@suse.de>
To: kuznet@ms2.inr.ac.ru
Cc: "David S. Miller" <davem@redhat.com>, yoshfuji@linux-ipv6.org,
       linux-kernel@vger.kernel.org, netdev@oss.sgi.com, usagi@linux-ipv6.org
Subject: Re: [PATCH] IPv6: Improvement of Source Address Selection
Message-ID: <20020928043440.A1435@wotan.suse.de>
References: <20020927.182833.66704359.davem@redhat.com> <200209280228.GAA02633@sex.inr.ac.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200209280228.GAA02633@sex.inr.ac.ru>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 28, 2002 at 06:28:29AM +0400, A.N.Kuznetsov wrote:
> Hello!
> 
> > Otherwise I have no problems with the patch, Alexey?
> 
> I have... The implementation is bad. Source address must be retieved
> from route, not running this elephant function each packet.

So it just needs to be moved into ip_route_output, right ? 

-Andi
