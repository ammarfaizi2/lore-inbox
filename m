Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282350AbRKXClL>; Fri, 23 Nov 2001 21:41:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282352AbRKXClB>; Fri, 23 Nov 2001 21:41:01 -0500
Received: from cc361913-a.flrtn1.occa.home.com ([24.0.193.171]:40320 "EHLO
	mirai.cx") by vger.kernel.org with ESMTP id <S282350AbRKXCkq>;
	Fri, 23 Nov 2001 21:40:46 -0500
Message-ID: <3BFF08AA.9433E93F@pobox.com>
Date: Fri, 23 Nov 2001 18:40:42 -0800
From: J Sloan <jjs@pobox.com>
Organization: J S Concepts
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.15-ll-preempt-tux2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Arnvid Karstad <arnvid@karstad.org>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: kernel: VFS: Disk change detected on device ide1(22,0)
In-Reply-To: <20011124023830.E927.ARNVID@karstad.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arnvid Karstad wrote:

> Hiya
>
> I'm getting alot of these messages all the time.
> every other second or so.. what are they?
>
> ide1 is where my dvd rom is located.. and Hitachi DVD-Rom GD-s200.
>
> Kernel is 2.4.15 and distribution is Red Hat 7.2
>
> I didn't have any of these messages with the 2.4.9..

killall magicdev
rpm -evv magicdev

killall autorun
rpm -evv autorun

-- works for me...

cu

jjs


