Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290911AbSAaElx>; Wed, 30 Jan 2002 23:41:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290914AbSAaEln>; Wed, 30 Jan 2002 23:41:43 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:53003 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S290911AbSAaEla>; Wed, 30 Jan 2002 23:41:30 -0500
Message-ID: <3C58CAE0.4040102@zytor.com>
Date: Wed, 30 Jan 2002 20:41:04 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6) Gecko/20011120
X-Accept-Language: en-us, en, sv
MIME-Version: 1.0
To: "Eric W. Biederman" <ebiederm@xmission.com>
CC: Andrew Morton <akpm@zip.com.au>, linux-kernel@vger.kernel.org,
        Werner Almesberger <wa@almesberger.net>,
        "Erik A. Hendriks" <hendriks@lanl.gov>
Subject: Re: [RFC] x86 ELF bootable kernels/Linux booting Linux/LinuxBIOS
In-Reply-To: <m1elk7d37d.fsf@frodo.biederman.org>	<3C586355.A396525B@zip.com.au> <m1zo2vb5rt.fsf@frodo.biederman.org>	<3C58B078.3070803@zytor.com> <m1vgdjb0x0.fsf@frodo.biederman.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric W. Biederman wrote:

> 
> I am reluctant to go with a bootimg like interface because having a
> standard format encourages people to standardize.  Though a good
> argument can persuade me.  I don't loose any flexibility in comparison
> to bootimg because composing files on the fly is not significantly
> harder than composing a bootable image in ram. 
> 
> Please tell me if I haven't clearly answered your concerns about
> being locked into a single image.
> 


I have to think about it.  I'm not convinced that this particular 
flavour of standardization is a step in the right direction -- in fact, 
it is *guaranteed* to provide significant additional complexity for 
bootloaders, and bzImage support is still going to have to be provided 
for the forseeable future.  Since you express that it will basically be 
necessary to stitch the ELF file together on the fly I don't see much 
point, quite frankly; it seems like extra complexity for no good reason.

	-hpa


