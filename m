Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267487AbTAQLCb>; Fri, 17 Jan 2003 06:02:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267490AbTAQLCa>; Fri, 17 Jan 2003 06:02:30 -0500
Received: from [66.70.28.20] ([66.70.28.20]:61703 "EHLO
	maggie.piensasolutions.com") by vger.kernel.org with ESMTP
	id <S267487AbTAQLC3>; Fri, 17 Jan 2003 06:02:29 -0500
Date: Fri, 17 Jan 2003 11:55:04 +0100
From: DervishD <raul@pleyades.net>
To: Jakob Oestergaard <jakob@unthought.net>,
       Miquel van Smoorenburg <miquels@cistron.nl>,
       linux-kernel@vger.kernel.org
Subject: Re: argv0 revisited...
Message-ID: <20030117105504.GF47@DervishD>
References: <A46BBDB345A7D5118EC90002A5072C7806CACA88@orsmsx116.jf.intel.com> <20030115191942.GD47@DervishD> <b04dqu$4f5$1@ncc1701.cistron.net> <20030116145908.GF8621@unthought.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20030116145908.GF8621@unthought.net>
User-Agent: Mutt/1.4i
Organization: Pleyades
User-Agent: Mutt/1.4i <http://www.mutt.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Hi Jakob :))

> > I assume that init is passed on the kernel command line like
> > init=/what/ever, right ?
> > Why not make that INIT=/what/ever, then make this /sbin/init:
> Why not make a kernel patch that sets the INIT environment variable for
> the init process ?

    Doesn't worth it, just for reexec'ing init and be able to mangle
with argv[0], which isn't a good thing, anyway ;)

    Raúl
