Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136135AbRECHIP>; Thu, 3 May 2001 03:08:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136137AbRECHIG>; Thu, 3 May 2001 03:08:06 -0400
Received: from lilly.ping.de ([62.72.90.2]:46087 "HELO lilly.ping.de")
	by vger.kernel.org with SMTP id <S136135AbRECHH4>;
	Thu, 3 May 2001 03:07:56 -0400
Date: 3 May 2001 09:06:45 +0200
Message-ID: <20010503070645.1175.qmail@toyland.ping.de>
From: "Michael Stiller" <michael@toyland.ping.de>
To: "Alan Cox" <alan@lxorguk.ukuu.org.uk>
Cc: "Amarendra GODBOLE" <agodbole@mahindrabt.com>,
        linux-kernel@vger.kernel.org
X-Mailer: exmh version 2.0.2 2/24/98
Subject: Re: Broken gcc ? 
In-Reply-To: Your message of "Wed, 02 May 2001 12:48:32 BST."
             <E14uv7T-0003TY-00@the-village.bc.nu> 
X-Url: http://www.ping.de/~michael
X-Face: "wBy`XBjk-b]Wks].wV-RmZmir({Qfv85d&!VDrjx+4Ra(/ZyXjaV-x^QXX-Ab5X#3Eap^/
  W^Zo.K9=py=t6/F&p3cl/.zrgKH)0uxy{#5Y(_dD=ftF*Q}-lp\&Z-563qR3X5qv^o9~iP(pw3_1q
  !ti@9"V[C?^iW\BVArF#(YjjLJ/[R%Ri*sw
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> 
> I do all my kernel development with gcc 2.96-69 and 2.96-81 (the errata
> 7.0 and the 7.1 gcc).

2.96-81 will not compile sgi's xfs patches due to some cpp macros using ##.
Use kgcc supplied with rh7 for that.

Cheers,

-Michael

-- 
x(f,s,c)char *s;{return f&1 ? *s ? *s-c ? x(f,++s,c) :7[s]:0:f&2 
? x(--f,"!/*,xq-ih9]c$=le&M t)r\nm@p31n%ag.8}Sdoy",c):f&4 ? *s ? 
x(f,s+1,putchar(x(f-2,"^&%!*)",*s))) : 0 : 0;}main(){return x(4,
"]!x/mhicn$!iihle&!x/mhiM$agimr%p !r@p%he&!x/mhiM !r@p%he",65);}


