Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272938AbTG3PkJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jul 2003 11:40:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S273935AbTG3Pd2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jul 2003 11:33:28 -0400
Received: from imap.gmx.net ([213.165.64.20]:59863 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S273911AbTG3PdR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jul 2003 11:33:17 -0400
Date: Wed, 30 Jul 2003 21:03:12 +0530
From: Apurva Mehta <apurva@gmx.net>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] O11int for interactivity
Message-ID: <20030730153312.GB1341@home.woodlands>
Mail-Followup-To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <200307301038.49869.kernel@kolivas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200307301038.49869.kernel@kolivas.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Con Kolivas <kernel@kolivas.org> [30-07-2003 13:36]:
> Update to the interactivity patches. Not a massive improvement but
> more smoothing of the corners.
>
> [snip]
>
> _All_ testing and comments are desired and appreciated.

Well, I just put my system under severe natural load using
2.6.0-test2-mm1 and I must say that my system remained as responsive
as one could expect. I have a PentiumIII 500Mhz with 192 Mb RAM. 

Here's what load was like:
1) Compiling 2.6.0-test2-mm1-O11.1int :)
2) updating spamassassin bayesian filters (This mainly causes heavy
   disk i/o, the CPU usage is not so high)
3) procmail filtering ~40 emails simultaneously. 
4) playing ogg's in xmms 
5) switching between viewing pdf's and web-browsing

Window switching remained pretty snappy and there was one skip in
the music . The pdf's scrolled at a decent speed too.

All in all I would say that I really cannot expect anything more in
terms of responsiveness from my hardware. IMO, there is a limit to the
magic a good scheduler can do on limited hardware resources. 

The scheduler has certainly come a long way since 2.6.0-test1
( plus all subsequent patches and versions). Great work.

	   - Apurva
