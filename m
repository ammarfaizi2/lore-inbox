Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287933AbSA0KVZ>; Sun, 27 Jan 2002 05:21:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287939AbSA0KVQ>; Sun, 27 Jan 2002 05:21:16 -0500
Received: from natwar.webmailer.de ([192.67.198.70]:42933 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP
	id <S287933AbSA0KVF>; Sun, 27 Jan 2002 05:21:05 -0500
Date: Sun, 27 Jan 2002 11:19:17 +0100
From: Kristian <kristian.peters@korseby.net>
To: akpm@zip.com.au
Cc: linux-kernel@vger.kernel.org
Subject: Re: [CFT] Bus mastering support for IDE CDROM audio
Message-Id: <20020127111917.3c019701.kristian.peters@korseby.net>
In-Reply-To: <20020127101131.0f71e978.kristian.peters@korseby.net>
In-Reply-To: <3C5119E0.6E5C45B6@zip.com.au>
	<000701c1a5d5$812ef580$6caaa8c0@kevin>
	<3C53711B.F8D89811@zip.com.au>
	<3C53A116.81432588@zip.com.au>
	<20020127101131.0f71e978.kristian.peters@korseby.net>
X-Mailer: Sylpheed version 0.7.0claws5 (GTK+ 1.2.10; i386-redhat-linux)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello again.

Ok. Sorry. My fault. The second patch produces the same throughput... I didn't realized that the kernel disabled DMA during rebooting. My drives only went to DMA again after a cold boot. Don't know what's going on here. But after a normal reboot, my drives are in PIO only and don't support DMA.

cdparanoia on /dev/scd0 now gives the same result as with the first patch.
real    1m8.055s
user    0m6.740s
sys     0m2.850s

*Kristian

  :... [snd.science] ...:
 ::
 :: http://www.korseby.net
 :: http://gsmp.sf.net
  :.........................:: ~/$ kristian@korseby.net :
