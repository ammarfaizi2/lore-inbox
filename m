Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287784AbSANR0c>; Mon, 14 Jan 2002 12:26:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287786AbSANR0W>; Mon, 14 Jan 2002 12:26:22 -0500
Received: from zeus.kernel.org ([204.152.189.113]:17387 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S287784AbSANR0M>;
	Mon, 14 Jan 2002 12:26:12 -0500
Date: Mon, 14 Jan 2002 11:16:08 -0500
From: "Eric S. Raymond" <esr@thyrsus.com>
To: Giacomo Catenazzi <cate@debian.org>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: ISA hardware discovery -- the elegant solution
Message-ID: <20020114111608.B14332@thyrsus.com>
Reply-To: esr@thyrsus.com
Mail-Followup-To: "Eric S. Raymond" <esr@thyrsus.com>,
	Giacomo Catenazzi <cate@debian.org>,
	Linux Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <fa.dardpev.1m1emjp@ifi.uio.no> <3C42AF6B.6050304@debian.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3C42AF6B.6050304@debian.org>; from cate@debian.org on Mon, Jan 14, 2002 at 11:14:03AM +0100
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Giacomo Catenazzi <cate@debian.org>:
> > With this change, generating a report on ISA hardware and other
> > facilities configured in at boot time would be trivial.  This would
> > make the autoconfigurator much more capable.  Best of all, the only
> > change required to accomplish this would be safe edits of print format
> > strings.
>  
> Better: create a /proc/driver and every driver will register in it.
> This file can help some bug report (and not only autoconfigurator).

That would be fine with me.  But wouldn't it involve adding a new
initialization-time call to every driver.
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>

The whole of the Bill [of Rights] is a declaration of the right of the
people at large or considered as individuals...  It establishes some
rights of the individual as unalienable and which consequently, no
majority has a right to deprive them of.
         -- Albert Gallatin, Oct 7 1789
