Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261947AbTLBM6w (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Dec 2003 07:58:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261953AbTLBM6w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Dec 2003 07:58:52 -0500
Received: from dclient80-218-113-133.hispeed.ch ([80.218.113.133]:6670 "EHLO
	thor.asgaard.local") by vger.kernel.org with ESMTP id S261947AbTLBM6u convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Dec 2003 07:58:50 -0500
Subject: Re: Radeon 7500 DRI Failed on IBM Thinkpad T30
From: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
To: arief_mulya <arief_m_utama@telkomsel.co.id>
Cc: linux-kernel@vger.kernel.org, debian-laptop@lists.debian.org,
       debian-x@lists.debian.org, dri-user@lists.sourceforge.net
In-Reply-To: <1070345442.1058.79.camel@damai.telkomsel.co.id>
References: <1070345442.1058.79.camel@damai.telkomsel.co.id>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Message-Id: <1070369914.4114.28.camel@thor.asgaard.local>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Tue, 02 Dec 2003 13:58:35 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-12-02 at 07:10, arief_mulya wrote: 
> I'm having DRI problem on my IBM Thinkpad T30 with Radeon 7500.
> Sometimes it works, oftenly it doesnt. Withoud "Load dri" in
> XF86Config-4, it work just fine. 
> 
> For first information, I got this problem too under WindowsXP, even
> worse, it hangs after few seconds I login, sometimes, it doesn't let me
> login at all and just printing some messages on BSOD so fast, I cannot
> even see what it was actually printing. I just disabled the VideoCard
> and uses Vesa instead. I rarely need to do winboot afterall. 

[...]

> I'm curious if this is an hardware bug?

It does smell like it, if Windoze is affected as well...

Still, I can think of a couple of things you could try:

      * disable the __HAVE_SHARED_IRQ definition in
        linux/drivers/char/drm/radeon.h; seems to work around some IRQ
        related problems, see
        http://bugs.xfree86.org/show_bug.cgi?id=314
      * try DRI CVS snapshot packages described in
        http://dri.sourceforge.net/snapshots/README.Debian


-- 
Earthling Michel Dänzer      |     Debian (powerpc), X and DRI developer
Software libre enthusiast    |   http://svcs.affero.net/rm.php?r=daenzer
