Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286802AbRL1J1P>; Fri, 28 Dec 2001 04:27:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286803AbRL1J1G>; Fri, 28 Dec 2001 04:27:06 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:17319 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S286802AbRL1J0t>;
	Fri, 28 Dec 2001 04:26:49 -0500
Date: Fri, 28 Dec 2001 04:26:48 -0500
From: Legacy Fishtank <garzik@havoc.gtf.org>
To: Dave Jones <davej@suse.de>
Cc: "Eric S. Raymond" <esr@snark.thyrsus.com>,
        Linus Torvalds <torvalds@transmeta.com>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        linux-kernel@vger.kernel.org, kbuild-devel@lists.sourceforge.net
Subject: Re: State of the new config & build system
Message-ID: <20011228042648.A7943@havoc.gtf.org>
In-Reply-To: <200112280024.fBS0OYH26337@snark.thyrsus.com> <Pine.LNX.4.33.0112280147290.18346-100000@Appserv.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.33.0112280147290.18346-100000@Appserv.suse.de>; from davej@suse.de on Fri, Dec 28, 2001 at 01:54:42AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 28, 2001 at 01:54:42AM +0100, Dave Jones wrote:
> How far down the list was "make it not take twice as long
> to build the kernel as kbuild 2.4" ? Keith mentioned O(n^2)
> effects due to each compile operation needing to reload
> the dependancies etc.

Each compile needs to reload deps???

Ug.  IMHO if you are doing to shake up the entire build system, you
should Do It Right(tm) and build a -complete- dependency graph -once-.

	Jeff


