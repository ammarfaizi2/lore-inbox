Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266214AbUAGPbQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jan 2004 10:31:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266215AbUAGPbQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jan 2004 10:31:16 -0500
Received: from mail-05.iinet.net.au ([203.59.3.37]:20669 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S266214AbUAGPbP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jan 2004 10:31:15 -0500
Message-ID: <3FFC2621.7060808@cyberone.com.au>
Date: Thu, 08 Jan 2004 02:30:41 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: martin f krafft <madduck@madduck.net>
CC: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: scheduling problems in X with 2.6.0
References: <20040107102352.GA2954@piper.madduck.net>
In-Reply-To: <20040107102352.GA2954@piper.madduck.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



martin f krafft wrote:

>Hi all,
>
>Ever since I moved to 2.6.0, I have been experiencing something I'd
>like to call scheduling problems while working in X. I have tried
>using preemptive mode, and turning it off, but the symptoms are the
>same:
>
>whenever there is continuous disk access (e.g. tar, rsync, dd),
>X will not respond for a couple of seconds every couple of seconds.
>With that I mean that the mouse will freeze as well as all screen
>output, and then resume after a couple of seconds.
>
>I wonder if I am the only one with that problem. The machine in
>question is a dual AMD 2400+ with 2Gb of RAM and a Maxtor DiamondMax
>drive spinning at 7200 RPM. The drive is configured as follows
>(hdparm):
>

Can you post 20 or so lines of 'vmstat 1' captured while the problem is
happening? See if you can see which lines correspond to X freezing (ie.
watch the xterm), but that might be impossible if everything freezes.


