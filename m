Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317673AbSIEPlZ>; Thu, 5 Sep 2002 11:41:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317701AbSIEPlZ>; Thu, 5 Sep 2002 11:41:25 -0400
Received: from nycsmtp1out.rdc-nyc.rr.com ([24.29.99.226]:1203 "EHLO
	nycsmtp1out.rdc-nyc.rr.com") by vger.kernel.org with ESMTP
	id <S317673AbSIEPlY>; Thu, 5 Sep 2002 11:41:24 -0400
Message-ID: <3D777BC0.9030004@linux.org>
Date: Thu, 05 Sep 2002 11:44:00 -0400
From: John Weber <john.weber@linux.org>
Organization: Linux Online
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020827
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: linux-kernel@vger.kernel.org
Subject: Re: Linux on Toshiba Libretto 70CT
References: <3D7563B2.2090707@linux.org> <1031138132.2796.24.camel@irongate.swansea.linux.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> On Wed, 2002-09-04 at 02:36, John Weber wrote:
> 
>>The kernel locks up completely whenever I launch any particularly large 
>>application under X (xterm is fine, netscape locks up the box).
>>I've confirmed that this isn't just X locking up, as the machine is 
>>completely frozen (doesn't respond to pings, doesn't respond to three 
>>finger salute, etc).
> 
> 
> Can you duplicate this with the vesa and/or vga16 drivers ?
> 

The kernel locks up regardless of what drivers I use (and I have tried 
the vga16 drivers already).

Disabling the accelerated functions also "fixes" the machine, for some 
definitions of "fix" :).

My question is really why this problem would lock up the kernel...
I can't really tell whether the problem is in the implementation of the 
XFree86 functions or the kernel functions it is calling, but the fact 
that the entire kernel locks up suggests that both are to blame.  Can 
you suggest where I should start reading code (if not the file atleast 
the directory :).

(o- j o h n  e  w e b e r
//\ aspiring computer scientist
v_/_ http://www-cs.ccny.cuny.edu/acm/weber/

