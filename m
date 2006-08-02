Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932275AbWHBWNX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932275AbWHBWNX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Aug 2006 18:13:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932277AbWHBWNX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Aug 2006 18:13:23 -0400
Received: from mx1.suse.de ([195.135.220.2]:46001 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932275AbWHBWNW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Aug 2006 18:13:22 -0400
From: Andi Kleen <ak@suse.de>
To: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: [patch] x86: rename is_at_popf(), add iret to tests and fix insn length
Date: Thu, 3 Aug 2006 00:12:07 +0200
User-Agent: KMail/1.9.3
Cc: Linus Torvalds <torvalds@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Albert Cahalan <acahalan@gmail.com>
References: <200608020937_MC3-1-C6D7-3958@compuserve.com>
In-Reply-To: <200608020937_MC3-1-C6D7-3958@compuserve.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608030012.07247.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 02 August 2006 15:35, Chuck Ebbert wrote:
> In-Reply-To: <200608021454.33685.ak@suse.de>
> 
> On Wed, 2 Aug 2006 14:54:33 +0200. Andi Kleen wrote:
> 
> > > is_at_popf() needs to test for the iret instruction as well as
> > > popf.  So add that test and rename it to is_setting_trap_flag().
> > 
> > Do you have a single real example where anybody is actually using IRET
> > in user space? 
> 
> No, but Albert Cahalan complained so I figured it should be fixed.

I suppose he just collected all the obscure FIXMEs in the code he could find.
Ok I merged it, but only because it is so little code.

-Andi
