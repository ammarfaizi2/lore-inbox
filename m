Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316465AbSEUAgH>; Mon, 20 May 2002 20:36:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316467AbSEUAgG>; Mon, 20 May 2002 20:36:06 -0400
Received: from kweetal.tue.nl ([131.155.2.7]:12533 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id <S316465AbSEUAgF>;
	Mon, 20 May 2002 20:36:05 -0400
Date: Tue, 21 May 2002 02:36:04 +0200
From: Guest section DW <dwguest@win.tue.nl>
To: Bill Davidsen <davidsen@tmr.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Miquel van Smoorenburg <miquels@cistron.nl>,
        linux-kernel@vger.kernel.org
Subject: Re: IO stats in /proc/partitions
Message-ID: <20020521003604.GA400@win.tue.nl>
In-Reply-To: <E17899v-0003Cl-00@the-village.bc.nu> <Pine.LNX.3.96.1020520141820.29156A-100000@gatekeeper.tmr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 20, 2002 at 02:19:48PM -0400, Bill Davidsen wrote:
> On Thu, 16 May 2002, Alan Cox wrote:

> > Pretty much every vendor shipped the /proc/partitions changes and
> > has tools that will look for them. Its annoying to change stuff but
> > long term /proc/partitions is the wrong place for disk stats

>   Changes belong in 2.5, /proc/partitions is the wrong place, but it's
> also the place the tools expect. I hope that's not going to change in the
> stable kernel.

You misunderstand.
Everybody agrees that /proc/partitions is the wrong place.
Up to now these statistics have not been part of any official
kernel, stable or not.
However, someone wanted to introduce them for the first time
in 2.4.19 and put them in /proc/partitions. That is a really bad idea,
especially when they will be somewhere else in 2.5.

Andries
