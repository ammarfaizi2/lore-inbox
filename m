Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263011AbTEVSVd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 May 2003 14:21:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263023AbTEVSVd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 May 2003 14:21:33 -0400
Received: from 205-158-62-136.outblaze.com ([205.158.62.136]:19684 "HELO
	fs5-4.us4.outblaze.com") by vger.kernel.org with SMTP
	id S263011AbTEVSVc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 May 2003 14:21:32 -0400
Subject: Re: [RFC] Disallow compilation with gcc 3.2.3 (was: Re:
	2.5.69-mm6: pccard oops while booting:)
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2003@gmx.net>
Cc: Andrew Morton <akpm@digeo.com>, rmk@arm.linux.org.uk,
       LKML <linux-kernel@vger.kernel.org>, davej@suse.de
In-Reply-To: <3ECCCF76.3020800@gmx.net>
References: <1052964213.586.3.camel@teapot.felipe-alfaro.com>
	 <20030514191735.6fe0998c.akpm@digeo.com>
	 <1052998601.726.1.camel@teapot.felipe-alfaro.com>
	 <20030515130019.B30619@flint.arm.linux.org.uk>
	 <1053004615.586.2.camel@teapot.felipe-alfaro.com>
	 <20030515144439.A31491@flint.arm.linux.org.uk>
	 <1053037915.569.2.camel@teapot.felipe-alfaro.com>
	 <20030515160015.5dfea63f.akpm@digeo.com>
	 <1053090184.653.0.camel@teapot.felipe-alfaro.com>
	 <1053110098.648.1.camel@teapot.felipe-alfaro.com>
	 <20030516132908.62e54266.akpm@digeo.com>
	 <1053121346.569.1.camel@teapot.felipe-alfaro.com>
	 <3EC56173.1000306@gmx.net>
	 <1053166275.586.9.camel@teapot.felipe-alfaro.com>
	 <20030517031840.486683fc.akpm@digeo.com>
	 <1053169552.613.1.camel@teapot.felipe-alfaro.com>
	 <3EC61B63.9020906@gmx.net>
	 <1053175886.660.4.camel@teapot.felipe-alfaro.com>
	 <1053286732.812.5.camel@teapot.felipe-alfaro.com>
	 <3ECCCF76.3020800@gmx.net>
Content-Type: text/plain; charset=ISO-8859-15
Message-Id: <1053628462.646.4.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.3.3 (Preview Release)
Date: 22 May 2003 20:34:22 +0200
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-05-22 at 15:24, Carl-Daniel Hailfinger wrote:
> Felipe Alfaro Solana wrote:
> > I've read the announcement of gcc 3.3 and saw that gcc 3.2 is not yet
> > supported for linux kernel compilations (I've been using Red Hat's
> > gcc-3.2.3-4 to compile 2.5.69-mm6). So I thought, what would happen if I
> > use gcc 2.96 to compile the kernel instead?
> > 
> > And voilà... I've compiled 2.5.69-mm6 with Red Hat's 2.96.118 and now,
> > I'm unable to reproduce the pccard oops you've been trying to chase
> > down. Does this mean the pccard oops was caused by a compiler bug?
> 
> Nobody has found an error in the code we talked about, so a compiler bug
> in gcc 3.2.3 seems to be the only explanation.

I would say it's indeed a bug with gcc 3.2.3. I'm now compiling using
2.96 and the problem has disappeared completely. Maybe I'll give a try
with gcc 3.3 to see how it works.

