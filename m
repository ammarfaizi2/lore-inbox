Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277138AbRJDGu1>; Thu, 4 Oct 2001 02:50:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277139AbRJDGuS>; Thu, 4 Oct 2001 02:50:18 -0400
Received: from bacon.van.m-l.org ([208.223.154.200]:28800 "EHLO
	bacon.van.m-l.org") by vger.kernel.org with ESMTP
	id <S277138AbRJDGuI>; Thu, 4 Oct 2001 02:50:08 -0400
Date: Thu, 4 Oct 2001 02:50:24 -0400 (EDT)
From: George Greer <greerga@m-l.org>
X-X-Sender: <greerga@bacon.van.m-l.org>
To: Linus Torvalds <torvalds@transmeta.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Security question: "Text file busy" overwriting executables but
 not shared libraries?
In-Reply-To: <9pgsk4$7ep$1@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.33.0110040247310.3686-100000@bacon.van.m-l.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Oct 2001, Linus Torvalds wrote:

>Which is why the kernel only allows it when the binary loader itself
>sets the flag, because security-conscious application writers are
>already aware of the "oh, a running binary may not be writable" issues.

One of the methods I tried to use to stop a fork()-bomb was to zero the
executable in question to force it to crash. No such luck, reboot it was.
Not that I can think of any other useful application of said behavior.

-- 
George Greer, greerga@m-l.org
http://www.m-l.org/~greerga/

