Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317865AbSIISDY>; Mon, 9 Sep 2002 14:03:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317950AbSIISDX>; Mon, 9 Sep 2002 14:03:23 -0400
Received: from dsl-213-023-039-209.arcor-ip.net ([213.23.39.209]:4543 "EHLO
	starship") by vger.kernel.org with ESMTP id <S317865AbSIISDX>;
	Mon, 9 Sep 2002 14:03:23 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: "David S. Miller" <davem@redhat.com>, root@chaos.analogic.com
Subject: Re: Calculating kernel logical address ..
Date: Mon, 9 Sep 2002 19:40:14 +0200
X-Mailer: KMail [version 1.3.2]
Cc: imran.badr@cavium.com, linux-kernel@vger.kernel.org
References: <019d01c25823$8714c460$9e10a8c0@IMRANPC> <Pine.LNX.3.95.1020909132344.17307A-100000@chaos.analogic.com> <20020909.102341.29032821.davem@redhat.com>
In-Reply-To: <20020909.102341.29032821.davem@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17oSWE-0006q9-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 09 September 2002 19:23, David S. Miller wrote:
>    From: "Richard B. Johnson" <root@chaos.analogic.com>
>    Date: Mon, 9 Sep 2002 13:29:42 -0400 (EDT)
>    
>    I think there is a virt_to_bus() macro and its inverse.
> 
> Which is deprecate and not to be used by any new code.
> Use Documentation/DMA-mapping.txt instead.
> 
> If you meant virt_to_phys(), this does not work on arbitrary
> kernel virtual addresses either only direct mapped ones
> (ie. kmalloc() or get_free_page() data).

In this case he starts with a kmalloc, then mmaps it somehow.  Imran,
exactly what code do you use to mmap the kmalloced memory?

-- 
Daniel
