Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265118AbUBIUyw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Feb 2004 15:54:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265152AbUBIUyw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Feb 2004 15:54:52 -0500
Received: from devil.servak.biz ([209.124.81.2]:11734 "EHLO devil.servak.biz")
	by vger.kernel.org with ESMTP id S265118AbUBIUym (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Feb 2004 15:54:42 -0500
Subject: Re: Need help about scanner (2.6.2-mm1)
From: Azog <slashmail@arnor.net>
To: gene.heskett@verizon.net
Cc: Steve Kieu <haiquy@yahoo.com>, kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <200402062307.37040.gene.heskett@verizon.net>
References: <20040207015841.36287.qmail@web10408.mail.yahoo.com>
	 <200402062307.37040.gene.heskett@verizon.net>
Content-Type: text/plain
Message-Id: <1076360361.6331.45.camel@moria.arnor.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Mon, 09 Feb 2004 12:59:21 -0800
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - devil.servak.biz
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - arnor.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you so much for the tip!  This seems to have solved my problem
too.

I changed my epson.conf file to just say
"usb"
instead of
"usb /dev/usb/scanner0"

and now, finally, it works.  I do hope the SANE documentation writers
get around to adding that little tidbit of info SOMEWHERE,  I was
tearing my hair out and rebooting back to 2.4 to use my scanner.  

Also, now that usb-scanner.ko is gone, a paragraph of help in the 
http://www.codemonkey.org.uk/docs/post-halloween-2.6.txt
file would be a great thing as well.


On Fri, 2004-02-06 at 20:07, Gene Heskett wrote:
> On Friday 06 February 2004 20:58, Steve Kieu wrote:
> >-----BEGIN PGP SIGNED MESSAGE-----
> >Hash: SHA1
> >
> >
> >Hi,
> >
> >Your help saved me lot of headache :-)
> 
> Thanks for the flowers.
> 
> > --- Gene Heskett <gene.heskett@verizon.net> wrote: >
> >On Friday 06 February 2004 18:57, Steve Kieu
> >
> >wrote:
> >> >-----BEGIN PGP SIGNED MESSAGE-----
> >>
> >> Take any device paths out of
> >> the /usr/local/etc/saned/nameofyourscanner.dll
> >
> >just .conf ; not dll :-)
> 
> Can I plead alzheimers or something?  Working with ancient grey matter 
> here.  Its working on the 70th trip around our star. :-)
> 
> >> leaving only a single [usb] as a specifier unless
> >
> >Yes it saved me. It work now. Why no other sane
> >documentation said like yours? I think people at sane
> >project should take your point to add to their
> >documentation.
> 
> I don't ATM recall exactly where I first heard or read about this.
> 
> Maybe in the libusb docs?  No, not a thing, even clear back up to the 
> root dir of the libusb archive.  Maybe I got it from the sane list?
> 
> In any event, thats too damned hard to find and if the libusb author 
> is copying the mail here, that little detail really should be added 
> to the README and/or INSTALL.libusb raw text files, or to a FAQ on 
> the libusb website, the quicker of the two alternatives if this 
> version of the library is stable (and it seems so to me).
> 
> The authors doc/html files are quite complete, I just read them all, 
> but they attack *only* the api the programmer would use, and the 
> actual non-programming user who just wants to use his scanner with 
> this new-fangled system gets hung out to dry.  This question gets 
> asked, and answered the same way, many times on the sane list too.
> 
> It may have been added to the sane-backend docs in a recent version, 
> I'm at least one version out of date here, not being inclined to "fix 
> something thats not broken" at my home site. :-)
> 
> [...]

