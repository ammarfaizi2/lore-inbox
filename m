Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750860AbWHKIi0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750860AbWHKIi0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Aug 2006 04:38:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750885AbWHKIi0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Aug 2006 04:38:26 -0400
Received: from mx2.suse.de ([195.135.220.15]:57569 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750860AbWHKIiZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Aug 2006 04:38:25 -0400
From: Andi Kleen <ak@suse.de>
To: "Jan Beulich" <jbeulich@novell.com>
Subject: Re: [PATCH for review] [127/145] i386: move kernel_thread_helper into entry.S
Date: Fri, 11 Aug 2006 10:38:17 +0200
User-Agent: KMail/1.9.3
Cc: linux-kernel@vger.kernel.org
References: <20060810 935.775038000@suse.de> <20060810193726.C133F13B8E@wotan.suse.de> <44DC5CE8.76E4.0078.0@novell.com>
In-Reply-To: <44DC5CE8.76E4.0078.0@novell.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608111038.17716.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> And this too - the value now in %eax has no relation with the
> value known by the caller of this routine (which doesn't expect
> any return from here anyway).

Ok, but somehow it needs to be annotiated so that the unwinder stops
and doesn't fall back. Can you please send a replacement patch that 
does this correctly? 

Thanks,
-Andi

