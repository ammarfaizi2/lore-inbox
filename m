Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273734AbRIXBZN>; Sun, 23 Sep 2001 21:25:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273736AbRIXBZD>; Sun, 23 Sep 2001 21:25:03 -0400
Received: from krusty.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:59910 "HELO
	krusty.e-technik.uni-dortmund.de") by vger.kernel.org with SMTP
	id <S273734AbRIXBY5>; Sun, 23 Sep 2001 21:24:57 -0400
Date: Mon, 24 Sep 2001 03:25:18 +0200
From: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux-2.4.10
Message-ID: <20010924032518.A8680@emma1.emma.line.org>
Mail-Followup-To: Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33.0109231142060.1078-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0109231142060.1078-100000@penguin.transmeta.com>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 23 Sep 2001, Linus Torvalds wrote:

> Ok, I released a real 2.4.10, let the fun begin..

...

> Give it hell,

Well, if I run XFree86 4.1.0 (SuSE Linux 7.0 here, Diamond Viper V550
(nVidia Riva TNT)) and switch to virtual text-mode tty (Ctrl Alt F1),
hell freezes over. Screen turns black (but monitor syncs), machine is
totally frozen. No Magic SysRq can help. Just Reset can. I use ext3fs on
several partitions. 2.4.9 is fine, 2.4.9-ac7, -ac10 and 2.4.10 are
broken.

Serial console on 2.4.9-ac10 didn't have output, didn't attach serial
console to 2.4.10 yet.

Since this is somewhat hopeless to debug, I'm trying to do a binary
search to figure which 2.4.10-pre broke things, but it'll take a while.
Don't expect results before Monday evening UT +0200.

Are there any particular suspect changes I should try to back out?
