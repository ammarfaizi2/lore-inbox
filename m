Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316530AbSHBRLZ>; Fri, 2 Aug 2002 13:11:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316545AbSHBRLZ>; Fri, 2 Aug 2002 13:11:25 -0400
Received: from pc-62-30-255-50-az.blueyonder.co.uk ([62.30.255.50]:37523 "EHLO
	kushida.apsleyroad.org") by vger.kernel.org with ESMTP
	id <S316530AbSHBRKe>; Fri, 2 Aug 2002 13:10:34 -0400
Date: Fri, 2 Aug 2002 18:13:01 +0100
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Benjamin LaHaise <bcrl@redhat.com>, Roman Zippel <zippel@linux-m68k.org>,
       David Woodhouse <dwmw2@infradead.org>,
       David Howells <dhowells@redhat.com>, alan@redhat.com,
       linux-kernel@vger.kernel.org
Subject: Re: manipulating sigmask from filesystems and drivers
Message-ID: <20020802181300.B29814@kushida.apsleyroad.org>
References: <20020802120040.A25119@redhat.com> <Pine.LNX.4.44.0208020920120.18265-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0208020920120.18265-100000@home.transmeta.com>; from torvalds@transmeta.com on Fri, Aug 02, 2002 at 09:27:41AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> Sending somebody a SIGKILL (or any signal that kills the process) is
> different (in my opinion) from a signal that interrupts a system call in
> order to run a signal handler.

So it's ok to have truncated log entries (or more realistically,
truncated simple database entries) if the logging program is killed?

-- Jamie
