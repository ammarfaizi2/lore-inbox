Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279580AbRKATFy>; Thu, 1 Nov 2001 14:05:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279581AbRKATFo>; Thu, 1 Nov 2001 14:05:44 -0500
Received: from wks-40.herta.ronnebyhus.se ([195.17.80.49]:54409 "EHLO
	wks-40.herta.ronnebyhus.se") by vger.kernel.org with ESMTP
	id <S279580AbRKATFf>; Thu, 1 Nov 2001 14:05:35 -0500
Date: Thu, 1 Nov 2001 20:05:29 +0100 (CET)
From: =?iso-8859-1?Q?Per_Lid=E9n?= <per@fukt.bth.se>
X-X-Sender: per@wks-40.herta.ronnebyhus.se
To: linux-kernel@vger.kernel.org
Subject: Re: "unkillable processes" in linux 2.4.11 to 2.4.14-pre6
In-Reply-To: <3BE194BB.7090207@softhome.net>
Message-ID: <Pine.LNX.4.40.0111011959340.3622-100000@wks-40.herta.ronnebyhus.se>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I have the exact same problem and it all started with 2.4.11. All I've
managed to find out is that it's related to the devfs symlink semaphores.

/Per

On Thu, 1 Nov 2001, Ricardo Martins wrote:

> I'm using Linux kernel 2.4.10, and since the fatidic 2.4.11 release ( i
> tried 2.4.11 (one day :)))) 2.4.12, 2.4.13 and 2.4.14-pre6) I get the
> same bug on and on (that means I can reproduce the experience and obtain
> the same results).
>
> Procedure
> In X windows (version 4.1.0 compiled from the sources) when writing
> "exit" in xterm to close the terminal emulator, the window freezes, and
> from that moment on, every process becomes "unkillable", including xterm
> and X (ps also freezes), and there's no way to shutdown GNU/Linux in a
> sane way (must hit reset or poweroff).
>
> Environment
> I used Glibc 2.2.4 and GCC 3.0.1 (tried with 2.95.3, obtained the same
> results).
>
> The odd thing is, that with the same configuration, kernel 2.4.10 works
> just fine, but every other release since then ends up doing the same
> thing (the system can't maintain integrity after writing "exit" and
> hiting enter in xterm).
>
> Please help me, I getting slightly mad with the situation.
>
> Ricardo Martins
>

