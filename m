Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262603AbTCIUj1>; Sun, 9 Mar 2003 15:39:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262608AbTCIUj1>; Sun, 9 Mar 2003 15:39:27 -0500
Received: from gjs.xs4all.nl ([80.126.25.16]:19624 "EHLO mail.gjs.cc")
	by vger.kernel.org with ESMTP id <S262603AbTCIUj0>;
	Sun, 9 Mar 2003 15:39:26 -0500
From: GertJan Spoelman <kl@gjs.cc>
To: Bill Davidsen <davidsen@tmr.com>,
       Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Module XXX can not be unloaded
Date: Sun, 9 Mar 2003 21:49:03 +0100
User-Agent: KMail/1.6
References: <Pine.LNX.4.44.0303091500250.4012-100000@bilbo.tmr.com>
In-Reply-To: <Pine.LNX.4.44.0303091500250.4012-100000@bilbo.tmr.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200303092149.03634.kl@gjs.cc>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 09 March 2003 21:19, davidsen wrote:
> My logs are filled with this message, in spite of:
>  1 - nothing is trying to unload these modules

Are you sure?, some distro's have a default cronjob which do a rmmod -as every 
hour or maybe even more frequent.
The -s logs the message to syslog instead of the terminal.

>  2 - my kernels are built w/o module unloading because I have never yet
>      found any module which *could* be unloaded by the new code.
>
> I presume this should be replaced by a message saying that module
> unloading is not configured, and that it should only happen when a program
> tries to unload a module, rather than generating many lines of meaningless
> log babble.
-- 

    GertJan
