Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262003AbSJZJBz>; Sat, 26 Oct 2002 05:01:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262006AbSJZJBz>; Sat, 26 Oct 2002 05:01:55 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:17652 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id <S262003AbSJZJBy>;
	Sat, 26 Oct 2002 05:01:54 -0400
Message-ID: <3DBA5B60.1C7C4786@mvista.com>
Date: Sat, 26 Oct 2002 02:07:44 -0700
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: landley@trommello.org
CC: jim.houston@ccur.com, linux-kernel@vger.kernel.org
Subject: Re: highres timers question...
References: <3DB88F6D.F408FF06@ccur.com> <200210251353.58577.landley@trommello.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rob Landley wrote:
> 
> I'm guessing that of the patches here:
> 
> http://sourceforge.net/projects/high-res-timers
> 
> The -posix one adds posix support on top of the base high-res timers patch?
> 
> (Did I guess right?)

Uh, no.  We made the command decision that even IF he does
not let in the high-res stuff we would like the POSIX API in
the kernel.  Thus the patches are structured to require the
POSIX patch first.  This can be changed if need be, but that
is the way it is now.
> 
> Rob
> 
> --
> http://penguicon.sf.net - Terry Pratchett, Eric Raymond, Pete Abrams, Illiad,
> CmdrTaco, liquid nitrogen ice cream, and caffienated jello.  Well why not?

-- 
George Anzinger   george@mvista.com
High-res-timers: 
http://sourceforge.net/projects/high-res-timers/
Preemption patch:
http://www.kernel.org/pub/linux/kernel/people/rml
