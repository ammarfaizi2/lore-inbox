Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289166AbSA1NyI>; Mon, 28 Jan 2002 08:54:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289124AbSA1NyA>; Mon, 28 Jan 2002 08:54:00 -0500
Received: from natpost.webmailer.de ([192.67.198.65]:6901 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP
	id <S289101AbSA1Nxo>; Mon, 28 Jan 2002 08:53:44 -0500
Date: Mon, 28 Jan 2002 14:51:54 +0100
From: Kristian <kristian.peters@korseby.net>
To: Andrew Morton <akpm@zip.com.au>
Cc: ed.sweetman@wmich.edu, linux-kernel@vger.kernel.org
Subject: Re: [CFT] Bus mastering support for IDE CDROM audio
Message-Id: <20020128145154.6437b39b.kristian.peters@korseby.net>
In-Reply-To: <3C550BD4.E9CBE6A@zip.com.au>
In-Reply-To: <20020127111917.3c019701.kristian.peters@korseby.net>
	<3C5119E0.6E5C45B6@zip.com.au>
	<000701c1a5d5$812ef580$6caaa8c0@kevin>
	<3C53711B.F8D89811@zip.com.au>
	<3C53A116.81432588@zip.com.au>
	<20020127101131.0f71e978.kristian.peters@korseby.net>
	<20020127111917.3c019701.kristian.peters@korseby.net>
	<1012161271.22707.50.camel@psuedomode>
	<3C550BD4.E9CBE6A@zip.com.au>
X-Mailer: Sylpheed version 0.7.0claws5 (GTK+ 1.2.10; i386-redhat-linux)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@zip.com.au> wrote:
> OK, Gents.  Version three is at
> 
> 	http://www.zip.com.au/~akpm/linux/2.4/2.4.18-pre7/ide-akpm-3.patch
> 
> This attempts to overcome the situation where a drive/controller
> doesn't want to perform multiframe DMA, but is happy performing
> single-frame DMA.
> [...]

The third patch works fine.

When I'm doing "hdparm -c0 /dev/hdc" (16bit I/O) the system respond-ratio gets very low. (with all ide-cd-patches) I can see when gtk draws it's icons... But when I switch I/O back to 32 bit linux gets responsive again and cpu load decreases (~20%).

Tested with 2.4.18-pre3-ac2 and 2.4.17-lowlat-ide.

*Kristian

  :... [snd.science] ...:
 ::
 :: http://www.korseby.net
 :: http://gsmp.sf.net
  :.........................:: ~/$ kristian@korseby.net :
