Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290164AbSAWWaS>; Wed, 23 Jan 2002 17:30:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290181AbSAWWaI>; Wed, 23 Jan 2002 17:30:08 -0500
Received: from wireless90.cs.wisc.edu ([128.105.48.190]:51099 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S290164AbSAWW37>; Wed, 23 Jan 2002 17:29:59 -0500
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc: Mike Coleman <mkc@mathdogs.com>, marcelo@conectiva.com.br,
        linux-kernel@vger.kernel.org, torvalds@transmeta.com,
        alan@lxorguk.ukuu.org.uk
Subject: Re: [PATCH] ptrace on stopped processes (2.4)
In-Reply-To: <m3adwc9woz.fsf@localhost.localdomain>
	<87g0632lzw.fsf@mathdogs.com> <m3advcq5jv.fsf@localhost.localdomain>
	<878zawvl1v.fsf@devron.myhome.or.jp>
	<m3sn8xkkyn.fsf@localhost.localdomain>
	<87r8ogr9za.fsf@devron.myhome.or.jp>
From: vic <zandy@cs.wisc.edu>
Date: Wed, 23 Jan 2002 16:29:52 -0600
In-Reply-To: <87r8ogr9za.fsf@devron.myhome.or.jp> (OGAWA Hirofumi's message
 of "Thu, 24 Jan 2002 07:14:17 +0900")
Message-ID: <m33d0wlmzj.fsf@localhost.localdomain>
User-Agent: Gnus/5.090004 (Oort Gnus v0.04) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> PTRACE_SYSCALL, PTRACE_CONT, and PTRACE_SINGLESTEP can't send a signal
> by the same reason. Please read the do_signal().

I've read that function, but I don't see why it would not get along
with my suggestion to send SIGKILL rather than set exit_code to
implement PTRACE_KILL.

No doubt I can be rather thick; in this case, induction doesn't help me.
