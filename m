Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262858AbRE0SdS>; Sun, 27 May 2001 14:33:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262859AbRE0SdI>; Sun, 27 May 2001 14:33:08 -0400
Received: from twilight.cs.hut.fi ([130.233.40.5]:55354 "EHLO
	twilight.cs.hut.fi") by vger.kernel.org with ESMTP
	id <S262858AbRE0Scx>; Sun, 27 May 2001 14:32:53 -0400
Date: Sun, 27 May 2001 21:32:41 +0300
From: Ville Herva <vherva@mail.niksula.cs.hut.fi>
To: "crisper@optonline.net" <crisper@optonline.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.4-ac17-2.4.5-ac1 oops in swapper process
Message-ID: <20010527213241.J11981@niksula.cs.hut.fi>
In-Reply-To: <0GE000F4IAVM20@mta4.srv.hcvlny.cv.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <0GE000F4IAVM20@mta4.srv.hcvlny.cv.net>; from crisper@optonline.net on Sun, May 27, 2001 at 02:18:57PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 27, 2001 at 02:18:57PM -0400, you [crisper@optonline.net] claimed:
> All,
> 
> I have been getting a oops ever since 2.4.4-ac17 right after the kernel loads
> the sym53c895 driver.	I hand copied part of the oops before rebooting.  This
> happens in every kernel since 2.4.4-ac17.  I have changed my compiler from
> gcc-2.96 to egcs-1.12, thinking that the Mandrake gcc was bad.	 I still see
> the same problems at the exact same point even after recompilation.
> 
> ce at virtual address 00000296
> print eip: c017f5d6
> *pde: 00000000
> Oops 0000
> CPU: 0
> 
> EIP: 0010:[<c017f5d6>]
> eflags: 0010202
> eax: 00000286 ebx: 00001261 ecx: 00000000 edx: dfff3d74
> csi: 00000000 edi: dfe66da0 ebp: dfe 63160 esp: dfff3d54 
> ds: 0018 es: 0018 ss: 0018
> process swapper pid 1, stackpage=dfff3000

I think I'm seeing the same; see
http://marc.theaimsgroup.com/?l=linux-kernel&m=99079948404775&w=2
 
Hmm, I have sym53c895 as well, but I thought this was initrd related. 

> thats all I got, I can try again and copy down any other information from that
> oops that may be useful.   Should I copy the whole thing and then put it
> through ksymoops? 

Definetely.



-- v --

v@iki.fi
