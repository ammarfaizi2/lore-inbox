Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268054AbRGZP3z>; Thu, 26 Jul 2001 11:29:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268026AbRGZP3p>; Thu, 26 Jul 2001 11:29:45 -0400
Received: from spiral.extreme.ro ([212.93.159.205]:47500 "HELO
	spiral.extreme.ro") by vger.kernel.org with SMTP id <S267727AbRGZP3e>;
	Thu, 26 Jul 2001 11:29:34 -0400
Date: Thu, 26 Jul 2001 18:32:37 +0300 (EEST)
From: Dan Podeanu <pdan@spiral.extreme.ro>
To: <sentry21@cdslash.net>
cc: "Richard B. Johnson" <root@chaos.analogic.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: Weird ext2fs immortal directory bug
In-Reply-To: <Pine.LNX.4.30.0107261104220.18300-100000@spring.webconquest.com>
Message-ID: <Pine.LNX.4.33L2.0107261830410.8540-100000@spiral.extreme.ro>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing


> sentry21@Petra:1:/$ sudo rm -rf lost+found/
> rm: cannot unlink `lost+found/#3147': Operation not permitted
> rm: cannot remove directory `lost+found': Directory not empty
>
>
> Dang.

Perhaps:

debugfs -w <your root filesystem>
unlink /lost+found/#3147



