Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263358AbTDGJNW (for <rfc822;willy@w.ods.org>); Mon, 7 Apr 2003 05:13:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263361AbTDGJNW (for <rfc822;linux-kernel-outgoing>); Mon, 7 Apr 2003 05:13:22 -0400
Received: from 205-158-62-136.outblaze.com ([205.158.62.136]:57815 "HELO
	fs5-4.us4.outblaze.com") by vger.kernel.org with SMTP
	id S263358AbTDGJNV (for <rfc822;linux-kernel@vger.kernel.org>); Mon, 7 Apr 2003 05:13:21 -0400
Subject: Re: 2.5: NFS troubles
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: Andrew Morton <akpm@digeo.com>
Cc: rml@tech9.net, trond.myklebust@fys.uio.no,
       LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20030407021331.1ffbfa7f.akpm@digeo.com>
References: <1049630768.592.24.camel@teapot.felipe-alfaro.com>
	 <shsbrzjn5of.fsf@charged.uio.no> <20030406171855.6bd3552d.akpm@digeo.com>
	 <1049675270.753.166.camel@localhost>
	 <1049706067.592.5.camel@teapot.felipe-alfaro.com>
	 <20030407021331.1ffbfa7f.akpm@digeo.com>
Content-Type: text/plain
Organization: 
Message-Id: <1049707384.592.19.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 (1.2.3-1) 
Date: 07 Apr 2003 11:24:44 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-04-07 at 11:13, Andrew Morton wrote:
> Felipe Alfaro Solana <felipe_alfaro@linuxmail.org> wrote:
> >
> > I don't think it's a client problem, since I can't reproduce with
> > 2.4+ext3, 2.5.66+ext2 and 2.5.66+ext3-dir_index, but is reproducible
> > with 2.5.66+ext3+dir_index.
> > 
> 
> Well it could still be an NFS problem.  Turning off htree on the server could
> cause filenames to be returned in a different order (or is that illegal?) or
> changed timing or such.
> 
> If Robert is seeing it on non-htree servers then we'd need to see that fixed
> up before deciding if there is also an(other) htree bug.
> 
> First thing we need to do is to debug it.  Trond would have a better idea of
> how to set about that than I.  Possibly a tcpdump of the traffic?

I sent a tcpdump and strace as attachments in my original message ;-)
Do you have it handy? Should I send it again?...

________________________________________________________________________
Linux Registered User #287198

