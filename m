Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261792AbSJQHok>; Thu, 17 Oct 2002 03:44:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261825AbSJQHok>; Thu, 17 Oct 2002 03:44:40 -0400
Received: from cerebus.wirex.com ([65.102.14.138]:60399 "EHLO
	figure1.int.wirex.com") by vger.kernel.org with ESMTP
	id <S261792AbSJQHoj>; Thu, 17 Oct 2002 03:44:39 -0400
Date: Thu, 17 Oct 2002 00:41:35 -0700
From: Chris Wright <chris@wirex.com>
To: David Howells <dhowells@redhat.com>
Cc: Matt Reppert <arashi@arashi.yi.org>, Chris Wright <chris@wirex.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] AFS compile breakage in 2.5.43
Message-ID: <20021017004135.B26442@figure1.int.wirex.com>
Mail-Followup-To: David Howells <dhowells@redhat.com>,
	Matt Reppert <arashi@arashi.yi.org>, Chris Wright <chris@wirex.com>,
	linux-kernel@vger.kernel.org
References: <chris@wirex.com> <3845.1034840060@warthog.cambridge.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3845.1034840060@warthog.cambridge.redhat.com>; from dhowells@cambridge.redhat.com on Thu, Oct 17, 2002 at 08:34:20AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* David Howells (dhowells@cambridge.redhat.com) wrote:
> 
> > Yes, it's valid for newer compilers.  I have a similar patch that also
> > updates the varargs macro stuff used in AFS (and rxrpc) (for akpm's "crusty"
> > compilers ;-)
> 
> Can you try the attached patch please.

Works for me.  Cleans up the fs/afs/proc.c warnings as well.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
