Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292956AbSB1Aqg>; Wed, 27 Feb 2002 19:46:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293099AbSB1Apw>; Wed, 27 Feb 2002 19:45:52 -0500
Received: from [198.16.16.39] ([198.16.16.39]:5092 "EHLO carthage")
	by vger.kernel.org with ESMTP id <S293104AbSB1ApI>;
	Wed, 27 Feb 2002 19:45:08 -0500
Date: Wed, 27 Feb 2002 18:41:24 -0600
From: James Curbo <jcurbo@acm.org>
To: Dave Jones <davej@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: (2.5.5-dj2) still getting .text.exit linker errors
Message-ID: <20020228004124.GA6218@carthage>
Reply-To: James Curbo <jcurbo@acm.org>
In-Reply-To: <20020227220138.GA5644@carthage> <20020227234155.K16565@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020227234155.K16565@suse.de>
User-Agent: Mutt/1.3.27i
X-Operating-System: Debian GNU/Linux
Organization: Henderson State University, Arkadelphia, AR
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OK, here it is:

Finding objects, 513 objects, ignoring 0 module(s)
Finding conglomerates, ignoring 53 conglomerate(s)
Scanning objects
Error: ./drivers/net/de2104x.o .data refers to 00000074 R_386_32
.text.exit
Done

On Feb 27, Dave Jones wrote:
> On Wed, Feb 27, 2002 at 04:01:38PM -0600, James Curbo wrote:
>  > drivers/net/net.o(.data+0x1274): undefined reference to `local symbols 
>  > in discarded section .text.exit'
> 
>  Can you grab http://kernelnewbies.org/scripts/reference_discarded.pl
>  and post the output ?
> 
> -- 
> | Dave Jones.        http://www.codemonkey.org.uk
> | SuSE Labs

-- 
James Curbo <jcurbo@acm.org> <jc108788@rc.hsu.edu>
Undergraduate Computer Science, Henderson State University
PGP Keys at <http://reddie.henderson.edu/~curboj/>
Public Keys: PGP - 1024/0x76E2061B GNUPG - 1024D/0x3EEA7288
