Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261819AbTEVNLI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 May 2003 09:11:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261840AbTEVNLI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 May 2003 09:11:08 -0400
Received: from imap.gmx.net ([213.165.64.20]:44744 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261819AbTEVNLH convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 May 2003 09:11:07 -0400
Message-ID: <3ECCCF76.3020800@gmx.net>
Date: Thu, 22 May 2003 15:24:06 +0200
From: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2003@gmx.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021126
X-Accept-Language: de, en
MIME-Version: 1.0
To: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
CC: Andrew Morton <akpm@digeo.com>, rmk@arm.linux.org.uk,
       LKML <linux-kernel@vger.kernel.org>, davej@suse.de
Subject: [RFC] Disallow compilation with gcc 3.2.3 (was: Re: 2.5.69-mm6: pccard
 oops while booting:)
References: <1052964213.586.3.camel@teapot.felipe-alfaro.com>	 <20030514191735.6fe0998c.akpm@digeo.com>	 <1052998601.726.1.camel@teapot.felipe-alfaro.com>	 <20030515130019.B30619@flint.arm.linux.org.uk>	 <1053004615.586.2.camel@teapot.felipe-alfaro.com>	 <20030515144439.A31491@flint.arm.linux.org.uk>	 <1053037915.569.2.camel@teapot.felipe-alfaro.com>	 <20030515160015.5dfea63f.akpm@digeo.com>	 <1053090184.653.0.camel@teapot.felipe-alfaro.com>	 <1053110098.648.1.camel@teapot.felipe-alfaro.com>	 <20030516132908.62e54266.akpm@digeo.com>	 <1053121346.569.1.camel@teapot.felipe-alfaro.com>	 <3EC56173.1000306@gmx.net>	 <1053166275.586.9.camel@teapot.felipe-alfaro.com>	 <20030517031840.486683fc.akpm@digeo.com>	 <1053169552.613.1.camel@teapot.felipe-alfaro.com>	 <3EC61B63.9020906@gmx.net>	 <1053175886.660.4.camel@teapot.felipe-alfaro.com> <1053286732.812.5.camel@teapot.felipe-alfaro.com>
In-Reply-To: <1053286732.812.5.camel@teapot.felipe-alfaro.com>
X-Enigmail-Version: 0.71.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Felipe Alfaro Solana wrote:
> I've read the announcement of gcc 3.3 and saw that gcc 3.2 is not yet
> supported for linux kernel compilations (I've been using Red Hat's
> gcc-3.2.3-4 to compile 2.5.69-mm6). So I thought, what would happen if I
> use gcc 2.96 to compile the kernel instead?
> 
> And voilà... I've compiled 2.5.69-mm6 with Red Hat's 2.96.118 and now,
> I'm unable to reproduce the pccard oops you've been trying to chase
> down. Does this mean the pccard oops was caused by a compiler bug?

Nobody has found an error in the code we talked about, so a compiler bug
in gcc 3.2.3 seems to be the only explanation.

Thoughts?

