Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315167AbSEFUyP>; Mon, 6 May 2002 16:54:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315170AbSEFUyO>; Mon, 6 May 2002 16:54:14 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:4879 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S315167AbSEFUyO>;
	Mon, 6 May 2002 16:54:14 -0400
Message-ID: <3CD6ED34.3D676EBF@zip.com.au>
Date: Mon, 06 May 2002 13:53:08 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "David D. Hagood" <wowbagger@sktc.net>
CC: Justin Piszcz <war@starband.net>, linux-kernel@vger.kernel.org
Subject: Re: Linux & X11 & IRQ Interrupts
In-Reply-To: <3CD5D57D.DED89DFC@starband.net> <3CD5DD6D.60800@sktc.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"David D. Hagood" wrote:
> ...
> If this bothers you, you could try getting another power supply (one
> that is "stiffer" and less prone to voltage sag) or you could run a
> program like Seti@home or Distributed.Net and keep your CPU busy all the
> time.

You can just add `idle=poll' to the kernel boot command line.
Then the CPU will not be halted, and there will be less
variation in the current.

-
