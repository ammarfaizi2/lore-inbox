Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288961AbSAFOld>; Sun, 6 Jan 2002 09:41:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288962AbSAFOlN>; Sun, 6 Jan 2002 09:41:13 -0500
Received: from ns.ithnet.com ([217.64.64.10]:57866 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id <S288961AbSAFOlG>;
	Sun, 6 Jan 2002 09:41:06 -0500
Date: Sun, 6 Jan 2002 15:40:55 +0100
From: Stephan von Krawczynski <skraw@ithnet.com>
To: nknight@pocketinet.com
Cc: kernel@theoesters.com, linux-kernel@vger.kernel.org
Subject: Re: 1gb RAM + 1gb SWAP + make -j bzImage = OOM
Message-Id: <20020106154055.0909240d.skraw@ithnet.com>
In-Reply-To: <WHITEkvVMLaWYzfZRzD00000ce9@white.pocketinet.com>
In-Reply-To: <004b01c1955e$ecbc9190$6400a8c0@philxp>
	<WHITExcPbVzv2N2Ku2000000c76@white.pocketinet.com>
	<20020105161958.43d7ab25.skraw@ithnet.com>
	<WHITEkvVMLaWYzfZRzD00000ce9@white.pocketinet.com>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.6.6 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 5 Jan 2002 09:57:17 -0800
Nicholas Knight <nknight@pocketinet.com> wrote:

> On Saturday 05 January 2002 07:19 am, Stephan von Krawczynski wrote:
> > On Fri, 4 Jan 2002 16:42:43 -0800
> >
> > Nicholas Knight <nknight@pocketinet.com> wrote:
> > > I have absilutely no trouble reproducing on an 800MHz Athlon with
> > > 256MB RAM/256MB swap on 2.4.17
> >
> > The simple question is: is the RAM sufficient at all to spawn such a
> > lot of cc processes? In my setup I get around 1000 concurrently
> > working during -j. This sounds like a real problem for 256/256, or
> > not?
> 
> Matter of scale, did you try a full kernel build with make -j bzImage 
> using whatever your normal config is?

Yes, of course, and it works at my side. Worked with 1GB RAM/256MB swap, works
now with 2GB RAM/256MB swap on stock 2.4.17.

> I still believe this is an innappropriate test, sure if you have tons 
> of RAM and swap it may eventualy complete

I never saw it not completing on my box with 2.4.17, regardless of what I do in
the mean time (writing mails or the like). Of course system performance drops
somehow down when load reaches about 150, but I think this can be expected ;-)

Regards,
Stephan

