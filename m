Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276632AbRJPSrD>; Tue, 16 Oct 2001 14:47:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276634AbRJPSqz>; Tue, 16 Oct 2001 14:46:55 -0400
Received: from fungus.teststation.com ([212.32.186.211]:2064 "EHLO
	fungus.teststation.com") by vger.kernel.org with ESMTP
	id <S276632AbRJPSqn>; Tue, 16 Oct 2001 14:46:43 -0400
Date: Tue, 16 Oct 2001 20:47:00 +0200 (CEST)
From: Urban Widmark <urban@teststation.com>
To: vda <vda@port.imtp.ilyichevsk.odessa.ua>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Creating files on Samba got weird
In-Reply-To: <5913527831.20011016122411@port.imtp.ilyichevsk.odessa.ua>
Message-ID: <Pine.LNX.4.30.0110162020550.1963-100000@cola.teststation.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Oct 2001, vda wrote:

> My Samba server behaves strangely.

You are confusing me with someone that knows something about samba as a
server (or restore_sigcontext :)

> It seems that smbd dies after it has created dir/file but before
> reporting this fact to the client. New smbd gets spawned by inetd
> then.

If a syscall crashes I think you can't blame smbd for causing strange
effects for the client. I think you should "hunt" the kernel crash first,
if smbd still acts funny when the kernel doesn't crash ask for help on the
samba@samba.org maillist.


> Samba: 2.2.1a
> Kernel: 2.4.10

Try repeating the problem with 2.4.13-pre3 (or whatever the latest may be)
and if you can do that post another decoded oops of that, with a subject
containing the words "Oops" and "restore_sigcontext" (if that is still in
the decoded oops).

That will hopefully make your message reach the right audience. You may
also have a look at REPORTING-BUGS for hints on how to list your system
cfg.

Samba 2.2.2 is just out, but I don't think upgrading will help.


> Also I've got two oopses so far. One of them decoded below
> (my first ksymoops, I don't know is it done right on not)

Looks fine, not that it tells me much. It usually disassembles the part
where it crashes and that can be helpful to people that know the code
in question. Not sure why it didn't here, did you edit it out?

/Urban

