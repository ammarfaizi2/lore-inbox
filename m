Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135395AbREEVJK>; Sat, 5 May 2001 17:09:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135380AbREEVIv>; Sat, 5 May 2001 17:08:51 -0400
Received: from nw175.netaddress.usa.net ([204.68.24.75]:10432 "HELO
	nw175.netaddress.usa.net") by vger.kernel.org with SMTP
	id <S135363AbREEVIs> convert rfc822-to-8bit; Sat, 5 May 2001 17:08:48 -0400
Message-ID: <20010505210847.5930.qmail@nw175.netaddress.usa.net>
Date: 5 May 2001 16:08:47 CDT
From: shreenivasa H V <shreenihv@usa.net>
To: Sam Coles <sam@bcinet.net>
Subject: Re: [Re: Could clock granularity be increased????]
CC: linux-kernel@vger.kernel.org
X-MSMail-Priority: High
X-Priority: 1
X-Mailer: USANET web-mailer (34FM.0700.17C.01)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I though about that. Would it affect other kernel modules which assume the
value of HZ (to be 100)? But for this, I guess increasing the value of HZ to
1000 or so should work. Are u sure it is ok to increase HZ?

Sam Coles <sam@bcinet.net> wrote:
Will editing include/asm/param.h not do the trick?

Sam

On 05 May 2001 12:53:14 -0500, shreenivasa H V wrote:
> Hi,
> 
> Is there any way I could use a clock granularity of less than 10ms if I
need
> to do some hacking of the kernel TCP code? Ideally I would require the
> interval of the order of 10-100 microseconds. 
> thanks,
> shreeni.
> 
> ____________________________________________________________________
> Get free email and a permanent address at http://www.netaddress.com/?N=1
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/


____________________________________________________________________
Get free email and a permanent address at http://www.netaddress.com/?N=1
