Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751490AbWCSLzN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751490AbWCSLzN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Mar 2006 06:55:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751489AbWCSLzN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Mar 2006 06:55:13 -0500
Received: from pproxy.gmail.com ([64.233.166.182]:6736 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751490AbWCSLzM convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Mar 2006 06:55:12 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=fTSbQn/cc1IKGN/h1KmAjdTDnQbNsLpGWnaCM3QuL4szLnrGd5uuCRT9lk7HLRHpmF9JLPQ95BDEY8uoX5cOwmWDg7kbey1utoHfflBry7/SA7Tr+ngA4OfBGdR16X3wJGDmm2tts+hc2r6Va4o8lRfdWWro5yx7gQMBX+rcCEA=
Message-ID: <9a8748490603190354n7732743ua97287bf3dcaf363@mail.gmail.com>
Date: Sun, 19 Mar 2006 12:54:38 +0100
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "Benjamin Bach" <benjamin@overtag.dk>
Subject: Re: Idea: Automatic binary driver compiling system
Cc: "Arjan van de Ven" <arjan@infradead.org>, linux-kernel@vger.kernel.org
In-Reply-To: <441D36DA.2000701@overtag.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <441AF93C.6040407@overtag.dk> <1142620509.25258.53.camel@mindpipe>
	 <441C213A.3000404@overtag.dk>
	 <1142694655.2889.22.camel@laptopd505.fenrus.org>
	 <441C2CF6.1050607@overtag.dk>
	 <1142698292.2889.26.camel@laptopd505.fenrus.org>
	 <441D36DA.2000701@overtag.dk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/19/06, Benjamin Bach <benjamin@overtag.dk> wrote:
[snip]
>
> Anyways, I'm very happy with the combination of intelligence and
> idealism on this list, and suddenly I feel more attracted to writing a
> driver instead. For my Rio Karma mp3 player. It's a USB thing.. should
> be do-able in 3 months even though I've never written a driver.
>

Writing a GPL'ed driver sounds like a great project.

For a USB device I'd suggest you take a look at libusb for writing a
userspace driver as opposed to a kernelspace one. Userspace drivers
for USB devices are often preferable.

Also take a look at a few documents in the Documentation/ dir in the
kernel source:
  HOWTO
  SubmittingDrivers
  CodingStyle

If you can get docs for the device (or are able to reverse engineer
it) and get a driver done, more power to you. :-)

>
> Cheers everybody, and thanks for sharing! =)
>
> / Benjamin
>
>
> Arjan van de Ven wrote:
[snip]

Top-posting is generally frawned upon on the list as it's annoying and
makes threads hard to read. Please consider changing that habbit.


--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
