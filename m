Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317432AbSGOLIR>; Mon, 15 Jul 2002 07:08:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317433AbSGOLIQ>; Mon, 15 Jul 2002 07:08:16 -0400
Received: from web10406.mail.yahoo.com ([216.136.130.98]:35346 "HELO
	web10406.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S317432AbSGOLIP>; Mon, 15 Jul 2002 07:08:15 -0400
Message-ID: <20020715111109.48830.qmail@web10406.mail.yahoo.com>
Date: Mon, 15 Jul 2002 21:11:09 +1000 (EST)
From: =?iso-8859-1?q?Steve=20Kieu?= <haiquy@yahoo.com>
Subject: Re: Status of DRI modules for i810 with > 2.4.19-pre6
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <1026693715.13886.97.camel@irongate.swansea.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> Duplicate the problem with a 2.4.19-rc1-ac3 kernel
> (not one with random
> pre-empt patches). Then get a traceback. Also be
> sure to use XFree86 4.2
> or later
>  

The OOPS nolonger happened BUT it is useless as
XFree86-4.2.0 has problem with dri for i810; in the
XFree86 log file it says Direct rendering is enabled.
But run glxinfo shows that no other software can use
it!. I have searched and found a lot users have the
same thing. although I am quite sure that I installed
it properly (rm all old libGl etc...)

Go back to XFree86-4.1.0 compile 2.4.19-rc1-ac3 with
new dri modules; the oop also disappear. (That oops I
reported last time is with the old dri modules); I
thought wow it should be fine, but still no luck. run
glxinfo is fine; but run real application like
bzflags; bzflags can not run, it hang forever. No
OOPS, nothing, everything seems to be normal. Have to
killall -9  bzflag (15 doesn't stop it). Not sure what
caused this; Go back to use kernel 2.4.18-ck4  
everything is in order :-)

Regards,



=====
Steve Kieu

http://www.sold.com.au - SOLD.com.au
- Find yourself a bargain!
