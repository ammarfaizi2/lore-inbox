Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266534AbUIISA0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266534AbUIISA0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 14:00:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266366AbUIIR6X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 13:58:23 -0400
Received: from fw.osdl.org ([65.172.181.6]:183 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266427AbUIIRzf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 13:55:35 -0400
Date: Thu, 9 Sep 2004 10:55:20 -0700
From: Chris Wright <chrisw@osdl.org>
To: Makan Pourzandi <Makan.Pourzandi@ericsson.com>
Cc: Chris Wright <chrisw@osdl.org>, linux-kernel@vger.kernel.org,
       Axelle Apvrille <axelle.apvrille@trusted-logic.fr>, serue@us.ibm.com,
       david.gordon@ericsson.com, gaspoucho@yahoo.com
Subject: Re: [ANNOUNCE] Release Digsig 1.3.1: kernel module for run-time authentication of binaries
Message-ID: <20040909105520.U1924@build.pdx.osdl.net>
References: <41407CF6.2020808@ericsson.com> <20040909092457.L1973@build.pdx.osdl.net> <41409378.5060908@ericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <41409378.5060908@ericsson.com>; from Makan.Pourzandi@ericsson.com on Thu, Sep 09, 2004 at 01:31:36PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Makan Pourzandi (Makan.Pourzandi@ericsson.com) wrote:
> Hi Chris,
> 
> Chris Wright wrote:
> > * Makan Pourzandi (Makan.Pourzandi@ericsson.com) wrote:
> >>
> >>DSI development team would like to announce the release 1.3.1 of digsig.
> ...
> >>
> >>Changes from Digsig release 0.2 announced in this mailing list:
> >>================================================================
> >>
> >>     - the verification of signatures for the shared binaries has been
> >>     added.
> >>     - added support for caching of signatures
> >>     - added documentation for digsig
> >>     - added support for revoked signatures
> >>     - support to avoid vulnerability for rewrite of shared
> >>     libraries
> > 
> > 
> > Could you elaborate on this one?
> 
> We realized that when a shared library is opened by a binary it can 
> still be modified. To solve the problem, we block the write access to 
> the shared binary while it is loaded.

AFAICT, this means anybody with read access to a file can block all
writes.  This doesn't sound great.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
