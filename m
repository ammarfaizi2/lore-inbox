Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265270AbSKRW2s>; Mon, 18 Nov 2002 17:28:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265114AbSKRW0x>; Mon, 18 Nov 2002 17:26:53 -0500
Received: from gasko.hitnet.RWTH-Aachen.DE ([137.226.181.85]:62737 "EHLO
	moria.gondor.com") by vger.kernel.org with ESMTP id <S265270AbSKRW03>;
	Mon, 18 Nov 2002 17:26:29 -0500
Date: Mon, 18 Nov 2002 23:33:30 +0100
From: Jan Niehusmann <jan@gondor.com>
To: Rashmi Agrawal <rashmi.agrawal@wipro.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Failover in NFS
Message-ID: <20021118223330.GA751@gondor.com>
References: <3DD90197.4DDEEE61@wipro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DD90197.4DDEEE61@wipro.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 18, 2002 at 08:34:55PM +0530, Rashmi Agrawal wrote:
> 2. If nfs server node crashes, I need to failover to another node
> wherein I need to have access
> to the lock state of the previous server and I need to tell the clients
> that the IP address of the
> nfs server node has changed. IS IT POSSIBLE or what can be done to
> implement it?

Have a look at drbd, http://www.complang.tuwien.ac.at/reisner/drbd/.
Using that, together with heartbeat, you can build a nice failover nfs
server.

Jan

