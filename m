Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267397AbUIMQef@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267397AbUIMQef (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Sep 2004 12:34:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267930AbUIMQck
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Sep 2004 12:32:40 -0400
Received: from mail1.ati.com ([209.50.91.165]:14306 "EHLO mail1.ati.com")
	by vger.kernel.org with ESMTP id S267841AbUIMQ1S convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Sep 2004 12:27:18 -0400
Subject: Re: radeon-pre-2
X-Sybari-Trust: 6ed10c11 e1e46965 669a16f6 00000108
From: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
To: Vladimir Dergachev <volodya@mindspring.com>
Cc: Dave Airlie <airlied@linux.ie>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Jon Smirl <jonsmirl@gmail.com>,
       Felix =?ISO-8859-1?Q?K=FChling?= <fxkuehl@gmx.de>,
       DRI Devel <dri-devel@lists.sourceforge.net>,
       lkml <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.61.0409131047060.4885@node2.an-vo.com>
References: <E3389AF2-0272-11D9-A8D1-000A95F07A7A@fs.ei.tum.de>
	 <Pine.LNX.4.58.0409100209100.32064@skynet>
	 <9e47339104090919015b5b5a4d@mail.gmail.com>
	 <20040910153135.4310c13a.felix@trabant>
	 <9e47339104091008115b821912@mail.gmail.com>
	 <1094829278.17801.18.camel@localhost.localdomain>
	 <9e4733910409100937126dc0e7@mail.gmail.com>
	 <1094832031.17883.1.camel@localhost.localdomain>
	 <9e47339104091010221f03ec06@mail.gmail.com>
	 <1094835846.17932.11.camel@localhost.localdomain>
	 <9e47339104091011402e8341d0@mail.gmail.com>
	 <Pine.LNX.4.58.0409102254250.13921@skynet>
	 <1094853588.18235.12.camel@localhost.localdomain>
	 <Pine.LNX.4.58.0409110137590.26651@skynet>
	 <1094912726.21157.52.camel@localhost.localdomain>
	 <Pine.LNX.4.58.0409122319550.20080@skynet>
	 <1095035276.22112.31.camel@admin.tel.thor.asgaard.local>
	 <Pine.LNX.4.61.0409122042370.9611@node2.an-vo.com>
	 <1095036743.22137.48.camel@admin.tel.thor.asgaard.local>
	 <Pine.LNX.4.61.0409131047060.4885@node2.an-vo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Date: Mon, 13 Sep 2004 12:26:28 -0400
Message-Id: <1095092788.4555.73.camel@admin.tel.thor.asgaard.local>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.94.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-09-13 at 10:52 -0400, Vladimir Dergachev wrote:
> 
> So, as Jon rightly points out the "multiple drivers" scheme only makes 
> sense in the current usage patter - you either use X or framebuffer, never 
> both at the same time and you consider a few seconds per switch normal.

You are mixing up things. VT switch != context switch.


-- 
Earthling Michel Dänzer      |     Debian (powerpc), X and DRI developer
Libre software enthusiast    |   http://svcs.affero.net/rm.php?r=daenzer
