Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269001AbRG3QWw>; Mon, 30 Jul 2001 12:22:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268996AbRG3QWn>; Mon, 30 Jul 2001 12:22:43 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:39178 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S268995AbRG3QWZ>;
	Mon, 30 Jul 2001 12:22:25 -0400
Date: Mon, 30 Jul 2001 13:22:24 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.rielhome.conectiva>
To: "Patrick J. LoPresti" <patl@cag.lcs.mit.edu>
Cc: Chris Mason <mason@suse.com>, Chris Wedgwood <cw@f00f.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, <linux-kernel@vger.kernel.org>
Subject: Re: ext3-2.4-0.9.4
In-Reply-To: <s5gpuaiplwf.fsf@egghead.curl.com>
Message-ID: <Pine.LNX.4.33L.0107301320370.11893-100000@imladris.rielhome.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On 30 Jul 2001, Patrick J. LoPresti wrote:

> performance hit of synchronous data.  Heck, just having link() and
> rename() perform a commit would be good enough for almost all
> applications.

It would be "good enough" for some applications,
but it would be absolutely disastrous for most
applications I run (ie. moving source code around).

Exactly what is wrong with doing fsync() on the
directory ?

Why do you want us to turn link() and rename()
into link_slowly() and rename_slowly() ?

Why can't you use a simple wrapper function to
do this for you ?

cheers,

Rik
--
Virtual memory is like a game you can't win;
However, without VM there's truly nothing to lose...

http://www.surriel.com/		http://distro.conectiva.com/

Send all your spam to aardvark@nl.linux.org (spam digging piggy)

