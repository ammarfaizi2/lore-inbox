Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129983AbRAFPfR>; Sat, 6 Jan 2001 10:35:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131236AbRAFPe5>; Sat, 6 Jan 2001 10:34:57 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:7947 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129983AbRAFPeg>; Sat, 6 Jan 2001 10:34:36 -0500
Subject: Re: modprobe ipv6 gives -1 usage count was [ramfs problem...]
To: stefan@hello-penguin.com
Date: Sat, 6 Jan 2001 15:35:59 +0000 (GMT)
Cc: viro@math.psu.edu (Alexander Viro), linux-kernel@vger.kernel.org
In-Reply-To: <20010106062448.A968@stefan.sime.com> from "Stefan Traby" at Jan 06, 2001 06:24:48 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14EvNy-0001Aj-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I bet that a fix for the following exists, too: :)
> 
> [0]--(06:19:49)-(root@stefan)-(~)-> lsmod |grep -i ipv6
> [1]--(06:22:33)-(root@stefan)-(~)-> modprobe ipv6
> [0]--(06:22:38)-(root@stefan)-(~)-> lsmod |grep -i ipv6
> ipv6                  117424  -1 
> [0]--(06:22:46)-(root@stefan)-(~)->
> 
> usage count: -1

Not a bug.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
