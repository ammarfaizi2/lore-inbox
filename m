Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267395AbRGLBCR>; Wed, 11 Jul 2001 21:02:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267394AbRGLBCH>; Wed, 11 Jul 2001 21:02:07 -0400
Received: from web14402.mail.yahoo.com ([216.136.174.59]:6667 "HELO
	web14402.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S267393AbRGLBCD>; Wed, 11 Jul 2001 21:02:03 -0400
Message-ID: <20010712010204.23084.qmail@web14402.mail.yahoo.com>
Date: Wed, 11 Jul 2001 18:02:04 -0700 (PDT)
From: Rajeev Bector <rajeev_bector@yahoo.com>
Subject: Re: new IPC mechanism ideas
To: "H. Peter Anvin" <hpa@transmeta.com>
Cc: linux-kernel@vger.kernel.org, hpa@zytor.com
In-Reply-To: <3B4CF5E8.F9F9C429@transmeta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The point is that you can do IPC using
this scheme which is
1) protected (as compared to a shared
   memory (shm) scheme in which any process
   can write anywhere and corrupt
   everything)

2) involves only 1 copy.

Thanks,
Rajeev

--- "H. Peter Anvin" <hpa@transmeta.com> wrote:
> Rajeev Bector wrote:
> > 
> > If your driver is in the kernel,
> > then you dont need that. All processes
> > use system-calls (or ioctls) to send
> > messages and when they do recv(),
> > they get a pointer to a location
> > (where they are mapped to via mmap)
> > and they can read directly. In this
> > scheme, you dont need any traditional
> > UNIX IPC mechanism to work.
> > 
> 
> And the point of this is?
> 
> 	-hpa
> -
> To unsubscribe from this list: send the line
> "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at 
> http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/


__________________________________________________
Do You Yahoo!?
Get personalized email addresses from Yahoo! Mail
http://personal.mail.yahoo.com/
