Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284300AbSAZNbr>; Sat, 26 Jan 2002 08:31:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284794AbSAZNbk>; Sat, 26 Jan 2002 08:31:40 -0500
Received: from natwar.webmailer.de ([192.67.198.70]:38016 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP
	id <S284300AbSAZNbe>; Sat, 26 Jan 2002 08:31:34 -0500
Date: Sat, 26 Jan 2002 13:03:34 +0100
From: Kristian <kristian.peters@korseby.net>
To: Andrew Morton <akpm@zip.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [CFT] Bus mastering support for IDE CDROM audio
Message-Id: <20020126130334.1d5bca71.kristian.peters@korseby.net>
In-Reply-To: <3C5119E0.6E5C45B6@zip.com.au>
In-Reply-To: <3C5119E0.6E5C45B6@zip.com.au>
X-Mailer: Sylpheed version 0.7.0claws5 (GTK+ 1.2.10; i386-redhat-linux)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

Works very fine here. I applied your patch on 2.4.18-pre3-ac2. System feels little smoother overall. Especially when I grab from 2 CD's simultaneously.

Will it be included in 2.4.19 ?

*Kristian

Andrew Morton <akpm@zip.com.au> wrote:
> Reading audio from IDE CDROMs always uses PIO.  This patch
> teaches the kernel to use DMA for the CDROMREADAUDIO ioctl.
> [..]

  :... [snd.science] ...:
 ::
 :: http://www.korseby.net
 :: http://gsmp.sf.net
  :.........................:: ~/$ kristian@korseby.net :
