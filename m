Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313505AbSEPQIQ>; Thu, 16 May 2002 12:08:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313558AbSEPQIP>; Thu, 16 May 2002 12:08:15 -0400
Received: from [195.223.140.120] ([195.223.140.120]:3912 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S313505AbSEPQIP>; Thu, 16 May 2002 12:08:15 -0400
Date: Thu, 16 May 2002 18:07:54 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Juan Quintela <quintela@mandrakesoft.com>
Cc: Rik van Riel <riel@conectiva.com.br>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.19pre8aa3
Message-ID: <20020516160754.GR1025@dualathlon.random>
In-Reply-To: <20020516020134.GC1025@dualathlon.random> <Pine.LNX.4.44L.0205152303500.32261-100000@imladris.surriel.com> <20020516023238.GE1025@dualathlon.random> <m2g00s8mt2.fsf@demo.mitica>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 16, 2002 at 11:27:37AM +0200, Juan Quintela wrote:
> I am missing something, or how do you pass the notail option to your
> reiserfs rootfs when the initrd is ext2.

fair enough (the new initrd API allows that, but it's very ugly that it
is not dynamic from a kernel param like rootfstype would be, but it
instead has to be written on disk within the initrd), however as said
that's all due the brokeness of the rootfs params, they should apply
only to the fianl real root dev, never to the initrd.

Andrea
