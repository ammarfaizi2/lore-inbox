Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266027AbUFPABT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266027AbUFPABT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jun 2004 20:01:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266033AbUFPABT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jun 2004 20:01:19 -0400
Received: from fw.osdl.org ([65.172.181.6]:52704 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266027AbUFPABQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jun 2004 20:01:16 -0400
Date: Tue, 15 Jun 2004 17:01:09 -0700
From: Chris Wright <chrisw@osdl.org>
To: Kyle Moffett <mrmacman_g4@mac.com>
Cc: Chris Wright <chrisw@osdl.org>, Blair Strang <bls@asterisk.co.nz>,
       Trond Myklebust <trond.myklebust@fys.uio.no>,
       lkml <linux-kernel@vger.kernel.org>,
       David Howells <dhowells@redhat.com>
Subject: Re: In-kernel Authentication Tokens (PAGs)
Message-ID: <20040615170109.U21045@build.pdx.osdl.net>
References: <772741DF-BC19-11D8-888F-000393ACC76E@mac.com> <1087080664.4683.8.camel@lade.trondhjem.org> <D822E85F-BCC8-11D8-888F-000393ACC76E@mac.com> <1087084736.4683.17.camel@lade.trondhjem.org> <DD67AB5E-BCCF-11D8-888F-000393ACC76E@mac.com> <87smcxqqa2.fsf@asterisk.co.nz> <8666.1087292194@redhat.com> <3943FF92-BEFE-11D8-95EB-000393ACC76E@mac.com> <20040615150707.B22989@build.pdx.osdl.net> <880FEF02-BF26-11D8-95EB-000393ACC76E@mac.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <880FEF02-BF26-11D8-95EB-000393ACC76E@mac.com>; from mrmacman_g4@mac.com on Tue, Jun 15, 2004 at 07:48:41PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Kyle Moffett (mrmacman_g4@mac.com) wrote:
> On Jun 15, 2004, at 18:07, Chris Wright wrote:
> > * Kyle Moffett (mrmacman_g4@mac.com) wrote:
> >> One thing that I would very much like to have is the ability to create
> >> a new
> >> shell with a new keyring, such that I can still see and use the old
> >> keyring,
> >> but I can create new keys without modifying the old keyring, even to 
> >> the
> >> extent of masking out keys in the old keyring without modifying them 
> >> for
> >> other processes.  From my brief glance at your patch, that's not a
> >> feature you have implemented.
> > Sounds like a CLONE_KEYRING flag?
> 
> I think the two concepts are unrelated.  You should not be required
> to create a new thread/process/task in order to give yourself a

Just commenting on your desire to "create a new shell with a new
keyring.."  This had clone() implicit in it.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
