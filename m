Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287616AbSANQwm>; Mon, 14 Jan 2002 11:52:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287731AbSANQw3>; Mon, 14 Jan 2002 11:52:29 -0500
Received: from dsl254-112-233.nyc1.dsl.speakeasy.net ([216.254.112.233]:13445
	"EHLO snark.thyrsus.com") by vger.kernel.org with ESMTP
	id <S287616AbSANQuc>; Mon, 14 Jan 2002 11:50:32 -0500
Date: Mon, 14 Jan 2002 11:34:44 -0500
From: "Eric S. Raymond" <esr@thyrsus.com>
To: Giacomo Catenazzi <cate@dplanet.ch>
Cc: Giacomo Catenazzi <cate@debian.org>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: ISA hardware discovery -- the elegant solution
Message-ID: <20020114113444.A14594@thyrsus.com>
Reply-To: esr@thyrsus.com
Mail-Followup-To: "Eric S. Raymond" <esr@thyrsus.com>,
	Giacomo Catenazzi <cate@dplanet.ch>,
	Giacomo Catenazzi <cate@debian.org>,
	Linux Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <fa.dardpev.1m1emjp@ifi.uio.no> <3C42AF6B.6050304@debian.org> <20020114111608.B14332@thyrsus.com> <3C430985.3090700@dplanet.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3C430985.3090700@dplanet.ch>; from cate@dplanet.ch on Mon, Jan 14, 2002 at 05:38:29PM +0100
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Giacomo Catenazzi <cate@dplanet.ch>:
> >>Better: create a /proc/driver and every driver will register in it.
> >>This file can help some bug report (and not only autoconfigurator).
> > 
> > That would be fine with me.  But wouldn't it involve adding a new
> > initialization-time call to every driver.
> 
> I think we can add it automatically, modifing one of the
> the modules macros. (this works automatically only for
> trit symbols).

That would be OK.  I think there are *very* few drivers left that 
aren't modular.

> Hmm. IIRC there is a  big module/driver API (for modules) change
> in 2.5 programs (driver registration,...). In this case we should
> only modify the API before it will be effectivelly used, and
> the changes will go automatically in kernel...

This sounds encouraging.
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>

Ideology, politics and journalism, which luxuriate in failure, are
impotent in the face of hope and joy.
	-- P. J. O'Rourke
