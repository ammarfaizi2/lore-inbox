Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262170AbUDUNsf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262170AbUDUNsf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Apr 2004 09:48:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262190AbUDUNse
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Apr 2004 09:48:34 -0400
Received: from wombat.indigo.net.au ([202.0.185.19]:12293 "EHLO
	wombat.indigo.net.au") by vger.kernel.org with ESMTP
	id S262170AbUDUNsd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Apr 2004 09:48:33 -0400
Date: Wed, 21 Apr 2004 21:52:01 +0800 (WST)
From: raven@themaw.net
To: Christoph Hellwig <hch@infradead.org>
cc: Andrew Morton <akpm@osdl.org>, viro@parcelfarce.linux.theplanet.co.uk,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.6-rc1-mm1
In-Reply-To: <20040421141901.B5551@infradead.org>
Message-ID: <Pine.LNX.4.58.0404212135520.3740@donald.themaw.net>
References: <20040418230131.285aa8ae.akpm@osdl.org> <20040419202538.A15701@infradead.org>
 <Pine.LNX.4.58.0404200911090.12229@wombat.indigo.net.au>
 <20040419182657.7870aee9.akpm@osdl.org> <20040421100835.A3577@infradead.org>
 <Pine.LNX.4.58.0404212035280.3740@donald.themaw.net> <20040421141901.B5551@infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam, SpamAssassin (score=-1.7, required 8,
	EMAIL_ATTRIBUTION, IN_REP_TO, NO_REAL_NAME, QUOTED_EMAIL_TEXT,
	REFERENCES, REPLY_WITH_QUOTES, USER_AGENT_PINE)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Apr 2004, Christoph Hellwig wrote:

> On Wed, Apr 21, 2004 at 08:39:59PM +0800, raven@themaw.net wrote:
> > While I understand the motive for not exporting the lock the question of 
> > how one should obtain vfsmount structs when needed remains?
> 
> You shouldn't.
> 

Shouldn't need them?

But your point is that they shouldn't need to be used and an different 
design is should be used, right.

Could make life hard for the automounter.
Possibly somewhat harder to solve the remaining limitations of autofs.
But I haven't got a clear enough picture of what's needed yet (still).

I guess your point is that these services should reside in the VFS proper?

Ian

