Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279824AbRKMXnX>; Tue, 13 Nov 2001 18:43:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279839AbRKMXnO>; Tue, 13 Nov 2001 18:43:14 -0500
Received: from cerebus.wirex.com ([65.102.14.138]:34812 "EHLO
	figure1.int.wirex.com") by vger.kernel.org with ESMTP
	id <S279824AbRKMXnC>; Tue, 13 Nov 2001 18:43:02 -0500
Date: Tue, 13 Nov 2001 15:35:21 -0800
From: Chris Wright <chris@marcelothewonderpenguin.com>
To: Adam Schrotenboer <ajschrotenboer@lycosmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel 2.4.15-pre4 compile error (gcc 2.95.3 and 3.0[12])
Message-ID: <20011113153521.C30898@figure1.int.wirex.com>
Mail-Followup-To: Adam Schrotenboer <ajschrotenboer@lycosmail.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20011113221754.09CB0FB80D@tabris.domedata.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011113221754.09CB0FB80D@tabris.domedata.com>; from ajschrotenboer@lycosmail.com on Tue, Nov 13, 2001 at 05:17:51PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Adam Schrotenboer (ajschrotenboer@lycosmail.com) wrote:
> Please forgive me if this is already in the archives, my usual archive is 
> down (www.lib.uaa.alaska.edu) and I find MARC a bit hard to follow
> 
> When compiling 2.4.15-pre4 I get the following error 
> 
> gcc -D__KERNEL__ -I/mnt/hda3/kernel/2.4.15-pre4/linux/include -Wall- 
> Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer 
> -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 
> -march=i686 -malign-functions=4     -c -o setup.o setup.c
> setup.c: In function `c_start':
> setup.c:2791: subscripted value is neither array nor pointer
> setup.c:2792: warning: control reaches end of non-void function
> make[1]: *** [setup.o] Error 1

this is in the archives.  you'll find a patch here:

http://marc.theaimsgroup.com/?l=linux-kernel&m=100559812101821&w=2

cheers,
-chris
