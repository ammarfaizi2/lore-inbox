Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268526AbTBOD6s>; Fri, 14 Feb 2003 22:58:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268527AbTBOD6s>; Fri, 14 Feb 2003 22:58:48 -0500
Received: from almesberger.net ([63.105.73.239]:46607 "EHLO
	host.almesberger.net") by vger.kernel.org with ESMTP
	id <S268526AbTBOD6r>; Fri, 14 Feb 2003 22:58:47 -0500
Date: Sat, 15 Feb 2003 01:08:37 -0300
From: Werner Almesberger <wa@almesberger.net>
To: Davide Libenzi <davidel@xmailserver.org>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Synchronous signal delivery..
Message-ID: <20030215010837.D2791@almesberger.net>
References: <Pine.LNX.4.44.0302131120280.2076-100000@home.transmeta.com> <Pine.LNX.4.50.0302131215140.1869-100000@blue1.dev.mcafeelabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.50.0302131215140.1869-100000@blue1.dev.mcafeelabs.com>; from davidel@xmailserver.org on Thu, Feb 13, 2003 at 12:22:06PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Davide Libenzi wrote:
> What do you think about having timers through a file interface ?

Maybe I'm missing something obvious, but couldn't you simply
do this with a signal handler that writes to (a) pipe(s) ?

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, Buenos Aires, Argentina         wa@almesberger.net /
/_http://www.almesberger.net/____________________________________________/
