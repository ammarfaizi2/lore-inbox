Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264812AbRGEOd5>; Thu, 5 Jul 2001 10:33:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265189AbRGEOdr>; Thu, 5 Jul 2001 10:33:47 -0400
Received: from smtp010.mail.yahoo.com ([216.136.173.30]:17158 "HELO
	smtp010.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S264812AbRGEOdg>; Thu, 5 Jul 2001 10:33:36 -0400
X-Apparently-From: <swansma@yahoo.com>
Message-ID: <3B4476F8.7F09FC28@yahoo.com>
Date: Thu, 05 Jul 2001 10:17:28 -0400
From: Mark Swanson <swansma@yahoo.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.4-ac11 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Jari Ruusu <jari.ruusu@pp.inet.fi>
CC: linux-kernel@vger.kernel.org, Stefan Traby <stefan@hello-penguin.com>
Subject: Re: loop device corruption in 2.4.6
In-Reply-To: <01070417140200.03178@test.home2.mark> <3B443F11.307A5F61@pp.inet.fi>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jari Ruusu wrote:
> 
> Mark Swanson wrote:
> > I get repeatable errors with 2.4.6 patched with the international encryption
> > patch patch-int-2.4.3.1.bz2 when building loop device filesystems on top of
> > Reiserfs.
> 
> International crypto patch assumes that block size never changes. Everyone
> and their brother knows that it isn't true. And when block size does get
> changed, international crypto patch gets the IV completely wrong, and
> corrupts your data. To see block size changes in file systems alone, use

Jari,

This has been most enlightening.
I must say that I hope other people take a look at your README
and learn how to be as thorough as you.

Cheers.

_________________________________________________________
Do You Yahoo!?
Get your free @yahoo.com address at http://mail.yahoo.com

