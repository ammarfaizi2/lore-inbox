Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262006AbVAVR0E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262006AbVAVR0E (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Jan 2005 12:26:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262101AbVAVR0D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Jan 2005 12:26:03 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:19991
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S262006AbVAVRZv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Jan 2005 12:25:51 -0500
Date: Sat, 22 Jan 2005 18:25:42 +0100
From: Andrea Arcangeli <andrea@cpushare.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: Ingo Molnar <mingo@elte.hu>, Chris Wright <chrisw@osdl.org>,
       Rik van Riel <riel@redhat.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: seccomp for 2.6.11-rc1-bk8
Message-ID: <20050122172542.GF7587@dualathlon.random>
References: <20050121100606.GB8042@dualathlon.random> <20050121120325.GA2934@elte.hu> <20050121093902.O469@build.pdx.osdl.net> <Pine.LNX.4.61.0501211338190.15744@chimarrao.boston.redhat.com> <20050121105001.A24171@build.pdx.osdl.net> <20050121195522.GA14982@elte.hu> <20050121203425.GB11112@dualathlon.random> <20050122103242.GC9357@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050122103242.GC9357@elf.ucw.cz>
X-AA-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-AA-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
X-Cpushare-GPG-Key: 1024D/4D11C21C 5F99 3C8B 5142 EB62 26C3  2325 8989 B72A 4D11 C21C
X-Cpushare-SSL-SHA1-Cert: 3812 CD76 E482 94AF 020C  0FFA E1FF 559D 9B4F A59B
X-Cpushare-SSL-MD5-Cert: EDA5 F2DA 1D32 7560  5E07 6C91 BFFC B885
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 22, 2005 at 11:32:42AM +0100, Pavel Machek wrote:
> Well, seccomp is also getting very little testing, when ptrace gets a
> lot of testing; I know that seccomp is simple, but I believe testing
> coverage still make ptrace better choice.

It's not testing that makes code more secure. Testing verifys the code
works in production, but testing almost never helps to find security
issues, and often not even hidden subtle race conditions. Check how many
security bugs have been found with testing.  Just go to bugtraq count
them. I simply cannot relay on testing for the security part. I will
relay on testing for everything else but not for this.
