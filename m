Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313799AbSDPSEs>; Tue, 16 Apr 2002 14:04:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313800AbSDPSEr>; Tue, 16 Apr 2002 14:04:47 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:65031 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S313799AbSDPSEq>; Tue, 16 Apr 2002 14:04:46 -0400
Date: Tue, 16 Apr 2002 11:03:06 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: "David S. Miller" <davem@redhat.com>
cc: <haveblue@us.ibm.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fix ips driver compile problems
In-Reply-To: <20020416.104921.95902105.davem@redhat.com>
Message-ID: <Pine.LNX.4.33.0204161059070.1340-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 16 Apr 2002, David S. Miller wrote:
> 
>       This patch has been floating inside IBM for a bit, but it appears 
>    that no one passed it back up to you, yet.  I don't know who wrote it, 
>    but it applies to 2.5.8 and the ServeRAID driver works just fine with it 
>    applied.  Without it, the driver fails to compile.
> 
> Alan commented today on this list why these changes are not
> acceptable.

Quite frankly, since after several months of being broken, nobody has
stepped up to actually fix it, I am most definitely going to accept the
band-aid solutions to SCSI drivers that will thus only work on x86.

"Not acceptable" is when broken drivers means that people can't test the 
features they _care_ about. Apparently nobody seems to care about the SCSI 
driver itself..

		Linus

