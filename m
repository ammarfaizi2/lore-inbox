Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263967AbTE0RYz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 13:24:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263971AbTE0RYz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 13:24:55 -0400
Received: from lindsey.linux-systeme.com ([80.190.48.67]:21254 "EHLO
	mx00.linux-systeme.com") by vger.kernel.org with ESMTP
	id S263967AbTE0RYu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 13:24:50 -0400
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
Organization: Working Overloaded Linux Kernel
To: linux-kernel@vger.kernel.org, Marcelo Tosatti <marcelo@conectiva.com.br>,
       Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2003@gmx.net>
Subject: Re: 2.4.20: Proccess stuck in __lock_page ...
Date: Tue, 27 May 2003 19:36:33 +0200
User-Agent: KMail/1.5.2
Cc: manish <manish@storadinc.com>,
       Christian Klose <christian.klose@freenet.de>,
       William Lee Irwin III <wli@holomorphy.com>
References: <3ED2DE86.2070406@storadinc.com> <3ED372DB.1030907@gmx.net> <Pine.LNX.4.55L.0305271425500.30637@freak.distro.conectiva>
In-Reply-To: <Pine.LNX.4.55L.0305271425500.30637@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200305271936.34006.m.c.p@wolk-project.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 27 May 2003 19:27, Marcelo Tosatti wrote:

Hi Marcelo,

> > Following is SysRq-T output for stuck processes during such a pause from
> > Christian Klose. Only processes in D state are listed for brevity.
> > Especially the last two call traces are interesting.
> A "pause" is perfectly fine (to some extent, of course), now a hang is
> not. Is this backtrace from a hanged, unusable kernel or ?
A pause is _not_ perfectly fine, even not to some extent. That pause we are 
discussing about is a pause of the _whole_ machine, not just disk i/o pauses. 
Mouse stops, keyboard stops, everything stops, who knows wtf.

That behaviour is absolutely bullshit for desktop users. For serverusage you 
may not notice it in this dimension (mostly no X so no mouse), but also for a 
server environment this may be very bad.

ciao, Marc

