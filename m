Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130253AbRCTOZb>; Tue, 20 Mar 2001 09:25:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130317AbRCTOZL>; Tue, 20 Mar 2001 09:25:11 -0500
Received: from smtp5vepub.gte.net ([206.46.170.26]:19565 "EHLO
	smtp5ve.mailsrvcs.net") by vger.kernel.org with ESMTP
	id <S130253AbRCTOZI>; Tue, 20 Mar 2001 09:25:08 -0500
Message-ID: <3AB767F8.D89FE629@neuronet.pitt.edu>
Date: Tue, 20 Mar 2001 09:23:52 -0500
From: "Rafael E. Herrera" <raffo@neuronet.pitt.edu>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: John R Lenton <john@grulic.org.ar>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ehrhardt@mathematik.uni-ulm.de
Subject: Re: [sligthly OT] serial console on palm
In-Reply-To: <20010319012801.B2849@grulic.org.ar>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It was posted by Christian Ehrhardt.

ehrhardt@mathematik.uni-ulm.de wrote:
> 
> On Mon, Feb 12, 2001 at 05:32:39PM +0100, I wrote:
> > I wrote a little palm app some time ago that can capture serial
> > console output. If anyone is interested I'll build a tar ball with
> > sources and binary.
> 
> It is now availiable at http://www.mathematik.uni-ulm.de/~ehrhardt/serial/
> 
> Sorry for the slightly off topic post but I think enough people
> showed interest to justify this.
> 
>      regards    Christian Ehrhardt


I made a couple of changes to it. Mainly:

 Made a Makefile
 increased the speed to 19200
 added a scrollbar
 a filter to get rid of some ansi characters.

If someone could add the code to use higher speeds and being able to
recall previous logs would make it more usefull.

The changed version can be obtained in:

http://www.neuronet.pitt.edu/~raffo/SerialRecord/

Bugs: If your machine crashes while booting it will loose the tail of
the output, maybe because is not fast enough. 

-- 
     Rafael
