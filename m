Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263990AbTDOSsx (for <rfc822;willy@w.ods.org>); Tue, 15 Apr 2003 14:48:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263994AbTDOSsx 
	(for <rfc822;linux-kernel-outgoing>);
	Tue, 15 Apr 2003 14:48:53 -0400
Received: from cerebus.wirex.com ([65.102.14.138]:23033 "EHLO
	figure1.int.wirex.com") by vger.kernel.org with ESMTP
	id S263990AbTDOSsv (for <rfc822;linux-kernel@vger.kernel.org>); Tue, 15 Apr 2003 14:48:51 -0400
Date: Tue, 15 Apr 2003 11:56:34 -0700
From: Chris Wright <chris@wirex.com>
To: Chuck Ebbert <76306.1226@compuserve.com>
Cc: Stephen Smalley <sds@epoch.ncsc.mil>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [RFC][PATCH] Extended Attributes for Security Modules
Message-ID: <20030415115634.A24178@figure1.int.wirex.com>
Mail-Followup-To: Chuck Ebbert <76306.1226@compuserve.com>,
	Stephen Smalley <sds@epoch.ncsc.mil>,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <200304151436_MC3-1-3487-2164@compuserve.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200304151436_MC3-1-3487-2164@compuserve.com>; from 76306.1226@compuserve.com on Tue, Apr 15, 2003 at 02:33:53PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Chuck Ebbert (76306.1226@compuserve.com) wrote:
> Stephen Smalley wrote:
> 
> > In practice, I would
> > expect that any "stacking" of multiple security modules that use
> > security fields and xattr will actually involve creation of a new module
> > that integrates the logic of the individual modules.  This is preferable
> > anyway to ensure that the interactions among the security modules are
> > well understood, that the logic is combined in a sensible manner, and
> > that the individual logics can not subvert one another.
> 
>   On FreeBSD 5 you 'stack' the mac_biba and mac_mls modules to get both
> integrity and confidentiality, right?  Or is that something different?

It's a difference in implementation.  FreeBSD builds stacking directly into
the framework, whereas LSM makes stacking a policy decision for the module.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
