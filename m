Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261426AbUDNQoM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Apr 2004 12:44:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264280AbUDNQoM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Apr 2004 12:44:12 -0400
Received: from wombat.indigo.net.au ([202.0.185.19]:62726 "EHLO
	wombat.indigo.net.au") by vger.kernel.org with ESMTP
	id S261426AbUDNQoA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Apr 2004 12:44:00 -0400
Date: Thu, 15 Apr 2004 00:48:41 +0800 (WST)
From: raven@themaw.net
To: viro@parcelfarce.linux.theplanet.co.uk
cc: Hugh Dickins <hugh@veritas.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] umount after bad chdir
In-Reply-To: <Pine.LNX.4.58.0404142352590.1480@donald.themaw.net>
Message-ID: <Pine.LNX.4.58.0404150047220.1480@donald.themaw.net>
References: <Pine.LNX.4.44.0404141241450.29568-100000@localhost.localdomain>
 <Pine.LNX.4.58.0404142009500.1537@donald.themaw.net>
 <20040414121026.GD31500@parcelfarce.linux.theplanet.co.uk>
 <Pine.LNX.4.58.0404142023460.1537@donald.themaw.net>
 <Pine.LNX.4.58.0404142308260.20568@donald.themaw.net>
 <20040414152420.GE31500@parcelfarce.linux.theplanet.co.uk>
 <Pine.LNX.4.58.0404142352590.1480@donald.themaw.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam, SpamAssassin (score=-1.7, required 8,
	EMAIL_ATTRIBUTION, IN_REP_TO, NO_REAL_NAME, QUOTED_EMAIL_TEXT,
	REFERENCES, REPLY_WITH_QUOTES, USER_AGENT_PINE)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Apr 2004 raven@themaw.net wrote:

> 
> But looking further I see that a LOOKUP_DIRECTORY flag is used only for 
> these two routines (excluding pivot_root) and when a trailing slash is 
> present in the path. I think that the if this flag is present then the 
> request will always want to look into the directory anyway, so if it's 
> an autofs4 mount point it should be mounted then. If this is the case I 
> can get this stuff into the fs module where it belongs.
> 

But it's not as simple as that after all ...

Ian

