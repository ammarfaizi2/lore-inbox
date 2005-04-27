Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262067AbVD0W5e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262067AbVD0W5e (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Apr 2005 18:57:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262072AbVD0W5e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Apr 2005 18:57:34 -0400
Received: from smtpout.mac.com ([17.250.248.89]:50113 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S262067AbVD0W50 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Apr 2005 18:57:26 -0400
In-Reply-To: <20050426061011.GA8527@codeblau.de>
References: <20050311202122.GA13205@fefe.de> <20050311173308.7a076e8f.akpm@osdl.org> <20050324.205902.119922975.yoshfuji@linux-ipv6.org> <20050425195736.GB3123@codeblau.de> <Pine.LNX.4.61.0504252359580.4921@netcore.fi> <20050426061011.GA8527@codeblau.de>
Mime-Version: 1.0 (Apple Message framework v619.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <d3c101b00bd9573e30aa843e2335439e@mac.com>
Content-Transfer-Encoding: 7bit
Cc: Pekka Savola <pekkas@netcore.fi>, netdev@oss.sgi.com,
       "YOSHIFUJI Hideaki / ?$B5HF#1QL@" <yoshfuji@linux-ipv6.org>,
       linux-kernel@vger.kernel.org
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: IPv6 has trouble assigning an interface
Date: Wed, 27 Apr 2005 18:57:05 -0400
To: Felix von Leitner <felix-linuxkernel@fefe.de>
X-Mailer: Apple Mail (2.619.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Apr 26, 2005, at 02:10, Felix von Leitner wrote:
> OK for unicast. But multicast?  I expected link-local multicast
> to send on _all_ interfaces if I don't specify one.

This statement makes no sense.  "link-local ... on all interfaces".
Isn't "link-local" supposed to mean that the address is unique and
available only on that interface (ethernet segment)?  It's possible
to get the _same_ link-local address on multiple ethernet segments,
so in that case, where would you send the packet???  When you send
link-local packets, you must specify the link to which it is local.

Cheers,
Kyle Moffett

-----BEGIN GEEK CODE BLOCK-----
Version: 3.12
GCM/CS/IT/U d- s++: a18 C++++>$ UB/L/X/*++++(+)>$ P+++(++++)>$
L++++(+++) E W++(+) N+++(++) o? K? w--- O? M++ V? PS+() PE+(-) Y+
PGP+++ t+(+++) 5 X R? tv-(--) b++++(++) DI+ D+ G e->++++$ h!*()>++$ r  
!y?(-)
------END GEEK CODE BLOCK------


