Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265808AbTFVTSo (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Jun 2003 15:18:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265814AbTFVTSo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Jun 2003 15:18:44 -0400
Received: from babsi.intermeta.de ([212.34.181.3]:1550 "EHLO mail.intermeta.de")
	by vger.kernel.org with ESMTP id S265808AbTFVTSm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Jun 2003 15:18:42 -0400
Subject: Re: GCC speed (was [PATCH] Isapnp warning)
From: Henning Schmiedehausen <hps@intermeta.de>
To: Andrew Morton <akpm@digeo.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030622121323.1abdd079.akpm@digeo.com>
References: <20030621125111.0bb3dc1c.akpm@digeo.com>
	 <20030622103251.158691c3.akpm@digeo.com>
	 <bd4u7s$jkp$1@tangens.hometree.net>
	 <20030622121323.1abdd079.akpm@digeo.com>
Content-Type: text/plain
Organization: INTERMETA - Gesellschaft  =?ISO-8859-1?Q?=20f=C3=BCr?= Mehrwertdienste mbH
Message-Id: <1056310361.13095.0.camel@henning-pc.hutweide.de>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.0 
Date: 22 Jun 2003 21:32:41 +0200
Content-Transfer-Encoding: 7bit
X-Spam-Score: -2.5 () EMAIL_ATTRIBUTION,IN_REP_TO,QUOTED_EMAIL_TEXT,REFERENCES,REPLY_WITH_QUOTES
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

well to me that sounds like a perfect job for a continous build tool. If
a human must wait on this, then yes, you're right.

	Regards
		Henning


On Sun, 2003-06-22 at 21:13, Andrew Morton wrote:
> "Henning P. Schmiedehausen" <hps@intermeta.de> wrote:
> >
> >  Your problem is not the compiler but the build tool / system which
> >  forces you to recompile all of your kernel if you change only small
> >  parts.
> 
> No, the build system is OK.  And ccache nicely fixes up any mistakes which
> the build system makes, and distcc speeds things up by 2x to 3x.
> 
> None of that gets around the fact that code needs to be tested with various
> combinations of CONFIG_SMP, CONFIG_PREEMPT, different subarchitectures,
> spinlock debugging, etc, etc.  If the compiler is slow people don't bother
> doing this and the code breaks.
> 
> Cause and effect.
-- 
Dipl.-Inf. (Univ.) Henning P. Schmiedehausen       -- Geschaeftsfuehrer
INTERMETA - Gesellschaft fuer Mehrwertdienste mbH     hps@intermeta.de

Am Schwabachgrund 22  Fon.: 09131 / 50654-0   info@intermeta.de
D-91054 Buckenhof     Fax.: 09131 / 50654-20   

