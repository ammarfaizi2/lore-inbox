Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266233AbUJEXAy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266233AbUJEXAy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Oct 2004 19:00:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266252AbUJEXAy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Oct 2004 19:00:54 -0400
Received: from ozlabs.org ([203.10.76.45]:32659 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S266233AbUJEXAs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Oct 2004 19:00:48 -0400
Subject: Re: [RFC] ARM binutils feature churn causing kernel problems
From: Rusty Russell <rusty@rustcorp.com.au>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: Richard Earnshaw <Richard.Earnshaw@arm.com>,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Catalin Marinas <Catalin.Marinas@arm.com>,
       Sam Ravnborg <sam@ravnborg.org>, pmarques@grupopie.com
In-Reply-To: <20041005141452.B6910@flint.arm.linux.org.uk>
References: <20040927210305.A26680@flint.arm.linux.org.uk>
	 <20041001211106.F30122@flint.arm.linux.org.uk> <tnxllemvgi7.fsf@arm.com>
	 <1096931899.32500.37.camel@localhost.localdomain>
	 <loom.20041005T130541-400@post.gmane.org>
	 <20041005125324.A6910@flint.arm.linux.org.uk>
	 <1096981035.14574.20.camel@pc960.cambridge.arm.com>
	 <20041005141452.B6910@flint.arm.linux.org.uk>
Content-Type: text/plain
Message-Id: <1097016532.32500.357.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 06 Oct 2004 09:00:48 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-10-05 at 23:14, Russell King wrote:
> On Tue, Oct 05, 2004 at 01:57:15PM +0100, Richard Earnshaw wrote:
> > Why don't you pass s to is_arm_mapping_symbol and have it do the same
> > thing as you've done in get_ksymbol?
> 
> "sym_entry" is not an ELF symtab structure - it's a parsed version
> of the `nm' output, and as such does not contain the symbol type nor
> binding information.

I believe that Paulo (CC'd) ended up with a patch which included the
actual type information in /proc/kallsyms.  Paulo, what's the status of
that patch?

Rusty.
-- 
Anyone who quotes me in their signature is an idiot -- Rusty Russell

