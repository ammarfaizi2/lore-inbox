Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135427AbRD3P5c>; Mon, 30 Apr 2001 11:57:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135413AbRD3P5W>; Mon, 30 Apr 2001 11:57:22 -0400
Received: from hees.nijmegen.inter.nl.net ([193.67.237.8]:15762 "EHLO
	hees.nijmegen.inter.nl.net") by vger.kernel.org with ESMTP
	id <S135427AbRD3P5L>; Mon, 30 Apr 2001 11:57:11 -0400
Date: Mon, 30 Apr 2001 17:57:49 +0200
From: Frank van Maarseveen <F.vanMaarseveen@inter.NL.net>
To: Brian Gerst <bgerst@didntduck.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.4 Oops
Message-ID: <20010430175749.A1456@iapetus.localdomain>
In-Reply-To: <20010430164631.A968@iapetus.localdomain> <3AED7FA9.442F2F4E@didntduck.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0i
In-Reply-To: <3AED7FA9.442F2F4E@didntduck.org>; from bgerst@didntduck.org on Mon, Apr 30, 2001 at 11:07:21AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 30, 2001 at 11:07:21AM -0400, Brian Gerst wrote:
> > Code;  c021b5f6 <__generic_copy_from_user+3a/64>   <=====
> >    0:   f3 a5                     repz movsl %ds:(%esi),%es:(%edi)   <=====
> 
> There should be no way for this to cause an oops.  There should be an
> exception handler here that will catch the page fault and deal with it. 
> It appears that the exception table might be corrupted.  What compiler
> are you using?

iapetus ~ gcc -v
Reading specs from /usr/lib/gcc-lib/i386-redhat-linux/egcs-2.91.66/specs
gcc version egcs-2.91.66 19990314/Linux (egcs-1.1.2 release)

(from RH 6.1)

-- 
Frank
