Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291802AbSBAPqx>; Fri, 1 Feb 2002 10:46:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291805AbSBAPqo>; Fri, 1 Feb 2002 10:46:44 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:11575 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S291802AbSBAPq2>; Fri, 1 Feb 2002 10:46:28 -0500
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: "Erik A. Hendriks" <hendriks@lanl.gov>, Andrew Morton <akpm@zip.com.au>,
        linux-kernel@vger.kernel.org, Werner Almesberger <wa@almesberger.net>
Subject: Re: [RFC] x86 ELF bootable kernels/Linux booting Linux/LinuxBIOS
In-Reply-To: <m1elk7d37d.fsf@frodo.biederman.org>
	<3C586355.A396525B@zip.com.au> <m1zo2vb5rt.fsf@frodo.biederman.org>
	<3C58B078.3070803@zytor.com> <m1vgdjb0x0.fsf@frodo.biederman.org>
	<3C58CAE0.4040102@zytor.com> <20020131103516.I26855@lanl.gov>
	<m1elk6t7no.fsf@frodo.biederman.org> <3C59DB56.2070004@zytor.com>
	<m1r8o5a80f.fsf@frodo.biederman.org> <3C5A5F25.3090101@zytor.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 01 Feb 2002 08:42:45 -0700
In-Reply-To: <3C5A5F25.3090101@zytor.com>
Message-ID: <m1hep19pje.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"H. Peter Anvin" <hpa@zytor.com> writes:

> Eric W. Biederman wrote:
> 
> > a) More complex.  Just barely.  b) Yep.
> > c) Yep.
> > d) More flexible and can handle what ever it needs to do tomorrow,
> >    without mods. All firmware has it's own different format.  With LinuxBIOS
> > things are
> > simple enough that you can add a make target instead of having to
> > write a specific bootloader to support it.
> >
> 
> 
> I cannot agree with you on (d).  In fact, you have already brushed off a
> multiple of issues I have raised, such as interactivity.

What is magic about interactivity?  What makes this a different
problem?  We approach booting from totally different perspectives,
which makes communicating clearly hard.  

If you spell out individual problems I will show you how I would solve
them.

I believe I have done my due diligence and provided appropriate
channels for everything, but I'm willing to test it.

> I don't particularly care if you want to make this the LinuxBIOS
> platform-specific whatever, but when you start talking about making it the grand
> universal thing, you have me seriously concerned.

Hey it isn't wrong to dream of world domination :)

Eric
