Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263983AbTE0RgL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 13:36:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263986AbTE0RgK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 13:36:10 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:45965 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id S263983AbTE0RgJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 13:36:09 -0400
Date: Tue, 27 May 2003 14:47:24 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
X-X-Sender: marcelo@freak.distro.conectiva
To: Marc-Christian Petersen <m.c.p@wolk-project.de>
Cc: linux-kernel@vger.kernel.org,
       Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2003@gmx.net>,
       manish <manish@storadinc.com>,
       Christian Klose <christian.klose@freenet.de>,
       William Lee Irwin III <wli@holomorphy.com>
Subject: Re: 2.4.20: Proccess stuck in __lock_page ...
In-Reply-To: <200305271936.34006.m.c.p@wolk-project.de>
Message-ID: <Pine.LNX.4.55L.0305271447100.756@freak.distro.conectiva>
References: <3ED2DE86.2070406@storadinc.com> <3ED372DB.1030907@gmx.net>
 <Pine.LNX.4.55L.0305271425500.30637@freak.distro.conectiva>
 <200305271936.34006.m.c.p@wolk-project.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 27 May 2003, Marc-Christian Petersen wrote:

> On Tuesday 27 May 2003 19:27, Marcelo Tosatti wrote:
>
> Hi Marcelo,
>
> > > Following is SysRq-T output for stuck processes during such a pause from
> > > Christian Klose. Only processes in D state are listed for brevity.
> > > Especially the last two call traces are interesting.
> > A "pause" is perfectly fine (to some extent, of course), now a hang is
> > not. Is this backtrace from a hanged, unusable kernel or ?
> A pause is _not_ perfectly fine, even not to some extent. That pause we are
> discussing about is a pause of the _whole_ machine, not just disk i/o pauses.
> Mouse stops, keyboard stops, everything stops, who knows wtf.

Do you also notice them?


> That behaviour is absolutely bullshit for desktop users. For serverusage you
> may not notice it in this dimension (mostly no X so no mouse), but also for a
> server environment this may be very bad.

Agreed.
