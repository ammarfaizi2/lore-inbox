Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279512AbRJ2Uyn>; Mon, 29 Oct 2001 15:54:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279515AbRJ2Uyd>; Mon, 29 Oct 2001 15:54:33 -0500
Received: from zero.tech9.net ([209.61.188.187]:48651 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S279512AbRJ2UyW>;
	Mon, 29 Oct 2001 15:54:22 -0500
Subject: Re: [BUG] Smbfs + preempt on 2.4.10
From: Robert Love <rml@tech9.net>
To: J Sloan <jjs@lexus.com>
Cc: vda <vda@port.imtp.ilyichevsk.odessa.ua>,
        linux kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <3BDDA646.B5D0E526@lexus.com>
In-Reply-To: <01102919120800.05333@nemo>  <3BDDA646.B5D0E526@lexus.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.16.99+cvs.2001.10.28.13.59 (Preview Release)
Date: 29 Oct 2001 15:53:32 -0500
Message-Id: <1004388815.805.11.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2001-10-29 at 13:56, J Sloan wrote:
> vda wrote:
> > I narrowed down Samba weirdness I observe on 2.4.10 to preempt patch.
> > Plain 2.4.10 works fine, 2.4.10+preempt (with latency measurement turned on)
> > is sometimes oopses, and sometimes reports 'file already exists' when I
> > attempt to copy a file from WinNT box to Linux. Sometimes it works ok
> > (50% or so...)
>
> Why not try a recent kernel + preempt?

Yes, would you mind retesting on a recent kernel and a recent patch?

Patches for kernels as old as 2.4.12 and as recent as the current
pre-releases are available at:

	http://tech9.net/rml/linux/

I use samba myself a _lot_ here and I have not observed any problems,
even with our older patches... although I don't copy NT->Linux very
often.

	Robert Love

