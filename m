Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289116AbSBDQ1I>; Mon, 4 Feb 2002 11:27:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289062AbSBDQ0z>; Mon, 4 Feb 2002 11:26:55 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:2062 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S289096AbSBDQ0n>; Mon, 4 Feb 2002 11:26:43 -0500
Message-ID: <3C5EB634.7080902@zytor.com>
Date: Mon, 04 Feb 2002 08:26:28 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6) Gecko/20011120
X-Accept-Language: en-us, en, sv
MIME-Version: 1.0
To: Werner Almesberger <wa@almesberger.net>
CC: "Eric W. Biederman" <ebiederm@xmission.com>,
        "Erik A. Hendriks" <hendriks@lanl.gov>,
        Andrew Morton <akpm@zip.com.au>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] x86 ELF bootable kernels/Linux booting Linux/LinuxBIOS
In-Reply-To: <3C58B078.3070803@zytor.com> <m1vgdjb0x0.fsf@frodo.biederman.org> <3C58CAE0.4040102@zytor.com> <20020131103516.I26855@lanl.gov> <m1elk6t7no.fsf@frodo.biederman.org> <3C59DB56.2070004@zytor.com> <m1r8o5a80f.fsf@frodo.biederman.org> <3C5A5F25.3090101@zytor.com> <m1hep19pje.fsf@frodo.biederman.org> <3C5ADDD1.6000608@zytor.com> <20020204134927.A5079@almesberger.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Werner Almesberger wrote:

  [...lots of good stuff...]

> 
> Worse yet, the file-based interface kind of conveys the promise that
> the preloader is actually not necessary. This creates an incentive to
> keep things that way, so more and more policy will have to be added
> to the kernel, simply because externalizing it would shatter that
> cute "loader-less" image.
> 

  [...]

> 
> So, while a file-based interface looks cool, I think a "thin"
> memory-based interface will serve us better in the long run.
> 


I agree with this sentiment.  As far as the filebased interface implying 
it is self-contained/loaderless, we can just look at this thread as well 
as Linux history -- the boot sector in a Linux kernel is basically 
useless and doesn't even work on a lot of hardware today, yet people are 
still refusing to deprecate it "because it's so convenient"...

	-hpa



