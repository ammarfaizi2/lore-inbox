Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262501AbUCWLn6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Mar 2004 06:43:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262508AbUCWLn6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Mar 2004 06:43:58 -0500
Received: from islay.mach.uni-karlsruhe.de ([129.13.162.92]:29854 "EHLO
	mailout.schmorp.de") by vger.kernel.org with ESMTP id S262501AbUCWLnz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Mar 2004 06:43:55 -0500
Date: Mon, 22 Mar 2004 19:21:21 +0100
From: Marc Lehmann <pcg@schmorp.de>
To: Arjan van de Ven <arjanv@redhat.com>
Cc: Cameron Patrick <cameron@patrick.wattle.id.au>,
       Michael Frank <mhf@linuxmail.org>, Pavel Machek <pavel@suse.cz>,
       Software Suspend - Mailing Lists 
	<swsusp-devel@lists.sourceforge.net>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [Swsusp-devel] lzf license
Message-ID: <20040322182121.GA21521@schmorp.de>
Mail-Followup-To: Arjan van de Ven <arjanv@redhat.com>,
	Cameron Patrick <cameron@patrick.wattle.id.au>,
	Michael Frank <mhf@linuxmail.org>, Pavel Machek <pavel@suse.cz>,
	Software Suspend - Mailing Lists <swsusp-devel@lists.sourceforge.net>,
	kernel list <linux-kernel@vger.kernel.org>
References: <opr49atvpk4evsfm@smtp.pacific.net.th> <20040322094053.GO16890@patrick.wattle.id.au> <1079948988.5296.8.camel@laptop.fenrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1079948988.5296.8.camel@laptop.fenrus.com>
X-Operating-System: Linux version 2.4.24 (root@cerebro) (gcc version 2.95.4 20011002 (Debian prerelease)) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 22, 2004 at 10:49:48AM +0100, Arjan van de Ven <arjanv@redhat.com> wrote:
> > The licence so described looks to me the same as LZF's licence.
> 
> however at least I would prefer the author to dual license it ANYWAY,
> because compression stuff generally is riddled with patents; the author
> GPL licensing it at least gives all users a license of the authors
> patents (if any). 

I would like to avoid dual-licensing and instead change the existing
license to suit any needs, if at all possible. (Note that relicensing
should be possible, at least this was my original goal).

If patents are an issue, how about adding this:

   4. The author is unaware of any existing patents and disclaims any
      patents, or other restrictions, on the LZF algorithm or this
      implementation.

I would add this clause to both future lzf distributions as well as the
file that is part of the lzf patch.

If there are unavoidable reasons why the GPL is required, then I'd bite
the bullet and dual-license it, in the hope that further bugfixes or
modifications will be contributed under both licenses.

-- 
      -----==-                                             |
      ----==-- _                                           |
      ---==---(_)__  __ ____  __       Marc Lehmann      +--
      --==---/ / _ \/ // /\ \/ /       pcg@goof.com      |e|
      -=====/_/_//_/\_,_/ /_/\_\       XX11-RIPE         --+
    The choice of a GNU generation                       |
                                                         |
