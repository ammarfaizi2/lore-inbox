Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266208AbUIIQ0W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266208AbUIIQ0W (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 12:26:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266218AbUIIQ0V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 12:26:21 -0400
Received: from fw.osdl.org ([65.172.181.6]:45789 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266208AbUIIQZM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 12:25:12 -0400
Date: Thu, 9 Sep 2004 09:24:57 -0700
From: Chris Wright <chrisw@osdl.org>
To: Makan Pourzandi <Makan.Pourzandi@ericsson.com>
Cc: linux-kernel@vger.kernel.org,
       Axelle Apvrille <axelle.apvrille@trusted-logic.fr>, serue@us.ibm.com,
       david.gordon@ericsson.com, gaspoucho@yahoo.com
Subject: Re: [ANNOUNCE] Release Digsig 1.3.1: kernel module for run-time authentication of binaries
Message-ID: <20040909092457.L1973@build.pdx.osdl.net>
References: <41407CF6.2020808@ericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <41407CF6.2020808@ericsson.com>; from Makan.Pourzandi@ericsson.com on Thu, Sep 09, 2004 at 11:55:34AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Makan Pourzandi (Makan.Pourzandi@ericsson.com) wrote:
> Hi all,
> 
> DSI development team would like to announce the release 1.3.1 of digsig.
> 
> This kernel module helps system administrators control Executable and
> Linkable Format (ELF) binary execution and library loading based on
> the presence of a valid digital signature.  The main functionality is
> to help system administrators distinguish applications he/she trusts
> (and therefore signs) from viruses, worms (and other nuisances). It is
> based on the Linux Security Module hooks.
> 
> The code is GPL and available from:
> http://sourceforge.net/projects/disec/, download digsig-1.3.1. For
> more documentation, please refer to disec.sourcefrge.net.
> 
> I hope that it'll be useful to you.
> 
> All bug reports and feature requests or general feedback are welcome
> (please CC me or disec-devel@lists.sourceforge.net in your answer or
> feedback to the mailing list).
> 
> Regards,
> Makan Pourzandi
> 
> Changes from Digsig release 0.2 announced in this mailing list:
> ================================================================
> 
>      - the verification of signatures for the shared binaries has been
>      added.
>      - added support for caching of signatures
>      - added documentation for digsig
>      - added support for revoked signatures
>      - support to avoid vulnerability for rewrite of shared
>      libraries

Could you elaborate on this one?

>      - use sysfs to connect to the module instead of the char device
>      - code clean up, and some bug fixes
> 
> Future works
> =============
> 
>      - improving the caching and revocation: it is currently tested
>        and will be sent out soon after stability testing

Should be helpful enough to cache result until thing's opened for
writing, or is that what you're doing now?

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
