Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262149AbULLWJv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262149AbULLWJv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Dec 2004 17:09:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262154AbULLWJv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Dec 2004 17:09:51 -0500
Received: from mail.gmx.de ([213.165.64.20]:45475 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S262149AbULLWJd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Dec 2004 17:09:33 -0500
X-Authenticated: #10070094
Subject: Re: Improved console UTF-8 support for the Linux kernel?
From: Simos Xenitellis <simos74@gmx.net>
To: David =?ISO-8859-1?Q?G=F3mez?= <david@pleyades.net>
Cc: Jan Engelhardt <jengelh@linux01.gwdg.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20041212003857.GA14844@fargo>
References: <1102784797.4410.8.camel@kl> <20041211173032.GA13208@fargo>
	 <Pine.LNX.4.53.0412112002020.30929@yvahk01.tjqt.qr>
	 <1102803807.3183.59.camel@kl>
	 <Pine.LNX.4.61.0412120058230.15129@yvahk01.tjqt.qr>
	 <20041212003857.GA14844@fargo>
Content-Type: text/plain; charset=UTF-8
Message-Id: <1102889302.3195.10.camel@kl>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sun, 12 Dec 2004 22:08:22 +0000
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Gómez wrote:
> Hi Jan ;),
> 
> > >I am not sure how you wrote the above characters. According to UTF-8,
> > >characters with codepoints above 0x79 require two bytes so that to be
> > >valid. When you compose "ö" (you press something like ";", then "o") in
> > >the console?
> > 
> > ö is a "native key" on my keyboard, i.e. i do not need to play with compose to 
> > generate ö.
> 
> Aaahh ;), you've should said that before. The whole problem with the
> kernel is with the compose tables. If you have a native key for "ö" in
> your keyboard you'll not have problems. I can type for example a 'n
> with tilde' in my keyboard because is too is a native key, but for
> accentuated characters, for utf-8 output is neccesary to apply the patch :-/

And that's the whole issue.

As soon as the kernel is in Unicode  mode for the console, currently
there is no way to input accented characters through a dead key
(composed).
Some years back when 8-bit encodings where used there was no problem,
however now all distros are broken with regards to this.

I do not know what is the next step to consider adding the patch. Do we
get a kernel maintainer related to console I/O speak up and say "Hmm, I
*might* consider a patch, if I see it and people say they are happy"?

simos

