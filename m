Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266088AbRGGLMN>; Sat, 7 Jul 2001 07:12:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266091AbRGGLMD>; Sat, 7 Jul 2001 07:12:03 -0400
Received: from logger.gamma.ru ([194.186.254.23]:49673 "EHLO logger.gamma.ru")
	by vger.kernel.org with ESMTP id <S266088AbRGGLL4>;
	Sat, 7 Jul 2001 07:11:56 -0400
To: linux-kernel@vger.kernel.org
Path: pccross!not-for-mail
From: crosser@average.org (Eugene Crosser)
Newsgroups: linux.kernel
Subject: Re: [Acpi] Re: ACPI fundamental locking problems
Date: 7 Jul 2001 14:32:42 +0400
Organization: Average
Message-ID: <9i6oga$jk1$1@pccross.average.org>
In-Reply-To: <Pine.LNX.4.33.0107040956310.1668-100000@penguin.transmeta.com>
Mime-Version: 1.0
X-Newsreader: knews 0.9.8
X-Comment-To: Linus Torvalds <torvalds@transmeta.com>
Content-Type: text/plain; charset=koi8-r
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <Pine.LNX.4.33.0107040956310.1668-100000@penguin.transmeta.com>,
        Linus Torvalds <torvalds@transmeta.com> writes:

> I don't like the current initrd very much myself, I have to admit. I'm not
> going to accept a "you have to have a ramdisk" approach - I think the
> ramdisks are really broken.
> 
> But I've seen a "populate ramfs from a tar-file built into 'bzImage'"
> patch somewhere, and that would be a whole lot more palatable to me.

Doesn't the approach "treat a chunk of data built into bzImage as
populated ramfs" look cleaner?  No need to fiddle with tar format,
no copying data from place to place.

Eugene
