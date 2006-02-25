Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932673AbWBYQmD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932673AbWBYQmD (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Feb 2006 11:42:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932496AbWBYQmD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Feb 2006 11:42:03 -0500
Received: from zproxy.gmail.com ([64.233.162.198]:42354 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932737AbWBYQlz convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Feb 2006 11:41:55 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=dxNHmu07+ymRirtmhHYowqr47ca8d8Jf+OLFQ35IkydePsKBIbhzSpVXcPFu713CX4eJlrnJPyXQsogV7j++10lURKXm79+1lQz9S81hl5YaDMgWjq9chOyKWe6brqlmj5yHURremJNqhAu9c8fNGS5HqG1JWO7CPhQnr7ph/OY=
Message-ID: <9a8748490602250841q32213603l50dd4142a9a107ae@mail.gmail.com>
Date: Sat, 25 Feb 2006 17:41:54 +0100
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "Adrian Bunk" <bunk@stusta.de>
Subject: Re: OSS msnd build failure
Cc: "Andrew Veliath" <andrewtv@usa.net>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
In-Reply-To: <20060225163221.GZ3674@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <9a8748490602250824u34e664fandc56c20394367926@mail.gmail.com>
	 <20060225163221.GZ3674@stusta.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/25/06, Adrian Bunk <bunk@stusta.de> wrote:
> On Sat, Feb 25, 2006 at 05:24:10PM +0100, Jesper Juhl wrote:
>
> > During some build tests of 2.6.16-rc4-mm2 with  'make randconfig'  I
> > found this build failure :
> >
> >   ...
> >   LD      drivers/built-in.o
> >   CC      sound/sound_core.o
> >   CC      sound/sound_firmware.o
> >   CC      sound/oss/msnd.o
> > make[2]: *** No rule to make target `/etc/sound/msndperm.bin', needed
> > by `sound/oss/msndperm.c'.  Stop.
> > make[2]: *** Waiting for unfinished jobs....
> > make[1]: *** [sound/oss] Error 2
> > make: *** [sound] Error 2
> >
> > I must admit I don't know how to fix it, so I'll have to just report it.
>
> That's expected if the .config contains CONFIG_STANDALONE=n
>

Ahhh, makes perfect sense, I should have thought of that.

Thanks Adrian.

--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
