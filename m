Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316764AbSFJIFO>; Mon, 10 Jun 2002 04:05:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316776AbSFJIFN>; Mon, 10 Jun 2002 04:05:13 -0400
Received: from mail.zmailer.org ([62.240.94.4]:19603 "EHLO mail.zmailer.org")
	by vger.kernel.org with ESMTP id <S316764AbSFJIFN>;
	Mon, 10 Jun 2002 04:05:13 -0400
Date: Mon, 10 Jun 2002 11:05:13 +0300
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: Robert PipCA <robertpipca@yahoo.com>
Cc: vortex@scyld.com, linux-kernel@vger.kernel.org
Subject: Re: MTU discovery
Message-ID: <20020610110513.I18899@mea-ext.zmailer.org>
In-Reply-To: <20020610074507.69402.qmail@web21301.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 10, 2002 at 12:45:07AM -0700, Robert PipCA wrote:
>   Hi,
>   I'm working on a project that require knowing the max MTU size
> supported by the 3Com PCI 3c905C (Boomerang).
> The datasheet provided by 3Com does not mention it, and I already
> did the usual google search, but didn't find it neither.
> Does anyone knows a "generic way" of knowing this (or chip-specific)?

  Oh, it is mentioned there, although not with that name.

  The Ethernet Standard (IEEE 802.3) specifies that the frame size
  shall be 1500 octets.   That is the NORMAL CASE max MTU value for
  all ethernet devices.

  Some devices do, however, support reception (and transmit) of what
  is called "jumbograms".  With boomerang you can set a register
  to contain the limit value.  Alternatively with boomerang, and
  its predecessors, you can set a bit to accept extra-large frames.

  I recall the ultimate limit is in order of 4kB.

>   Thanks in advance.
> --Robert

/Matti Aarnio
