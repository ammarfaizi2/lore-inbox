Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135778AbRDTRoF>; Fri, 20 Apr 2001 13:44:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135803AbRDTRnz>; Fri, 20 Apr 2001 13:43:55 -0400
Received: from [63.95.87.168] ([63.95.87.168]:25100 "HELO xi.linuxpower.cx")
	by vger.kernel.org with SMTP id <S135778AbRDTRni>;
	Fri, 20 Apr 2001 13:43:38 -0400
Date: Fri, 20 Apr 2001 13:43:37 -0400
From: Gregory Maxwell <greg@linuxpower.cx>
To: "Carlos Parada (EST)" <est-c-parada@ptinovacao.pt>
Cc: linux-kernel@vger.kernel.org, 6bone@ISI.EDU
Subject: Re: IPv6 routing
Message-ID: <20010420134337.E13249@xi.linuxpower.cx>
In-Reply-To: <25CCC6566D01D411885B00A024559FB701486CC3@EXCHANGE_GERAL>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.8i
In-Reply-To: <25CCC6566D01D411885B00A024559FB701486CC3@EXCHANGE_GERAL>; from est-c-parada@ptinovacao.pt on Fri, Apr 20, 2001 at 06:37:05PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 20, 2001 at 06:37:05PM +0100, Carlos Parada (EST) wrote:
> Hi,
> 
> I'm trying to set up an IPv6 network in Linux kernel 2.4.0-test10. In this
> network I'm using just 3 boxs and I would use static routes.
>  _____        _____          _____
> |   A   |____|    B   | ____|   C   |     
> |_____|       |_____|        |_____|
> 
> The problem is that I cannot access from A to C machines and vice-versa. But
> the routing problem is a bit strange because, A can access to the two
> interfaces of B, even to B interface in the same network as C. Also C can

echo -n 1 > /proc/sys/net/ipv6/conf/all/forwarding
