Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264098AbUEHF33@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264098AbUEHF33 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 May 2004 01:29:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264105AbUEHF33
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 May 2004 01:29:29 -0400
Received: from wombat.indigo.net.au ([202.0.185.19]:48910 "EHLO
	wombat.indigo.net.au") by vger.kernel.org with ESMTP
	id S264098AbUEHF30 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 May 2004 01:29:26 -0400
Date: Sat, 8 May 2004 13:29:32 +0800 (WST)
From: raven@themaw.net
To: Paul Jakma <paul@clubi.ie>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux autofs <autofs@linux.kernel.org>,
       Arjan van de Ven <arjanv@redhat.com>
Subject: Re: [autofs] Badness in interruptible_sleep_on
In-Reply-To: <Pine.LNX.4.58.0405072321530.1979@fogarty.jakma.org>
Message-ID: <Pine.LNX.4.58.0405081324440.2371@donald.themaw.net>
References: <Pine.LNX.4.58.0405070532500.1979@fogarty.jakma.org>
 <Pine.LNX.4.58.0405071426500.11299@wombat.indigo.net.au>
 <Pine.LNX.4.58.0405072321530.1979@fogarty.jakma.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam, SpamAssassin (score=-1.7, required 8,
	EMAIL_ATTRIBUTION, IN_REP_TO, NO_REAL_NAME, QUOTED_EMAIL_TEXT,
	REFERENCES, REPLY_WITH_QUOTES, USER_AGENT_PINE)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 7 May 2004, Paul Jakma wrote:

> On Fri, 7 May 2004, Ian Kent wrote:
> 
> > Not sure what needs to be done about this Paul.
> > 
> > I eliminated the interruptible_sleep_on in my autofs4 patches long
> > ago.  The current updates are in 2.6.6-rc3-mm2.
> 
> Ah excellent news. I'm using Arjan van de Ven's 2.6.3-1.96 kernel at 
> the moment. So that problem will dissappear with a kernel update at 
> some stage. Thanks!
> 
> PS: Arjan, any chance of a kernel with davej's NFS stack fixes and 
> the autofs badness fixes? would be much appreciated!

While I have some patch sets around for earlier 2.6 kernels I advise 
against using them.

I'm in the process of making "single file" patches for the earlier kernels 
with all the updates that are in 2.6.6-rc3-mm2.

As an aside the same goes for the 2.4 patches.

I'll let you know when it's done. I expect to finish this weekend.

Ian

