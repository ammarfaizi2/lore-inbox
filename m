Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273896AbRJDMyH>; Thu, 4 Oct 2001 08:54:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273912AbRJDMx6>; Thu, 4 Oct 2001 08:53:58 -0400
Received: from gannet.scg.man.ac.uk ([130.88.94.110]:24337 "EHLO
	gannet.scg.man.ac.uk") by vger.kernel.org with ESMTP
	id <S273896AbRJDMxq>; Thu, 4 Oct 2001 08:53:46 -0400
Date: Thu, 4 Oct 2001 13:54:12 +0100
From: John Levon <moz@compsoc.man.ac.uk>
To: linux-kernel@vger.kernel.org
Subject: Re: Security question: "Text file busy" overwriting executables but not shared libraries?
Message-ID: <20011004135412.A22854@compsoc.man.ac.uk>
In-Reply-To: <200110031249.HAA50103@tomcat.admin.navo.hpc.mil> <m1r8sk1tuq.fsf@frodo.biederman.org> <01100319203903.00728@localhost.localdomain> <9pgsk4$7ep$1@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9pgsk4$7ep$1@penguin.transmeta.com>
User-Agent: Mutt/1.3.19i
X-Url: http://www.movement.uklinux.net/
X-Record: Truant - Neither Work Nor Leisure
X-Toppers: N/A
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 04, 2001 at 05:38:12AM +0000, Linus Torvalds wrote:

> The reason the kernel refuses to honour it, is that MAP_DENYWRITE is an
> excellent DoS-vehicle - you just mmap("/etc/passwd") with MAP_DENYWRITE,
> and even root cannot write to it.. Vary nasty.

why is MAP_EXECUTABLE dealt with in the same way then ?

john

-- 
" It is quite humbling to realize that the storage occupied by the longest line
from a typical Usenet posting is sufficient to provide a state space so vast
that all the computation power in the world can not conquer it."
	- Dave Wallace
