Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277228AbRKNUOY>; Wed, 14 Nov 2001 15:14:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277258AbRKNUOO>; Wed, 14 Nov 2001 15:14:14 -0500
Received: from anime.net ([63.172.78.150]:56591 "EHLO anime.net")
	by vger.kernel.org with ESMTP id <S277228AbRKNUOI>;
	Wed, 14 Nov 2001 15:14:08 -0500
Date: Wed, 14 Nov 2001 12:13:03 -0800 (PST)
From: Dan Hollis <goemon@anime.net>
To: Hans-Peter Jansen <hpj@urpla.net>
cc: <sensors@stimpy.netroedge.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [lm_sensors] hard lockup on modprobe w83781d with Tyan Dual
 K7/Thunder
In-Reply-To: <20011114180440.A8934A99@shrek.lisa.de>
Message-ID: <Pine.LNX.4.30.0111141212220.24024-100000@anime.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Nov 2001, Hans-Peter Jansen wrote:
> I'm trying to get serveral lm_sensor versions up to CVS lm_sensors2 from
> yesterday to run on this mb. Now, I'm at linux-2.4.15-pre4, but also tried
> some 2.4.12(-ac?) versions, to no avail.

Known bug in w83781d driver.
http://www2.lm-sensors.nu/~lm78/readticket.cgi?ticket=697

The fix at the bottom works for me.

-Dan
-- 
[-] Omae no subete no kichi wa ore no mono da. [-]

