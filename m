Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313137AbSDYPaH>; Thu, 25 Apr 2002 11:30:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313167AbSDYPaG>; Thu, 25 Apr 2002 11:30:06 -0400
Received: from mark.mielke.cc ([216.209.85.42]:8975 "EHLO mark.mielke.cc")
	by vger.kernel.org with ESMTP id <S313137AbSDYPaF>;
	Thu, 25 Apr 2002 11:30:05 -0400
Date: Thu, 25 Apr 2002 11:24:35 -0400
From: Mark Mielke <mark@mark.mielke.cc>
To: "Richard B. Johnson" <root@chaos.analogic.com>
Cc: rpm <rajendra.mishra@timesys.com>,
        Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>, Nikita@Namesys.COM,
        Andrey Ulanov <drey@rt.mipt.ru>, linux-kernel@vger.kernel.org
Subject: Re: FPU, i386
Message-ID: <20020425112435.A16346@mark.mielke.cc>
In-Reply-To: <200204251310.g3PD9dI00738@localhost.localdomain> <Pine.LNX.3.95.1020425095821.6728B-100000@chaos.analogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 25, 2002 at 10:22:49AM -0400, Richard B. Johnson wrote:
> To use the math macros, the comparison should be something like:
>         if (isless(fabs(a-b), 1.0e-38))
>              break;

I might be saying something stupid, but, I was under the impression
that floating point '==', assuming it follows IEEE rules, does exactly
this.

I know for certain that it does not do memcmp(), as it has to deal
with the exponent and mantissa being each off by +/-1 and <</>>1
respectively.

mark

-- 
mark@mielke.cc/markm@ncf.ca/markm@nortelnetworks.com __________________________
.  .  _  ._  . .   .__    .  . ._. .__ .   . . .__  | Neighbourhood Coder
|\/| |_| |_| |/    |_     |\/|  |  |_  |   |/  |_   | 
|  | | | | \ | \   |__ .  |  | .|. |__ |__ | \ |__  | Ottawa, Ontario, Canada

  One ring to rule them all, one ring to find them, one ring to bring them all
                       and in the darkness bind them...

                           http://mark.mielke.cc/

