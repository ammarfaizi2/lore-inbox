Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270871AbTGPOaM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jul 2003 10:30:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270956AbTGPOaM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jul 2003 10:30:12 -0400
Received: from 224.Red-217-125-129.pooles.rima-tde.net ([217.125.129.224]:6635
	"HELO cocodriloo.com") by vger.kernel.org with SMTP id S270871AbTGPOaE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jul 2003 10:30:04 -0400
Date: Wed, 16 Jul 2003 16:24:31 +0200
From: Antonio Vargas <wind@cocodriloo.com>
To: Helge Hafting <helgehaf@aitel.hist.no>
Cc: Antonio Vargas <wind@cocodriloo.com>, Ingo Molnar <mingo@elte.hu>,
       Sean Neakums <sneakums@zork.net>, Andrew Morton <akpm@osdl.org>,
       Con Kolivas <kernel@kolivas.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test1-mm1
Message-ID: <20030716142431.GA11190@wind.cocodriloo.com>
References: <6uwueidhdd.fsf@zork.zork.net> <Pine.LNX.4.44.0307161052310.6193-100000@localhost.localdomain> <20030716101949.GE2684@wind.cocodriloo.com> <3F155536.8090608@aitel.hist.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F155536.8090608@aitel.hist.no>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 16, 2003 at 03:37:58PM +0200, Helge Hafting wrote:
> Antonio Vargas wrote:
> [...]
> >It always happened to me when I run "make menuconfig" under gnome-terminal 
> >on
> >redhat 9 with 2.5.73. Is it because of busy-waiting on a variable shared
> >amongst multiple processes/threads? If so, it smells of a bug in the 
> >application,
> >busy-waiting is _BAD_.
> 
> Ouch.  Well, it is good that scheduler changes made the bug visible,
> so it can be fixed.  Certainly no reason to
> work around it in the kernel, the effort is better spent on fixing
> the bug.  Distributors can make sure they have fixed their apps
> before distributing 2.6.
> 
> Helge Hafting

I filled an entry on redhat's bugzilla, but the response was
"keep the terminal minimised while doing heavy terminal output".
I quit redhat next day.

I could translate this to "Look mom, I can config my kernel while blindfolded!!!" ;)

I wonder if someone has produced an small test-case for this,
which works on 2.4 and dies in 2.5 or 2.6... it would then
be "easy" to check and fix the apps.

Greets, Antonio.

-- 

In fact, this is all you need to know to be
a Caveman Database Programmer:

A relational database is a big spreadsheet
that several people can update simultaneously. 

