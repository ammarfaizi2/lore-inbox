Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135664AbRDSNXq>; Thu, 19 Apr 2001 09:23:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135666AbRDSNXg>; Thu, 19 Apr 2001 09:23:36 -0400
Received: from ganesh.phy.duke.edu ([152.3.183.52]:3345 "EHLO
	ganesh.phy.duke.edu") by vger.kernel.org with ESMTP
	id <S135664AbRDSNXW>; Thu, 19 Apr 2001 09:23:22 -0400
Date: Thu, 19 Apr 2001 09:23:17 -0400 (EDT)
From: "Robert G. Brown" <rgb@phy.duke.edu>
To: Andreas Jaeger <aj@suse.de>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: FPE's
In-Reply-To: <u8r8yp4hnu.fsf@gromit.rhein-neckar.de>
Message-ID: <Pine.LNX.4.30.0104190921160.32745-100000@ganesh.phy.duke.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 19 Apr 2001, Andreas Jaeger wrote:

>
> ISO C demands that at process startup all FPU traps are masked.  You
> can set specific traps with the functions in <fenv.h> from the C
> library, for details read the manual: info libc
>
> Andreas
>

Thanks, this is what I needed.  I guessed that there was something like
this but even in the online glib manual where they have an extensive
section on signals and FPE's, they somehow fail to mention this.

I truly appreciate it, and hope I didn't contribute too much to noise on
the kernel list.

   rgb

-- 
Robert G. Brown	                       http://www.phy.duke.edu/~rgb/
Duke University Dept. of Physics, Box 90305
Durham, N.C. 27708-0305
Phone: 1-919-660-2567  Fax: 919-660-2525     email:rgb@phy.duke.edu



