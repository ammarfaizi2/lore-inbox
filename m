Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264473AbVBEW2t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264473AbVBEW2t (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Feb 2005 17:28:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270329AbVBEW2t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Feb 2005 17:28:49 -0500
Received: from smtpout6.uol.com.br ([200.221.4.197]:49853 "EHLO
	smtp.uol.com.br") by vger.kernel.org with ESMTP id S270116AbVBEW2n
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Feb 2005 17:28:43 -0500
Date: Sat, 5 Feb 2005 20:28:42 -0200
From: =?iso-8859-1?Q?Rog=E9rio?= Brito <rbrito@ime.usp.br>
To: Jurriaan <thunder7@xs4all.nl>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.11-rc3-mm1
Message-ID: <20050205222841.GA3815@ime.usp.br>
Mail-Followup-To: Jurriaan <thunder7@xs4all.nl>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20050204103350.241a907a.akpm@osdl.org> <20050205181018.GA7278@ime.usp.br> <20050205184350.GA25795@middle.of.nowhere>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20050205184350.GA25795@middle.of.nowhere>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Feb 05 2005, Jurriaan wrote:
> From: Rogério Brito <rbrito@ime.usp.br>
> Date: Sat, Feb 05, 2005 at 04:10:18PM -0200
> > Inconsistent kallsyms data
> > Try setting CONFIG_KALLSYMS_EXTRA_PASS
> > make[1]: *** [vmlinux] Error 1
> > make[1]: Leaving directory `/usr/local/media/progs/linux/kernel/linux'
> > make: *** [stamp-build] Error 2
> 
> Read what it says, and enable CONFIG_KALLSYMS_EXTRA_PASS, then try
> again.

Taken straight from the help option for CONFIG_KALLSYMS_EXTRA_PASS:

- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
Always say N here unless you find a bug in kallsyms, which must be
reported.  KALLSYMS_EXTRA_PASS is only a temporary workaround while
you wait for kallsyms to be fixed.
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

I received, BTW, a message from Frank Denis saying that this is fixed in
his -jedi1 patch.

I will try it and report back the results that I come up with.


Thanks for the feedback anyway, Rogério.

-- 
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
  Rogério Brito - rbrito@ime.usp.br - http://www.ime.usp.br/~rbrito
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
