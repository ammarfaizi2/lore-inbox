Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278099AbRKDDi3>; Sat, 3 Nov 2001 22:38:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278120AbRKDDiU>; Sat, 3 Nov 2001 22:38:20 -0500
Received: from saturn.cs.uml.edu ([129.63.8.2]:13828 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S278099AbRKDDiI>;
	Sat, 3 Nov 2001 22:38:08 -0500
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200111040337.fA43bl6181351@saturn.cs.uml.edu>
Subject: Re: Module Licensing?
To: riel@conectiva.com.br (Rik van Riel)
Date: Sat, 3 Nov 2001 22:37:47 -0500 (EST)
Cc: ttabi@interactivesi.com (Timur Tabi), alan@lxorguk.ukuu.org.uk (Alan Cox),
        linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33L.0110311505160.2963-100000@imladris.surriel.com> from "Rik van Riel" at Oct 31, 2001 03:10:13 PM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik van Riel writes:
> On Wed, 31 Oct 2001, Timur Tabi wrote:

>> The fact that the open source portions and the closed source
>> portions can't function on their own is irrelevant, IMHO.
...
> Since your program, which happens to consist of one open
> source part and one proprietary part, is partly a derived
> work from the kernel source (by using kernel header files
> and the inline functions in it) your whole work must be
> distributed under the GPL.

You could define a generic device driver interface.
Let's call it UDI. Now you implement a GPL version of
this for Linux, a 2-clause BSD version for FreeBSD,
and a proprietary version for Windows. You then write a
few drivers using this interface, under a half-dozen
different licenses.

One of those drivers is proprietary. It can run in the
Linux kernel. It sure isn't derived from Linux though.
There isn't any Linux code in it, and the driver works
in the Windows and FreeBSD kernels as well as in Linux.

There you go: use of GPL symbols from a non-GPL driver.

(usual disclaimer applies: not legal advice, see a lawyer)
