Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269463AbRHGVZK>; Tue, 7 Aug 2001 17:25:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269464AbRHGVZB>; Tue, 7 Aug 2001 17:25:01 -0400
Received: from andiamo.com ([161.58.172.50]:37038 "EHLO andiamo.com")
	by vger.kernel.org with ESMTP id <S269463AbRHGVYu>;
	Tue, 7 Aug 2001 17:24:50 -0400
Message-ID: <089001c11f87$3dd04570$103147ab@cisco.com>
From: "Hua Zhong" <hzhong@andiamo.com>
To: "Richard B. Johnson" <root@chaos.analogic.com>
Cc: "Igmar Palsenberg" <maillist@jdimedia.nl>, <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.GSO.4.31.0108071401180.5066-100000@cardinal0.Stanford.EDU>
Subject: Re: 2.4.x VM problems thread
Date: Tue, 7 Aug 2001 14:23:39 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Well you can kill Solaris in this way too.  The system just can't fork more
than a certain number of processes. But as long as you manage to kill them,
you will be fine again.

So what exactly does it have to do with VM?

----- Original Message -----
From: "Ted Unangst" <tedu@stanford.edu>
To: "Richard B. Johnson" <root@chaos.analogic.com>
Cc: "Igmar Palsenberg" <maillist@jdimedia.nl>;
<linux-kernel@vger.kernel.org>
Sent: Tuesday, August 07, 2001 2:02 PM
Subject: Re: 2.4.x VM problems thread


> On Tue, 7 Aug 2001, Richard B. Johnson wrote:
>
> > Wow a memory-mapped fork bomb! Now what on earth did you expect?
> > Run it from a user-account with ulimits enabled for slightly less
> > than the total system resources. Then complain.
>
> not even mmap'ed.
>
> case 0: break;
>                                 tmp = mmap(0, 64 * 4096, PROT_EXEC,
> MAP_SHARED
> | MAP_ANONYMOUS, -1, 0);
>
> the mmap never even gets run.  might as well be for(;;) fork();
>
>
>
>
> >
> >
> > Cheers,
> > Dick Johnson
> >
> > Penguin : Linux version 2.4.1 on an i686 machine (799.53 BogoMips).
> >
> >     I was going to compile a list of innovations that could be
> >     attributed to Microsoft. Once I realized that Ctrl-Alt-Del
> >     was handled in the BIOS, I found that there aren't any.
> >
> >
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel"
in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> >
>
> --
> "I am clearly more popular than Reagan.  I am in my third term.
> Where's Reagan?  Gone after two!  Defeated by George Bush and
> Michael Dukakis no less."
>       - M. Barry, Mayor of Washington, DC
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

