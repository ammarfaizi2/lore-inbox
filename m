Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290850AbSAaCtl>; Wed, 30 Jan 2002 21:49:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290848AbSAaCtV>; Wed, 30 Jan 2002 21:49:21 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:264 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S290846AbSAaCtA>; Wed, 30 Jan 2002 21:49:00 -0500
Message-ID: <3C58B078.3070803@zytor.com>
Date: Wed, 30 Jan 2002 18:48:24 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6) Gecko/20011120
X-Accept-Language: en-us, en, sv
MIME-Version: 1.0
To: "Eric W. Biederman" <ebiederm@xmission.com>
CC: Andrew Morton <akpm@zip.com.au>, linux-kernel@vger.kernel.org,
        Werner Almesberger <wa@almesberger.net>,
        "Erik A. Hendriks" <hendriks@lanl.gov>
Subject: Re: [RFC] x86 ELF bootable kernels/Linux booting Linux/LinuxBIOS
In-Reply-To: <m1elk7d37d.fsf@frodo.biederman.org>	<3C586355.A396525B@zip.com.au> <m1zo2vb5rt.fsf@frodo.biederman.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric W. Biederman wrote:

> 
>>It would be convenient to be able to directly boot a bzImage,
>>but I guess elf is workable.
> 
> Well that is directly booting vmlinux, and it doesn't lock you into
> booting the linux kernel which is very important to me. 
> 


Neither is bzImage... you can use bzImage format for other things.  My 
main worry about this is that it locks you into booting a single image 
(as opposed to kernel+initramfs, the latter of which can be composed on 
the fly if desirable), which is a huge step backwards IMNSHO.

	-hpa

