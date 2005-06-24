Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262947AbVFXPDJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262947AbVFXPDJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Jun 2005 11:03:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262955AbVFXPDJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Jun 2005 11:03:09 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.146]:38792 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262947AbVFXPDG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Jun 2005 11:03:06 -0400
Subject: Re: Finding what change broke ARM
From: Dave Hansen <haveblue@us.ibm.com>
To: Andy Whitcroft <apw@shadowen.org>
Cc: rmk+lkml@arm.linux.org.uk,
       Linux Kernel List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <20050624123549.GA10636@shadowen.org>
References: <20050624101951.B23185@flint.arm.linux.org.uk>
	 <20050624105328.C23185@flint.arm.linux.org.uk>
	 <20050624113258.A27909@flint.arm.linux.org.uk>
	 <20050624123549.GA10636@shadowen.org>
Content-Type: text/plain
Date: Fri, 24 Jun 2005 08:02:33 -0700
Message-Id: <1119625353.10155.3.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-06-24 at 13:35 +0100, Andy Whitcroft wrote:
> > Well, this fixes the problem, but I doubt people will like it.
> 
> This looks like a problem with the way the configuration options where
> changed to allow more than two memory models for SPARSMEM.  I think the
> right fix is the patch below.  Russell could you try this one instead.
> Dave, you did most of the work on the configuration side could you look
> this over (assuming it works!).

That looks like the right fix.  Trying to "select" and option that's no
longer selectable is certainly a problem.

-- Dave

