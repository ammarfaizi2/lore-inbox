Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132573AbRDHRbl>; Sun, 8 Apr 2001 13:31:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132576AbRDHRbb>; Sun, 8 Apr 2001 13:31:31 -0400
Received: from smtp03.mrf.mail.rcn.net ([207.172.4.62]:26271 "EHLO
	smtp03.mrf.mail.rcn.net") by vger.kernel.org with ESMTP
	id <S132573AbRDHRbU>; Sun, 8 Apr 2001 13:31:20 -0400
Message-ID: <3AD0A029.C17C3EFC@rcn.com>
Date: Sun, 08 Apr 2001 12:30:17 -0500
From: Marvin Stodolsky <stodolsk@rcn.com>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.4.3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Russell King <rmk@arm.linux.org.uk>
CC: kaos@ocs.com.au, linux-kernel@vger.kernel.org
Subject: Re: build -->/usr/src/linux
In-Reply-To: <3AD079EA.50DA97F3@rcn.com> <20010408161620.A21660@flint.arm.linux.org.uk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell

Thanks for responding.  But I would still like to understand what the
functionality is of the build --> /usr/src/linuc.  Is it dispensable,
once the module tree has been installed? 

Incidentally, per below, my own modutils is current, though some of the
folks using our ltmodem.o compiler/installer kits may indeed need to
update. 
> You need to update your modutils package - there have been a number of
> important bug fixes, including some which allow it to work properly with
> 2.4 kernels.

# insmod -V
insmod version 2.4.2
# grep " # " /usr/src/linux-2.4.3/Documentation/Changes
o  Gnu C                  2.91.66                 # gcc --version
o  Gnu make               3.77                    # make --version
o  binutils               2.9.1.0.25              # ld -v
o  util-linux             2.10o                   # fdformat --version
o  modutils               2.4.2                   # insmod -V
etc.

MarvS


> Russell King wrote:
> 
> On Sun, Apr 08, 2001 at 09:47:06AM -0500, Marvin Stodolsky wrote:
> > It's presence has required some gymnastics, per below, during module
> > installation for the Winmodem driver, ltmodem.o requiring a subsequent
> > "depmod -a"
> 
> You need to update your modutils package - there have been a number of
> important bug fixes, including some which allow it to work properly with
> 2.4 kernels.
> 
> --
> Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
>              http://www.arm.linux.org.uk/personal/aboutme.html
