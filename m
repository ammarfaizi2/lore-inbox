Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315513AbSEZA6G>; Sat, 25 May 2002 20:58:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315503AbSEZA6F>; Sat, 25 May 2002 20:58:05 -0400
Received: from tomts14.bellnexxia.net ([209.226.175.35]:4743 "EHLO
	tomts14-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S315513AbSEZA55> convert rfc822-to-8bit; Sat, 25 May 2002 20:57:57 -0400
From: Pierre Cloutier <pcloutier@poseidoncontrols.com>
Organization: POSEIDON CONTROLS INC
To: Linus Torvalds <torvalds@transmeta.com>
Subject: Re: patent on O_ATOMICLOOKUP [Re: [PATCH] loopable tmpfs (2.4.17)]
Date: Sat, 25 May 2002 21:03:16 +0000
X-Mailer: KMail [version 1.1.95.2]
Content-Type: text/plain; charset=US-ASCII
Cc: Robert Schwebel <robert@schwebel.de>, <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0205251739380.4355-100000@home.transmeta.com>
MIME-Version: 1.0
Message-Id: <02052521031600.04566@TheBox>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 26 May 2002, Linus Torvalds wrote:
> On Sat, 25 May 2002, Pierre Cloutier wrote:
> > Linus misses the most important feature of hard real time in user space.
> >
> > [ Short answer: debuggability ]
>
> I didn't miss it, but it hasn't come up, and I don't think it's actually
> all that much an issue of "RTLinux vs RTAI", but simply an issue of "do
> you have the same API in user land as in a module"?
>
> Because if you have the same API, you can do non-RT development in user
> land, and then just move it over once you know the basic code "works".
>
> Since the API is bound to be fairly limited, that shouldn't be much of a
> problem, but I have no idea what the actual development environments
> offer, and I have ansolutely zero interest in trying on the RT
> "straighjacket" myself ;)

Hi:

Sorry but you have it wrong:

"Because you have the same API, you can do the RT development in user space 
and then move it into the kernel once you know the code works."

Please do not underestimate the significance of this.

The API is limited. Yes. But it does provide me with the QNX like IPC I so 
cheerish - and that is all i need. Cheers!

Best Regards,

Pierre Cloutier
