Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279871AbRJ3E5k>; Mon, 29 Oct 2001 23:57:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279869AbRJ3E5U>; Mon, 29 Oct 2001 23:57:20 -0500
Received: from anime.net ([63.172.78.150]:6672 "EHLO anime.net")
	by vger.kernel.org with ESMTP id <S279868AbRJ3E5O>;
	Mon, 29 Oct 2001 23:57:14 -0500
Date: Mon, 29 Oct 2001 20:57:36 -0800 (PST)
From: Dan Hollis <goemon@anime.net>
To: Jonathan Lundell <jlundell@pobox.com>
cc: "H. Peter Anvin" <hpa@zytor.com>, <linux-kernel@vger.kernel.org>
Subject: Re: Ethernet NIC dual homing
In-Reply-To: <p05100309b803cdfa4552@[10.128.7.49]>
Message-ID: <Pine.LNX.4.30.0110292056400.13240-100000@anime.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Oct 2001, Jonathan Lundell wrote:
> But what I meant was bonding's use of ARP to determine whether the
> connection is good (or rather, bad, even when the link is up), when
> the connection is routed via level 3. Seems to me you'd need a level
> 3 protocol (say ICMP) rather than ARP.

bonding isn't for layer 3. it's layer 2. layer 3 you use equal cost
multipath or other method for load balancing.

-Dan
-- 
[-] Omae no subete no kichi wa ore no mono da. [-]

