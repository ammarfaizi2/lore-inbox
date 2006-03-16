Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752219AbWCPH3T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752219AbWCPH3T (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Mar 2006 02:29:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752220AbWCPH3T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Mar 2006 02:29:19 -0500
Received: from mail.macqel.be ([194.78.208.39]:55565 "EHLO mail.macqel.be")
	by vger.kernel.org with ESMTP id S1752219AbWCPH3T (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Mar 2006 02:29:19 -0500
Date: Thu, 16 Mar 2006 08:29:02 +0100
From: Philippe De Muyter <phdm@mail.macqel.be>
To: Ralf Baechle <ralf@linux-mips.org>
Cc: Philippe De Muyter <phdm@macqel.be>, linux-kernel@vger.kernel.org,
       uclinux-dev@uclinux.org
Subject: Re: PATCH m68knommu clear frame-pointer in start_thread
Message-ID: <20060316082902.A13021@mail.macqel.be>
References: <200603151647.k2FGl7Y04736@mail.macqel.be> <20060315233810.GA4605@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20060315233810.GA4605@linux-mips.org>; from ralf@linux-mips.org on Wed, Mar 15, 2006 at 11:38:11PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 15, 2006 at 11:38:11PM +0000, Ralf Baechle wrote:
> On Wed, Mar 15, 2006 at 05:47:07PM +0100, Philippe De Muyter wrote:
> 
> > When trying to print the calltrace of a user process on m68knommu targets
> > gdb follows the frame-pointer en falls on unreachable adresses, because
> > the frame pointer is not properly initialised by start_thread. This patch
> > initialises the frame pointer to NULL in start_thread.
> > 
> > Signed-off-by: Philippe De Muyter <phdm@macqel.be>
> 
> You've posted an ed-style diff.  Quite a safe method to make sure nobody
> will read it.  Pleae repost a unified diff.
> 
>   Ralf

Oops

Thanks for your attention and your reply

I will resend it.

Philippe

-- 
Philippe De Muyter  phdm at macqel dot be  Tel +32 27029044
Macq Electronique SA  rue de l'Aeronef 2  B-1140 Bruxelles  Fax +32 27029077
