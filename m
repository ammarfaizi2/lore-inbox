Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131076AbQKTFvO>; Mon, 20 Nov 2000 00:51:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131129AbQKTFvE>; Mon, 20 Nov 2000 00:51:04 -0500
Received: from mx2.core.com ([208.40.40.41]:13492 "EHLO smtp-2.core.com")
	by vger.kernel.org with ESMTP id <S131076AbQKTFuv>;
	Mon, 20 Nov 2000 00:50:51 -0500
Message-ID: <3A18B4B8.37508FA0@megsinet.net>
Date: Sun, 19 Nov 2000 23:20:56 -0600
From: "M.H.VanLeeuwen" <vanl@megsinet.net>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0-test11 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: David Ford <david@linux.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: run level 1, login takes too long, 2.4.X vs. 2.2.X
In-Reply-To: <3A18573B.E65CA88A@megsinet.net> <3A18AA1F.FAC00978@linux.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

Yup, I know rpc.portmap isn't running, the point is that it wasn't running on either
2.2.17 or 2.4.X.  Isn't run level 1 supposed to only be the bare minimum of running
processes, a few kernel processes, init and getty.  No network services...

What's changed in the kernel to elicit this behavior?

Is there a better "faster" way to get root access at run level 1 w/o login & passwd
on 2.4.X?

No it's not an everyday occurance, but I was impatiently thinking the sytem had
locked up and rebooted a couple of times, so it got me wondering why 2.2.X and
2.4.X differ in this basic behavior. 

Martin

David Ford wrote:
> 
> rpc.portmap isn't running, your login configuration/nss requires yp or something provided ans an RPC.
> 
> -d
> 
> "M.H.VanLeeuwen" wrote:
> 
> > I had occasion to "telinit 1" today and found that it took a long time
> > to login after root passwd was entered.  this doesn't happen with 2.2.X
> > kernels.
> >
> > Is this to be expected with the 2.4 series kernels? or a bug?
> >
> > Martin
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
