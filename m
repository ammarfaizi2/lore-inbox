Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269000AbRG3Q2W>; Mon, 30 Jul 2001 12:28:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268999AbRG3Q2M>; Mon, 30 Jul 2001 12:28:12 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:60938 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S269000AbRG3Q14>;
	Mon, 30 Jul 2001 12:27:56 -0400
Date: Mon, 30 Jul 2001 13:27:57 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.rielhome.conectiva>
To: "Patrick J. LoPresti" <patl@curl.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Chris Mason <mason@suse.com>,
        Chris Wedgwood <cw@f00f.org>, <linux-kernel@vger.kernel.org>
Subject: Re: ext3-2.4-0.9.4
In-Reply-To: <s5g8zh6pjlv.fsf@egghead.curl.com>
Message-ID: <Pine.LNX.4.33L.0107301326150.11893-100000@imladris.rielhome.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On 30 Jul 2001, Patrick J. LoPresti wrote:

>   The relevant standards (POSIX, SuS, etc.) provide no way to perform
>   reliable transactions on a file system.
>
>   BSD provides one solution, which is synchronous metatdata.  (I am
>   assuming modern BSDs already deal with the multiple-disk-block
>   problem to make these transactions properly atomic.  Is this
>   assumption false?)
>
>   Linux provides a different solution, which is fsync() on the
>   directory.
>
>   All MTAs, and other apps besides, currently use the BSD solution for
>   reliable transactions.
>
> Is it really so absurd to ask Linux to provide efficient support of
> the BSD semantics as an option?

Yes. You could fix this issue in userland very easily,
it might even work with an LD_PRELOAD ...

Besides BSD softupdates and the various journaling
filesystems which are in use on other Unixen also
don't provide the 4.3BSD solution any more ...

regards,

Rik
--
Virtual memory is like a game you can't win;
However, without VM there's truly nothing to lose...

http://www.surriel.com/		http://distro.conectiva.com/

Send all your spam to aardvark@nl.linux.org (spam digging piggy)

