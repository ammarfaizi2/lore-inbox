Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267956AbTCFJs2>; Thu, 6 Mar 2003 04:48:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267959AbTCFJs2>; Thu, 6 Mar 2003 04:48:28 -0500
Received: from cc78409-a.hnglo1.ov.home.nl ([212.120.97.185]:1924 "EHLO
	dexter.hensema.net") by vger.kernel.org with ESMTP
	id <S267956AbTCFJs0>; Thu, 6 Mar 2003 04:48:26 -0500
From: Erik Hensema <usenet@hensema.net>
Subject: Re: Entire LAN goes boo  with 2.5.64
Date: Thu, 6 Mar 2003 09:58:56 +0000 (UTC)
Message-ID: <slrnb6e6uv.18e.usenet@bender.home.hensema.net>
References: <195124534734.20030306103604@tnonline.net> <185124756546.20030306103945@tnonline.net>
Reply-To: erik@hensema.net
User-Agent: slrn/0.9.7.4 (Linux)
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anders Widman (andewid@tnonline.net) wrote:
> 
>>    Hello,
> 
>>    Trying  out  the  2.5.64  kernel  to try to solve some IDE specific
>>    problems  with 2.4.x kernels. Now I have another problem. We have a
>>    Windows LAN and a Windows XP with WinRoute Pro as gateway.
> 
>>    When  booting  the linux-machine with the 2.5.64 kernel the windows
>>    machine goes to 100% cpu and the switch (Dlink) goes crazy (loosing
>>    link, other machines get 100k/s instead of 10-12MiB/s etc).
> 
>>    I  compiled  the  2.5.64  with  as  few  options  as  possible,  no
>>    netfilter, or IPSec or similar stuff.
> 
>>    What can be the problem?
> 
>    Forgot to say I am using a Intel Pro100+ NIC and I have tested with
>    both the Becker driver and the Intel driver.

I've seen something similar [1] happen to a LAN with one Windows XP machine
running vcool: http://vcool.occludo.net/ . This is also available for Linux
(http://vcool.occludo.net/VC_Linux.html). Are you running this patch or a
similar one?

[1] all machines were seeing frame errors on packets > 250 bytes; it was a
10 mbit coax lan.
-- 
Erik Hensema <erik@hensema.net>
