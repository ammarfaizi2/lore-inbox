Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267187AbSKMMCH>; Wed, 13 Nov 2002 07:02:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267188AbSKMMCH>; Wed, 13 Nov 2002 07:02:07 -0500
Received: from graze.net ([65.207.24.2]:62345 "EHLO graze.net")
	by vger.kernel.org with ESMTP id <S267187AbSKMMCG>;
	Wed, 13 Nov 2002 07:02:06 -0500
Subject: Re: i810 audio
From: "Brian C. Huffman" <sheep@oveja.graze.net>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Peter Kundrat <kundrat@kundrat.sk>, linux-kernel@vger.kernel.org
In-Reply-To: <1037148199.10029.30.camel@irongate.swansea.linux.org.uk>
References: <Pine.LNX.4.44.0211121802540.27793-100000@graze.net>
	<1037144284.10029.0.camel@irongate.swansea.linux.org.uk>
	<20021112184349.A11757@redhat.com>  <20021113000449.GB7015@napri.sk> 
	<1037148199.10029.30.camel@irongate.swansea.linux.org.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 13 Nov 2002 07:08:49 -0500
Message-Id: <1037189332.1846.2.camel@oveja.graze.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At least for mine, here's what I get out of /var/log/messages:

Nov 13 00:37:17 xxxxx kernel: i810_audio: Connection 0 with codec id 2
Nov 13 00:37:17 xxxxx kernel: ac97_codec: AC97 Audio codec, id:
ADS114(Unknown)
Nov 13 00:37:17 xxxxx kernel: i810_audio: AC'97 codec 2 supports AMAP,
total channels = 2


On Tue, 2002-11-12 at 19:43, Alan Cox wrote:

> The kernel knows which AC'97 chip is attached so it could be given a
> table to specify chips where "volume" should either not be presented or
> should be remapped. Do you know what AC97 chip is on your board (Linux
> will print the info in the i810 load, windows and the manual probably
> claim that you have that as your sound chip (typically "Analog
> something" or "Crystal something").
> 


