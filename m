Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262496AbTEFKCX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 06:02:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262497AbTEFKCX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 06:02:23 -0400
Received: from inpbox.inp.nsk.su ([193.124.167.24]:30658 "EHLO
	inpbox.inp.nsk.su") by vger.kernel.org with ESMTP id S262496AbTEFKCW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 06:02:22 -0400
Date: Tue, 6 May 2003 17:06:38 +0700
From: "Dmitry A. Fedorov" <D.A.Fedorov@inp.nsk.su>
Reply-To: D.A.Fedorov@inp.nsk.su
To: Yoav Weiss <ml-lkml@unpatched.org>
cc: terje.eggestad@scali.com, 76306.1226@compuserve.com,
       linux-kernel@vger.kernel.org
Subject: Re: The disappearing sys_call_table export.
In-Reply-To: <Pine.LNX.4.44.0305061133290.2977-100000@marcellos.corky.net>
Message-ID: <Pine.SGI.4.10.10305061642310.8255699-100000@Sky.inp.nsk.su>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 May 2003, Yoav Weiss wrote:

> > But how? When some global will not be exported, it would not be listed
> > in /proc/ksyms.
> 
> So what ?
> You just find the right address (in this case by getting the addresses of
> exported syscalls and finding a list in memory, containing them in the
> right order), and cast it to be the syscall table.  

Thank, now I understand it. And I would not do that.

> it from some exported symbol, and automagically create a module that
> re-exports this symbol for your legacy driver to use.

All of my drivers are not legacy or binary-only.
Under "third-party driver" in my other posts I was mean just out of
kernel source tree software which are have no reasons to be included in
the kernel sources.

I just need legal kernel mechanisms to do some "strange" things,
nothing else.

> If you write the script, don't forget to GPL it :)

I will not make such script.

