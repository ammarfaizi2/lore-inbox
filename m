Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293668AbSCKKVa>; Mon, 11 Mar 2002 05:21:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293669AbSCKKVV>; Mon, 11 Mar 2002 05:21:21 -0500
Received: from boden.synopsys.com ([204.176.20.19]:29594 "HELO
	boden.synopsys.com") by vger.kernel.org with SMTP
	id <S293668AbSCKKVG>; Mon, 11 Mar 2002 05:21:06 -0500
Date: Mon, 11 Mar 2002 11:20:46 +0100
From: Alex Riesen <Alexander.Riesen@synopsys.com>
To: Oskar Liljeblad <oskar@osk.mine.nu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: directory notifications lost after fork?
Message-ID: <20020311112046.A1368@riesen-pc.gr05.synopsys.com>
Reply-To: Alexander.Riesen@synopsys.com
Mail-Followup-To: Oskar Liljeblad <oskar@osk.mine.nu>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20020310210802.GA1695@oskar> <20020311085006.GA1402@oskar>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020311085006.GA1402@oskar>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 11, 2002 at 09:50:06AM +0100, Oskar Liljeblad wrote:
> On Sunday, March 10, 2002 at 22:02, usel wrote:
> > The code snipper demonstrates what I consider a bug in the
> > dnotify facilities in the kernel. After a fork, all registered
> > notifications are lost in the process where they originally
> > where registered (the parent process). [..]
> 
> FWIW, as long as you keep the child alive after fork the
> notifications are not lost. Also the same effect when you
> keep the parent(s) alive and decide to receive notification
> in the newly created process instead.
What process are the notifications sent, in this case?
IMHO, only the parent can catch them, as fcntl called in the parent
only.

Anyway, strange effect.



> 
> Oskar Liljeblad (oskar@osk.mine.nu)
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
