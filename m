Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315430AbSEQFzY>; Fri, 17 May 2002 01:55:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315431AbSEQFzX>; Fri, 17 May 2002 01:55:23 -0400
Received: from violet.setuza.cz ([194.149.118.97]:31502 "EHLO violet.setuza.cz")
	by vger.kernel.org with ESMTP id <S315430AbSEQFzW>;
	Fri, 17 May 2002 01:55:22 -0400
Subject: Re: counters
From: Frank Schaefer <frank.schafer@setuza.cz>
To: linux-kernel@vger.kernel.org
In-Reply-To: <3CE3BECB.FF1AE6A@ail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0 (Preview Release)
Date: 17 May 2002 07:55:23 +0200
Message-Id: <1021614923.253.0.camel@ADMIN>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-05-16 at 16:14, Manik Raina wrote:
> anyone knows if there are counters in the linux kernel
> which can be read via /proc like mechanism for the
> following :
> 
> 1. total number of bytes read by process by syscalls
> like read()
> 
> 2. total number of bytes written by each process by
> syscalls like write()

Hi,

as far as I know there's not a ready to use counter in the procfs.

BTW: What do you want to count? Do You mean timers?

It shouldn't be a problem, to write a little driver, which could make
this available.

Regards
Frank

