Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261990AbVFQPCE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261990AbVFQPCE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Jun 2005 11:02:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261992AbVFQPCD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Jun 2005 11:02:03 -0400
Received: from alog0586.analogic.com ([208.224.223.123]:5275 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S261990AbVFQPB7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Jun 2005 11:01:59 -0400
Date: Fri, 17 Jun 2005 11:01:05 -0400 (EDT)
From: "Richard B. Johnson" <linux-os@analogic.com>
Reply-To: linux-os@analogic.com
To: Nico Schottelius <nico-kernel@schottelius.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel eats argument=
In-Reply-To: <20050617143642.GB17910@schottelius.org>
Message-ID: <Pine.LNX.4.61.0506171056090.12645@chaos.analogic.com>
References: <20050617143642.GB17910@schottelius.org>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="1879706418-1883592353-1119020465=:12645"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--1879706418-1883592353-1119020465=:12645
Content-Type: TEXT/PLAIN; charset=X-UNKNOWN; format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Fri, 17 Jun 2005, Nico Schottelius wrote:

> Hello!
>
> I wanted to have 'cprofile=3Da_profile" specified to my init
> system. Now after some hours of debugging I see that
> everything that is in the form of
>
>      bla=3Dblub
>
> is eaten by the kernel and _not_ given to init.
> Is that how it should be or is that a bug?
>
> If it's how it should be, I'll switch to "cprofile:a_profile"
> or will Linux eat that, too?
>
> The most mysterious thing (for me) is that /proc/cmdline
> contains that stuff again.
>
>
> Nico, somehow confused

Init gets a single parameter 'auto'. Variables not understood
by the kernel get put into the environment....

=00OME=3D/=00TERM=3Dlinux=00SELINUX_INIT=3DYES=00
   |
   |______ maybe a bug, no "H".

Cheers,
Dick Johnson
Penguin : Linux version 2.6.11.9 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by Dictator Bush.
                  98.36% of all statistics are fiction.
--1879706418-1883592353-1119020465=:12645--
