Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267734AbUHJUkx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267734AbUHJUkx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 16:40:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267725AbUHJUkx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 16:40:53 -0400
Received: from ezoffice.mandrakesoft.com ([212.11.15.34]:35221 "EHLO
	office.mandrakesoft.com") by vger.kernel.org with ESMTP
	id S267724AbUHJUjV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 16:39:21 -0400
To: kernel@mandrakesoft.com
Cc: "lkml " <linux-kernel@vger.kernel.org>, nplanel@mandrakesoft.com,
       tmb@mandrake.org
Subject: Re: [Kernel] Re: New dev model
X-URL: <http://www.linux-mandrake.com/
References: <14610.1090502271@www50.gmx.net>
From: Thierry Vignaud <tvignaud@mandrakesoft.com>
Organization: Mandrakesoft
Date: Tue, 10 Aug 2004 22:39:16 +0200
In-Reply-To: <14610.1090502271@www50.gmx.net> (Svetoslav Slavtchev's message
 of "Thu, 22 Jul 2004 15:17:51 +0200 (MEST)")
Message-ID: <m2oeliohhn.fsf@vador.mandrakesoft.com>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Svetoslav Slavtchev" <svetljo@gmx.de> writes:

> once again, sorry for this way of replying,
> could you keep me CC'd as i'm not subscribed to lkml

(...)

> That could be done by sending in smaller patches that remove devfs
> calls from drivers.  If nothing in the kernel is using devfs, then
> there is no reason to keep it around anymore...

well actually removing such bits from dac960.c and cciss.c would
restore devfs support for them :-(

> please don't do it /*at least not in the following two months :-)*/
> 
> what does this buy us ?
> 
> once again about the upcoming Mandrake 10.1, we already have readded
> devfs support to isdn, should we start tracking bk-head for such
> patches that remove devfs support from drivers and revert them ?
> should we stay with 2.6.7 (or eventually 2.6.8)?  there is really no
> time to integarate/test udev as replacement of devfs for the next
> release.

the odds're high we'll go out with udev by default.
it works smoothly for most devices (dvb and a few others seems missing
but patches are pending).

drakx installer is know fully aware of it (as of today's cvs)

