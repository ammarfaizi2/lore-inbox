Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290958AbSAaF7v>; Thu, 31 Jan 2002 00:59:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290960AbSAaF7m>; Thu, 31 Jan 2002 00:59:42 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:19470 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S290958AbSAaF70>; Thu, 31 Jan 2002 00:59:26 -0500
Message-ID: <3C58DD2E.10106@zytor.com>
Date: Wed, 30 Jan 2002 21:59:10 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6) Gecko/20011120
X-Accept-Language: en-us, en, sv
MIME-Version: 1.0
To: "Eric W. Biederman" <ebiederm@xmission.com>
CC: Andrew Morton <akpm@zip.com.au>, linux-kernel@vger.kernel.org,
        Werner Almesberger <wa@almesberger.net>,
        "Erik A. Hendriks" <hendriks@lanl.gov>
Subject: Re: [RFC] x86 ELF bootable kernels/Linux booting Linux/LinuxBIOS
In-Reply-To: <m1elk7d37d.fsf@frodo.biederman.org>	<3C586355.A396525B@zip.com.au> <m1zo2vb5rt.fsf@frodo.biederman.org>	<3C58B078.3070803@zytor.com> <m1vgdjb0x0.fsf@frodo.biederman.org>	<3C58CAE0.4040102@zytor.com> <m1r8o7ayo3.fsf@frodo.biederman.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric W. Biederman wrote:

> 
> 3) Network Booting.
>    There is not much chance to change bootroms once they are flashed
>    so they like LinuxBIOS need a general purpose interface, so that can
>    handle whatever they need to boot.
> 


On this particular subject, I should point out that there is a standard 
for network bootroms on i386 platforms -- PXE.  Most PXE implementations 
out there suck rocks, but that's orthogonal -- they're still a lot 
easier to use than coming up with your own (and they will boot, ahem, 
other operating systems as well.)

Now, PXE is pretty limited usually boots a second-stage bootloader

That being said, it would be great to get an Open Source PXE 
implementation and driver collection.  I was hoping NILO 
(http://www.nilo.org/) would be it, but it seems to not be going 
anywhere.  I was for a while considering trying to turn Etherboot into a 
PXE kit.

	-hpa

