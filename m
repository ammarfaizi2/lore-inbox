Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130485AbRDFBrq>; Thu, 5 Apr 2001 21:47:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130507AbRDFBrg>; Thu, 5 Apr 2001 21:47:36 -0400
Received: from vp175062.reshsg.uci.edu ([128.195.175.62]:54800 "EHLO
	moisil.dev.hydraweb.com") by vger.kernel.org with ESMTP
	id <S130485AbRDFBrR>; Thu, 5 Apr 2001 21:47:17 -0400
Date: Thu, 5 Apr 2001 18:46:34 -0700
Message-Id: <200104060146.f361kYm22348@moisil.dev.hydraweb.com>
From: Ion Badulescu <ionut@moisil.cs.columbia.edu>
To: Andrew Daviel <advax@triumf.ca>
Cc: linux-kernel@vger.kernel.org
Subject: Re: syslog insmod please!
In-Reply-To: <Pine.LNX.4.30.0104051751410.20174-100000@andrew.triumf.ca>
User-Agent: tin/1.5.7-20001104 ("Paradise Regained") (UNIX) (Linux/2.2.19 (i586))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 5 Apr 2001 17:57:48 -0700 (PDT), Andrew Daviel <andrew@andrew.triumf.ca> wrote:

> Is there a good reason why insmod should not call syslog() to log
> any module that gets installed ? 

Simple: you'll have quite a bit of a problem if you are trying to insmod
the module with support for AF_UNIX sockets. :-)

Ion

-- 
  It is better to keep your mouth shut and be thought a fool,
            than to open it and remove all doubt.
