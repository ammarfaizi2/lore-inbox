Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277291AbRJEBE7>; Thu, 4 Oct 2001 21:04:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277292AbRJEBEt>; Thu, 4 Oct 2001 21:04:49 -0400
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:52731
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S277291AbRJEBEn>; Thu, 4 Oct 2001 21:04:43 -0400
Date: Thu, 4 Oct 2001 18:05:03 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [POT] Which journalised filesystem ?
Message-ID: <20011004180503.A576@mikef-linux.matchmail.com>
Mail-Followup-To: Linus Torvalds <torvalds@transmeta.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.10.10110031648250.20425-100000@coffee.psychology.mcmaster.ca> <E15pHJT-00041q-00@calista.inka.de> <9pir9h$ief$1@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9pir9h$ief$1@penguin.transmeta.com>
User-Agent: Mutt/1.3.22i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 04, 2001 at 11:27:45PM +0000, Linus Torvalds wrote:
> We (as in Linux) should make sure that we explicitly tell the disk when
> we need it to flush its disk buffers. We don't do that right, and
> because of _our_ problems some people claim that writeback caching is
> evil and bad.
>

Actually, their claim is that most drives won't even *honor* the request to
sync to oxide.

Once the number of drives that support this goes up, then write cache is
safe to use...

Personally, I have a script that enables write cache, and sets the drive to
its highest dma level on boot...

Mike
