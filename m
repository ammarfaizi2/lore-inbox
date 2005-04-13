Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261393AbVDMQTQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261393AbVDMQTQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Apr 2005 12:19:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261396AbVDMQTP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Apr 2005 12:19:15 -0400
Received: from fire.osdl.org ([65.172.181.4]:54993 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261393AbVDMQTB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Apr 2005 12:19:01 -0400
Date: Wed, 13 Apr 2005 09:18:12 -0700
From: Chris Wright <chrisw@osdl.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Jani Jaakkola <jjaakkol@cs.Helsinki.FI>, dhowells@redhat.com,
       linux-kernel@vger.kernel.org, stable@kernel.org
Subject: Re: [stable] Re: [PATCH] Fix reproducible SMP crash in security/keys/key.c
Message-ID: <20050413161812.GZ11199@shell0.pdx.osdl.net>
References: <Pine.LNX.4.58.0504122129510.3075@x40-4.cs.helsinki.fi> <20050413020246.37e77feb.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050413020246.37e77feb.akpm@osdl.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Andrew Morton (akpm@osdl.org) wrote:
> Jani Jaakkola <jjaakkol@cs.Helsinki.FI> wrote:
> >
> > SMP race handling is broken in key_user_lookup() in security/keys/key.c
> 
> This was fixed post-2.6.11.  Can you confirm that 2.6.12-rc2 works OK?
> 
> This is the patch we used.  It should go into -stable if it's not already
> there.

No, it's not in -stable, queued up, thanks.
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
