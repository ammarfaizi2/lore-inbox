Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752496AbWAFTA5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752496AbWAFTA5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 14:00:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752526AbWAFTA5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 14:00:57 -0500
Received: from wproxy.gmail.com ([64.233.184.203]:45284 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1752496AbWAFTA4 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 14:00:56 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=CmZMfBTuJCp/L6qwwZwVbBeZk8xuHdSPA88NiGrvBMssfcGUO5M7rPZbTp6kWS3yo8TCHGdixZo2GC80b1PtHJZwf3jRIkVvhibjIxRiU8lXSreI8ZhsnjHbz9Hqx7GoJvJE+Cx7B5G7vgKzEyafPNCZ5aNBL2KkscGDi1TYaHg=
Message-ID: <9a8748490601061100g1a467b86k1c020ea7f7cf0f33@mail.gmail.com>
Date: Fri, 6 Jan 2006 20:00:53 +0100
From: Jesper Juhl <jesper.juhl@gmail.com>
To: Martin Bretschneider <mailing-lists-mmv@bretschneidernet.de>
Subject: Re: PROBLEM: PS/2 keyboard does not work with 2.6.15
Cc: linux-kernel@vger.kernel.org, Jan Engelhardt <jengelh@linux01.gwdg.de>,
       Dmitry Torokhov <dmitry.torokhov@gmail.com>
In-Reply-To: <E1EuuTC-0000mF-00@mars.bretschneidernet.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <E1EuVds-0000n9-00@mars.bretschneidernet.de>
	 <E1EuuTC-0000mF-00@mars.bretschneidernet.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/6/06, Martin Bretschneider <mailing-lists-mmv@bretschneidernet.de> wrote:
> Martin Bretschneider <mailing-lists-mmv@bretschneidernet.de> wrote:
>
> with some debugging help of Dmitry Torokhov and Jan Engelhardt I
> could *not* find the cause why the PS/2 keyboard does not work.
>
> But other things do work:
> - If I connect the keyboard with the USB, it does work with 2.6.15.
> - If I use another pc with an old AMD 500, the PS/2 keyboard does
> work.
>
> So, it could be a strange problem between the motherboard chipset
> (nforce4), the 2.6.15 kernel and the PS/2 connection.
>
> I am going to test some Kernels beetween 2.6.14.2 and 2.6.15 to find
> the problem in some time.
>
Once you've narrowed down what two release kernels are "last one
working" & "first one broken" you can get even closer by doing a git
bisection search between those two to (hopefully) narrow it down to
the exact git commit that broke it.
It's a bit of work, but usually very useful to track down the exact
thing that broke it if nothing else finds the problem :)

--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
