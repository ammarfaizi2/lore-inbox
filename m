Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289579AbSAOOZm>; Tue, 15 Jan 2002 09:25:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289573AbSAOOZd>; Tue, 15 Jan 2002 09:25:33 -0500
Received: from warden.digitalinsight.com ([208.29.163.2]:25047 "HELO
	warden.diginsite.com") by vger.kernel.org with SMTP
	id <S289642AbSAOOZU>; Tue, 15 Jan 2002 09:25:20 -0500
Date: Tue, 15 Jan 2002 06:25:07 -0800 (PST)
From: David Lang <dlang@diginsite.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Hardwired drivers are going away? 
In-Reply-To: <200201151045.g0FAjduU002847@tigger.cs.uni-dortmund.de>
Message-ID: <Pine.LNX.4.40.0201150620430.23491-100000@dlang.diginsite.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

one other thing re: simplicity.

bootloaders

I know that many of you who are advocating this new approach despise lilo,
but for many people it does the job just fine. with the new approach when
switching between kernels you now not only need to switch the kernel
images, but also the initrd (or equivalent) images.

also don't forget that the current way of storing modules can have
problems when some kernel comile options change (SMP for example, but IIRC
there are others) if you make modules mandatory you will have to fix this
first.

David Lang


>
> > > > 3. simplicity in building kernels for other machines. with a monolithic
> > > > kernel you have one file to move (and a bootloader to run) with modules
> > > > you have to move quite a few more files.
>
