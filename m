Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131638AbQLLMYD>; Tue, 12 Dec 2000 07:24:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131639AbQLLMXx>; Tue, 12 Dec 2000 07:23:53 -0500
Received: from smtp03.mrf.mail.rcn.net ([207.172.4.62]:32474 "EHLO
	smtp03.mrf.mail.rcn.net") by vger.kernel.org with ESMTP
	id <S131638AbQLLMXo>; Tue, 12 Dec 2000 07:23:44 -0500
Date: Tue, 12 Dec 2000 06:53:16 -0500 (EST)
From: "Mohammad A. Haque" <mhaque@haque.net>
To: <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.0-test12 not liking high disk i/o
In-Reply-To: <Pine.LNX.4.30.0012120636480.1053-100000@viper.haque.net>
Message-ID: <Pine.LNX.4.30.0012120650060.9714-100000@viper.haque.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If anyone is interested, this is what I am doing before it blows up
everytime...

sudo tar zxfv ~mhaque/linux-2.4.0-test5.tar.gz
cd linux
cat ~mhaque/kernel-patches/patch-2.4.0-test? ~mhaque/kernel-patches/patch-2.4.0-test1? | sudo patch -p1
sudo make mrproper
sudo cp ~/kernel-config .config
sudo make oldconfig
sudo make dep bzImage modules modules_install install


On Tue, 12 Dec 2000, Mohammad A. Haque wrote:

> Hey guys,
>
> Any one else experiencing problems when they do lots of disk activity
> in test12?
>

-- 

=====================================================================
Mohammad A. Haque                              http://www.haque.net/
                                               mhaque@haque.net

  "Alcohol and calculus don't mix.             Project Lead
   Don't drink and derive." --Unknown          http://wm.themes.org/
                                               batmanppc@themes.org
=====================================================================

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
