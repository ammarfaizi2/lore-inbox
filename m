Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265993AbUFOWHd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265993AbUFOWHd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jun 2004 18:07:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265987AbUFOWHd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jun 2004 18:07:33 -0400
Received: from fw.osdl.org ([65.172.181.6]:12425 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265994AbUFOWHL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jun 2004 18:07:11 -0400
Date: Tue, 15 Jun 2004 15:07:07 -0700
From: Chris Wright <chrisw@osdl.org>
To: Kyle Moffett <mrmacman_g4@mac.com>
Cc: David Howells <dhowells@redhat.com>, Blair Strang <bls@asterisk.co.nz>,
       Trond Myklebust <trond.myklebust@fys.uio.no>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: In-kernel Authentication Tokens (PAGs)
Message-ID: <20040615150707.B22989@build.pdx.osdl.net>
References: <1087282990.13680.13.camel@lade.trondhjem.org> <772741DF-BC19-11D8-888F-000393ACC76E@mac.com> <1087080664.4683.8.camel@lade.trondhjem.org> <D822E85F-BCC8-11D8-888F-000393ACC76E@mac.com> <1087084736.4683.17.camel@lade.trondhjem.org> <DD67AB5E-BCCF-11D8-888F-000393ACC76E@mac.com> <87smcxqqa2.fsf@asterisk.co.nz> <8666.1087292194@redhat.com> <3943FF92-BEFE-11D8-95EB-000393ACC76E@mac.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3943FF92-BEFE-11D8-95EB-000393ACC76E@mac.com>; from mrmacman_g4@mac.com on Tue, Jun 15, 2004 at 03:00:09PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Kyle Moffett (mrmacman_g4@mac.com) wrote:
> One thing that I would very much like to have is the ability to create 
> a new
> shell with a new keyring, such that I can still see and use the old 
> keyring,
> but I can create new keys without modifying the old keyring, even to the
> extent of masking out keys in the old keyring without modifying them for
> other processes.  From my brief glance at your patch, that's not a 
> feature you have implemented.

Sounds like a CLONE_KEYRING flag?

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
