Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278239AbRJ1M2A>; Sun, 28 Oct 2001 07:28:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278258AbRJ1M1u>; Sun, 28 Oct 2001 07:27:50 -0500
Received: from smtpzilla5.xs4all.nl ([194.109.127.141]:31752 "EHLO
	smtpzilla5.xs4all.nl") by vger.kernel.org with ESMTP
	id <S278239AbRJ1M1j>; Sun, 28 Oct 2001 07:27:39 -0500
Message-ID: <3BDBF9C8.8E1F96AB@linux-m68k.org>
Date: Sun, 28 Oct 2001 13:27:52 +0100
From: Roman Zippel <zippel@linux-m68k.org>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.12 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Richard Gooch <rgooch@atnf.csiro.au>
CC: Rik van Riel <riel@conectiva.com.br>,
        Ryan Cumming <bodnar42@phalynx.dhs.org>,
        Alexander Viro <viro@math.psu.edu>, linux-kernel@vger.kernel.org
Subject: Re: more devfs fun (Piled Higher and Deeper)
In-Reply-To: <E15xaiJ-0001Na-00@localhost>
		<Pine.LNX.4.33L.0110272259060.32445-100000@imladris.surriel.com> <200110280845.f9S8jjJ25269@mobilix.atnf.CSIRO.AU>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Richard Gooch wrote:

> Furthermore, I've nearly finished the big rewrite of devfs which adds
> proper locking and refcounting. That work was progressing nicely (but
> it's a big job), although it's temporarily stalled because of some
> important travel. Work on that will resume in the next couple of
> weeks. There's no point sending in an incomplete version of the code.

What about putting them somewhere in a CVS repository, so people can see
what's going on and maybe even can help out?
BTW you should really do something about your coding style, your code is
very confusing to read. I wouldn't care if it would be just some driver,
but devfs is supposed to be a very important part, so it would be nice
to use the same rules that apply to other important parts of the kernel.

bye, Roman
