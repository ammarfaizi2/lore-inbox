Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288936AbSANTHM>; Mon, 14 Jan 2002 14:07:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288946AbSANTFj>; Mon, 14 Jan 2002 14:05:39 -0500
Received: from [208.29.163.248] ([208.29.163.248]:51880 "HELO
	warden.diginsite.com") by vger.kernel.org with SMTP
	id <S288801AbSANTEX>; Mon, 14 Jan 2002 14:04:23 -0500
From: David Lang <david.lang@digitalinsight.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: esr@thyrsus.com, babydr@baby-dragons.com, cate@debian.org,
        linux-kernel@vger.kernel.org
Date: Mon, 14 Jan 2002 10:57:19 -0800 (PST)
Subject: Re: Hardwired drivers are going away?
In-Reply-To: <E16QCPK-0002Yt-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.40.0201141055410.22904-100000@dlang.diginsite.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Jan 2002, Alan Cox wrote:

> > 1. security, if you don't need any modules you can disable modules entirly
> > and then it's impossible to add a module without patching the kernel first
> > (the module load system calls aren't there)
>
> Urban legend.
>

If this is the case then why do I get systemcall undefined error messages
when I make a mistake and attempt to load a module on a kernel without
modules enabled?

> > 2. speed, there was a discussion a few weeks ago pointing out that there
> > is some overhead for useing modules (far calls need to be used just in
> > case becouse the system can't know where the module will be located IIRC)
>
> I defy you to measure it on x86

during the discussion a few weeks ago there were people pointing out cases
where this overhead would be a problem.

> > 3. simplicity in building kernels for other machines. with a monolithic
> > kernel you have one file to move (and a bootloader to run) with modules
> > you have to move quite a few more files.
>
> tar or nfs mount; make modules_install.
>
not on my firewalls thank you.

David Lang
