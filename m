Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281668AbRKQBUq>; Fri, 16 Nov 2001 20:20:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281672AbRKQBUh>; Fri, 16 Nov 2001 20:20:37 -0500
Received: from ns.roland.net ([65.112.177.35]:13316 "EHLO earth.roland.net")
	by vger.kernel.org with ESMTP id <S281668AbRKQBUV>;
	Fri, 16 Nov 2001 20:20:21 -0500
Message-ID: <007101c16f06$029e24d0$a000a8c0@gespl2k1>
From: "Jim Roland" <jroland@roland.net>
To: <lobo@polbox.com>, <linux-kernel@vger.kernel.org>
In-Reply-To: <20011113024806.A13176@chello062179017166.chello.pl>
Subject: Re: I'm sorry [it was: Nazi Kernels]
Date: Fri, 16 Nov 2001 19:20:14 -0600
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Part of what might be your problem is the kernel version you're on.  The
drivers are written as a module for kernel version 2.4.x (and maybe 2.2.x,
but I'm not sure about 2.2.x).  Remember, kernel versions with an odd number
in the 2nd place holder (eg, 2.1.x, 2.3.x) are considered "test" or "beta"
kernels.  If you can't go to 2.4, try 2.2 and recompile the sources if a
binary is not provided.  My memory may be failing, but I think I remember
running my GeForce2 with NVidia provided drivers under 2.2 compiled from
sources.  I use the 2.4 drivers right now and all works fine.


~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Jim Roland, RHCE (RedHat Certified Engineer)
Owner, Roland Internet Services
     "The four surefire rules for success:  Show up, Pay attention, Ask
questions, Don't quit."
        --Rob Gilbert, PH.D.
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

----- Original Message -----
From: <lobo@polbox.com>
To: <linux-kernel@vger.kernel.org>
Sent: Monday, November 12, 2001 7:48 PM
Subject: I'm sorry [it was: Nazi Kernels]


> Hi again!
>
> I'm sorry for my last post. It was very stupid, but it was written
> without any thinking. I respect You, and Your work, so I meant no
> offense to You, but I know, that my last post, was very aggresive.
> I'm sorry again, and I will try to think twice before I write any
> post like last.
>
> Now after this introduction, I try to explain whats my problem with
> the new driver policy. When I try to load NVdriver to the kernel
> 2.1.14, the modprobe (modutils 2.4.10) writes following line
> "Note: modules without a GPL compatible license cannot use \
> GPLONLY_ symbols". It's Your decision, but in My opinion, its not
> the right way. I'm affraid, that this doesn't change the hardware
> manufacters opinions about the binary distributions of the drivers,
> so they copy or write this functions, and the only effect for end
> user will be more memory consumption (I know that memory is cheap
> today). I think in the future this may be the right way, but today
> it's to early for that step.
>
> Best Regards
> Przemek
>
> PS. Sorry for my english, it's not my native language.
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

