Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316867AbSEWPxo>; Thu, 23 May 2002 11:53:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316869AbSEWPxn>; Thu, 23 May 2002 11:53:43 -0400
Received: from air-2.osdl.org ([65.201.151.6]:25095 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S316867AbSEWPxl>;
	Thu, 23 May 2002 11:53:41 -0400
Date: Thu, 23 May 2002 08:51:40 -0700 (PDT)
From: "Randy.Dunlap" <rddunlap@osdl.org>
X-X-Sender: <rddunlap@dragon.pdx.osdl.net>
To: Tomas Szepe <szepe@pinerecords.com>
cc: Martin Dalecki <dalecki@evision-ventures.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: kb25 manual [was Re: [Linux-usb-users] Re: What to do with all
 of the USB UHCI drivers in the kernel?]
In-Reply-To: <20020523154252.GA24260@louise.pinerecords.com>
Message-ID: <Pine.LNX.4.33L2.0205230850080.4119-100000@dragon.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 May 2002, Tomas Szepe wrote:

| > BTW> one of the reasons I never bothered myself with kbuild-2.5
| > is for example that nio matter how frequently Keith
| > is advertising it - every time I go there to have a look at it
| > at sf what I find is a scatter heap of .tar.gz. The documentation
| > about how to install it makes me nervous, since I would
| > rather just expect a diff and a README how to use it, so I never
| > look after it.
|
| Duh... All you need is the core package (diff #1), the architecture
| independent modifications package (diff #2) and finally diff #3 that
| adds the arch-specific stuff. Everything's in a single list on sf.
|
| then just do s/t like
| cd /usr/src/linux-2.4.19-pre8 && zcat \
| 	../kbuild-2.5-core-14.gz \
| 	../kbuild-2.5-common-2.4.19-pre8-1.gz \
| 	../kbuild-2.5-i386-2.4.19-pre8-1.gz \
| 	| patch -sp1
|
| and read the comprehensive manual in Documentation/kbuild/
|
| What's there to be nervous about?

so there should just be a short, simple readme about how to
install and use it -- not one that is 2400 lines long.
Other than that, I like it.

-- 
~Randy

