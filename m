Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262856AbSIPUcT>; Mon, 16 Sep 2002 16:32:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262891AbSIPUcT>; Mon, 16 Sep 2002 16:32:19 -0400
Received: from c16598.thoms1.vic.optusnet.com.au ([210.49.243.217]:51394 "HELO
	pc.kolivas.net") by vger.kernel.org with SMTP id <S262856AbSIPUcS>;
	Mon, 16 Sep 2002 16:32:18 -0400
Message-ID: <1032208634.3d8640fa2d8fd@kolivas.net>
Date: Tue, 17 Sep 2002 06:37:14 +1000
From: Con Kolivas <conman@kolivas.net>
To: Bill Davidsen <davidsen@tmr.com>
Cc: Linux-Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Possible addition to contest
References: <Pine.LNX.3.96.1020916142511.6180C-100000@gatekeeper.tmr.com>
In-Reply-To: <Pine.LNX.3.96.1020916142511.6180C-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Bill Davidsen <davidsen@tmr.com>:

> It would be nice to be able to add a short string to the kernel version
> for identification, to differentiate between runs with the same kernel and
> different tuning.

Easy fix. Will do. The original version you had to tell it which kernel you were
running so I can add that as optional.

> I've found that tuning often helps response, like reducing memory with
> older rmap versions (ran for a while using mem=256m), or tuning bdflush
> with -aa kernels, which I did after Andrea gave me some serious hints.
> Just a short string added to the version would make this a bit easier to
> follow after the fact.

Perfectly reasonable. Be aware though that reducing mem will also change the
write size of io loads in contest. Although this will test the VM's response to
half and full size writes it will also decrease the size of IO load.

Con.

